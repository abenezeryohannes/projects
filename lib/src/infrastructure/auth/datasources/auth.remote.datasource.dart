import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';
import 'package:linko/src/domain/user/entities/user.entity.dart';

import '../../../appcore/errors/exceptions.dart';
import '../../../appcore/network/api.dart';
import '../../../domain/auth/entities/i.firebase.entity.dart';

@singleton
class AuthRemoteDataSource {
  late http.Client client;

  AuthRemoteDataSource({required this.client});

  Future<IFirebaseAuthEntity?>? verifyPhoneNumber(
      IFirebaseAuthEntity firebaseDto, bool resend) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: firebaseDto.country!.dial_code + firebaseDto.phoneNumber,
      verificationCompleted: (cred) => firebaseDto.onVerificationComplete(cred),
      verificationFailed: (exc) => {firebaseDto.onVerificationFailed(exc)},
      codeSent: (String verificationId, int? resendToken) {
        firebaseDto.verificationId = verificationId;
        firebaseDto.resendToken = resendToken;
        firebaseDto.onCodeSent(verificationId, resendToken);
      },
      // timeout: const Duration(seconds: 120),
      forceResendingToken: resend ? firebaseDto.resendToken : null,
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationId = firebaseDto.verificationId;
        firebaseDto.onCodeAutoRetrievalTimeout(verificationId);
      },
    );
    return firebaseDto;
  }

  Future<IFirebaseAuthEntity?>? confirmPhoneConfirmationCode(
      IFirebaseAuthEntity firebaseDto) async {
    if (firebaseDto.verificationId.isEmpty) return null;

    firebaseDto.phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: firebaseDto.verificationId,
        smsCode: firebaseDto.confirmationCode);

    UserCredential cred = await FirebaseAuth.instance
        .signInWithCredential(firebaseDto.phoneAuthCredential!);

    firebaseDto.credential = cred.credential;
    firebaseDto.user = cred.user;
    return firebaseDto;
  }

  Future<bool?>? signOut(IFirebaseAuthEntity? firebaseDto) async {
    http.Response response = await client.post(Api.request('auth/logout'),
        headers: Api.postHeader(GetStorage().read('token')));
    WrapperDto wrapper = WrapperDto.fromJson(json.decode(response.body));
    // switch (response.statusCode) {
    //   case 200:
    //   case 201:
    // if (firebaseDto.user == null) return true;
    await FirebaseAuth.instance.signOut();
    GetStorage().write('token', null);
    return FirebaseAuth.instance.currentUser == null;
    //   default:
    //     throw UnExpectedException(message: wrapper.message);
    // }
  }

  Future<WrapperDto<UserEntity>?> signup({required String phoneNumber}) async {
    if (FirebaseAuth.instance.currentUser?.uid == null) {
      return null;
    }
    //body
    Map<String, String> body = <String, String>{};

    body.addEntries({'phoneNumber': phoneNumber}.entries);
    ;

    body.addEntries({
      'fcmToken': (await FirebaseAuth.instance.currentUser?.getIdToken()) ?? ''
    }.entries);

    body.addEntries(
        {'UID': FirebaseAuth.instance.currentUser?.uid ?? ''}.entries);

    http.Response response = await client.post(Api.request('auth/signup'),
        body: body, headers: Api.postHeader(''));

    WrapperDto<UserEntity> wrapper =
        WrapperDto<UserEntity>.fromJson(json.decode(response.body));

    switch (response.statusCode) {
      case 200:
      case 201:
        return wrapper;
      default:
        throw UnExpectedException(message: wrapper.message);
    }
  }
}
