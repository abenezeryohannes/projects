import { Injectable } from '@nestjs/common';
import { DataSource, IsNull, Not } from 'typeorm';
import { Util } from '../../../../../core/utils/util';
import { Notification } from '../../entities/notification.entity';
import { NotificationDto } from '../../dtos/notification.dto';
import { User } from '../../../../users/domain/entities/user.entity';
import { BatchResponse } from 'firebase-admin/lib/messaging/messaging-api';
import { chunk } from 'lodash';
import * as shell from 'shelljs';
import * as firebase from 'firebase-admin';
import * as adminConfig from '../../../../../linkoai-firebase-adminsdk.json';
import { Token } from '../../../../../auth/domain/entities/token.entity';
import { mapLimit } from 'async';

@Injectable()
export class NotificationsService {
  constructor(private readonly dataSource: DataSource) {
    firebase.initializeApp({
      credential: firebase.credential.cert(
        adminConfig as firebase.ServiceAccount,
      ),
    });
  }

  async find(request: any, query: any): Promise<[Notification[], number]> {
    const user = await this.dataSource
      .getRepository(User)
      .findOne({ where: { id: request.user.id } });
    return await this.dataSource.getRepository(Notification).findAndCount({
      where: { receiver: user },
      take: Util.getLimit(query),
      skip: Util.getOffset(query),
    });
  }

  async findAll(request: any, query: any): Promise<[Notification[], number]> {
    return await this.dataSource.getRepository(Notification).findAndCount({
      where: {},
      take: Util.getLimit(query),
      skip: Util.getOffset(query),
    });
  }

  async findAllUnseen(
    request: any,
    query: any,
  ): Promise<[Notification[], number]> {
    const user = await this.dataSource
      .getRepository(User)
      .findOne({ where: { id: request.user.id } });

    return await this.dataSource.getRepository(Notification).findAndCount({
      where: { receiver: user, seen: false },
      take: Util.getLimit(query),
      skip: Util.getOffset(query),
    });
  }

  async unseenCount(request: any): Promise<number> {
    const user = await this.dataSource
      .getRepository(User)
      .findOne({ where: { id: request.user.id } });
    const counted = await this.dataSource.getRepository(Notification).count({
      where: { seen: false, receiver: user },
    });
    return counted;
  }

  async seen(request: any): Promise<Notification | null> {
    if (request?.body?.id == null) return null;
    const notification = await this.dataSource
      .getRepository(Notification)
      .findOne({
        where: { id: request.body.id },
      });
    if (notification == null) return null;
    notification.seen = true;
    return await this.dataSource.getRepository(Notification).save(notification);
  }

  async clear(request: any): Promise<any> {
    const user = await this.dataSource
      .getRepository(User)
      .findOne({ where: { id: request.user.id } });
    return await this.dataSource.getRepository(Notification).delete({
      receiver: user,
    });
  }

  async add(
    request: any,
    receiver: User,
    notificationDto: NotificationDto,
  ): Promise<Notification> {
    const creator = await this.dataSource
      .getRepository(User)
      .findOne({ where: { id: request.user.id } });
    const notification: Notification = new Notification();
    notification.message = notificationDto.message;
    notification.arabicTitle = notificationDto.arabicTitle;
    notification.arabicMessage = notificationDto.arabicMessage;
    notification.title = notificationDto.title;
    notification.seen = notificationDto.seen;
    notification.owner = creator;
    notification.receiver = receiver;
    return await this.dataSource.getRepository(Notification).save(notification);
  }

  async addAll(request: any, notificationDto: NotificationDto): Promise<any> {
    //
    if (notificationDto.role == null) notificationDto.role = 'USER';
    const users = await this.dataSource.getRepository(User).find({
      where: { role: notificationDto.role ?? 'USER' },
    });
    const ops = [];
    users.forEach((user) => {
      ops.push(this.add(request, user, notificationDto));
    });
    return await Promise.all(ops);
  }

  public async SendMessage(
    request: any,
    notificationDto: NotificationDto,
    save: boolean,
  ): Promise<any> {
    const receiver =
      notificationDto.userId != null
        ? await this.dataSource
            .getRepository(User)
            .findOne({ where: { id: notificationDto.userId } })
        : null;

    const tokens =
      receiver != null
        ? await this.dataSource
            .getRepository(Token)
            .find({ where: { user: receiver } })
        : await await this.dataSource.getRepository(Token).find({
            where: {
              role: notificationDto.role ?? 'USER',
              fcmToken: Not(IsNull()),
            },
          });

    const messages = tokens.map(
      (t) =>
        new NotificationDto({
          fcm: t.fcmToken,
          title: notificationDto.title,
          arabicMessage: notificationDto.arabicMessage,
          arabicTitle: notificationDto.arabicTitle,
          message: notificationDto.message,
          seen: notificationDto.seen,
        }),
    );
    //const response: BatchResponse =
    //const response =
    await this.sendFirebaseMessages(messages, false);

    if (save || save == null) {
      await this.addAll(request, notificationDto);
    }
    // return {
    //   failureCount: response[0].failureCount,
    //   successCount: response[0].successCount,
    // };
    return true;
  }

  public async sendFirebaseMessages(
    firebaseMessages: NotificationDto[],
    dryRun?: boolean,
  ): Promise<BatchResponse> {
    const batchedFirebaseMessages = chunk(firebaseMessages, 500);

    const batchResponses = await mapLimit<NotificationDto[], BatchResponse>(
      batchedFirebaseMessages,
      3, // 3 is a good place to start
      async (
        groupedFirebaseMessages: NotificationDto[],
      ): Promise<BatchResponse> => {
        try {
          const tokenMessages: firebase.messaging.TokenMessage[] =
            groupedFirebaseMessages.map(({ message, title, fcm }) => ({
              notification: { title: title, body: message },
              android: {
                notification: {
                  title: title,
                  body: message,
                },
                priority: 'high',
              },
              token: fcm,
              apns: {
                payload: {
                  aps: {
                    'content-available': 1,
                  },
                },
              },
            }));

          return await this.sendAll(tokenMessages, dryRun);
        } catch (error) {
          return {
            responses: groupedFirebaseMessages.map(() => ({
              success: false,
              error,
            })),
            successCount: 0,
            failureCount: groupedFirebaseMessages.length,
          };
        }
      },
    );

    if (batchResponses == undefined || batchResponses == null)
      return {
        responses: [],
        successCount: 0,
        failureCount: 0,
      };
    return batchResponses.reduce(
      ({ responses, successCount, failureCount }, currentResponse) => {
        return {
          responses: responses.concat(currentResponse.responses),
          successCount: successCount + currentResponse.successCount,
          failureCount: failureCount + currentResponse.failureCount,
        };
      },
      {
        responses: [],
        successCount: 0,
        failureCount: 0,
      } as unknown as BatchResponse,
    );
  }

  public async sendAll(
    messages: firebase.messaging.TokenMessage[],
    dryRun?: boolean,
  ): Promise<BatchResponse> {
    if (process.env.ENV === 'DEV') {
      for (const { notification, token } of messages) {
        shell.exec(
          `echo '{ "aps": { "alert": ${JSON.stringify(
            notification,
          )}, "token": "${token}" } }' | xcrun simctl push booted com.konrad.linkoai -`,
        );
      }
    }
    return firebase.messaging().sendEach(messages, dryRun);
  }
}
