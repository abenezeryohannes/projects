import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:linko/injectable/getit.dart';
import 'package:linko/src/appcore/dtos/wrapper.dto.dart';
import 'package:linko/src/application/chat/chat.company.list.controller.dart';
import 'package:linko/src/domain/chat/entities/chat.entity.dart';

import '../../../appcore/errors/exceptions.dart';
import '../../../appcore/errors/failure.dart';
import '../../../appcore/widgets/show.error.dart';
import '../../../domain/company/entities/company.entity.dart';
import '../../company/business.card.dart';

class ChatCompanyList extends StatefulWidget {
  const ChatCompanyList({
    super.key,
    required this.controller,
    required this.chat,
  });
  final ScrollController controller;
  final ChatEntity chat;
  @override
  State<ChatCompanyList> createState() => _ChatCompanyListState();
}

class _ChatCompanyListState extends State<ChatCompanyList> {
  late ChatCompanyListController controller;
  @override
  void initState() {
    controller = getIt<ChatCompanyListController>();
    if (widget.chat.data != null) {
      WrapperDto<int> wrapperDto =
          WrapperDto<int>.fromJson(json.decode(widget.chat.data!));
      controller.pagingController.addPageRequestListener((pageKey) {
        controller.findAll(page: pageKey, ids: wrapperDto.datas ?? []);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        PagedListView<int, CompanyEntity?>(
          shrinkWrap: true,
          padding: const EdgeInsets.all(0),
          physics: const ClampingScrollPhysics(),
          pagingController: controller.pagingController,
          builderDelegate: PagedChildBuilderDelegate<CompanyEntity?>(
              noItemsFoundIndicatorBuilder: (context) => Padding(
                  padding: const EdgeInsets.only(top: 200.0),
                  child: ShowError(
                      failure:
                          NoDataFailure(message: NoDataException().message))),
              firstPageErrorIndicatorBuilder: (_) => Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: ShowError(
                        failure: controller.pagingController.error as Failure),
                  ),
              firstPageProgressIndicatorBuilder: (_) => ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 0.0),
                    children: const [
                      BusinessCard(),
                      BusinessCard(),
                      BusinessCard(),
                      BusinessCard(),
                      BusinessCard(),
                      BusinessCard(),
                    ],
                  ),
              itemBuilder: (context, item, index) => BusinessCard(
                    company: item,
                  )),
        ),
        Obx(() => Padding(
              padding: const EdgeInsets.only(right: 20, bottom: 10),
              child: controller.isLastPage.value
                  ? const SizedBox()
                  : TextButton(
                      onPressed: () {
                        if (!controller.isLastPage.value) {
                          controller.pagingController
                              .notifyPageRequestListeners(
                                  controller.nextPageKey.value);
                        }
                      },
                      child: Text(
                        'Load More',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.blueAccent),
                      )),
            ))
      ],
    );
  }
}
