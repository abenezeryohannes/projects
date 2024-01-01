import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:get/get.dart';
import 'package:rnginfra/main/injectable/getit.dart';
import 'package:rnginfra/src/core/widgets/custom.shimmer.dart';
import 'package:rnginfra/src/residents/visitors/presentation/helpdesk/controller/complaint.controller.dart';
import 'package:rnginfra/src/residents/visitors/presentation/helpdesk/page/comment.page.dart';

class ComplaintPage extends StatefulWidget {
  const ComplaintPage({super.key, required this.id});
  final int id;
  @override
  State<ComplaintPage> createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  late ComplaintController controller;
  int count = 0;
  @override
  void initState() {
    controller = getIt<ComplaintController>();
    controller.find(id: widget.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        padding: const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 20),
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return Obx(
      () => Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Row(
              children: [
                Flexible(
                  child: CustomShimmer(
                    show: controller.complaint.value == null,
                    child: Text(
                      controller.complaint.value?.title ??
                          '............................',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          backgroundColor: controller.complaint.value == null
                              ? Theme.of(context).highlightColor
                              : Colors.transparent,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (controller.complaint.value == null ||
                    (controller.complaint.value?.field_complaint_urgent ??
                        false))
                  CustomShimmer(
                    show: controller.complaint.value == null,
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 6, bottom: 6),
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: Text(
                        'Urgent',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.red,
                              backgroundColor:
                                  controller.complaint.value == null
                                      ? Theme.of(context).highlightColor
                                      : Colors.transparent,
                            ),
                      ),
                    ),
                  ),
                const SizedBox(
                  width: 10,
                ),
                CustomShimmer(
                  show: controller.complaint.value == null,
                  child: Text(
                      controller.complaint.value?.field_complaint_category ??
                          '....................................',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            backgroundColor: controller.complaint.value == null
                                ? Theme.of(context).highlightColor
                                : Colors.transparent,
                          )),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 30, bottom: 8.0, top: 8, right: 20),
            child: Row(
              children: [
                Flexible(
                  child: CustomShimmer(
                    show: controller.complaint.value == null,
                    child: Text(
                      controller.complaint.value?.body ??
                          '...............................................................................................................',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          backgroundColor: controller.complaint.value == null
                              ? Theme.of(context).highlightColor
                              : Colors.transparent,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Wrap(
              alignment: WrapAlignment.start,
              direction: Axis.horizontal,
              runSpacing: 10,
              spacing: 10,
              children: [..._images()],
            ),
          ),
          // if ((controller.complaint.value?.comment_count ?? 0) > 0)
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 10.0, top: 10),
            child: Row(
              children: [
                Flexible(
                  child: CustomShimmer(
                    show: controller.complaint.value == null,
                    child: Text(
                      'Comments',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          backgroundColor: controller.complaint.value == null
                              ? Theme.of(context).highlightColor
                              : Colors.transparent,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: CommentPage(
              id: widget.id.toString(),
              page: false,
            ),
          )
          // AddImagesForm(
          //   onLoadingChanged: (isLoading) {},
          //   validator: () => null,
          //   placeholder: 'assets/icon/add_image.png',
          //   uploadImage: (String imgPath) {},
          //   bulkImages: controller.complaint.value?.field_image
          //           ?.map((e) => BulkImageDto(
          //                 img: e,
          //               ))
          //           .toList() ??
          //       [],
          // ),
        ],
      ),
    );
  }

  Widget fullScreenImage(String img) => FullScreenWidget(
        disposeLevel: DisposeLevel.Medium,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            img,
            fit: BoxFit.contain,
            alignment: Alignment.center,
          ),
        ),
      );

  List<Widget> _images() {
    if (controller.complaint.value == null) {
      return [
        CustomShimmer(
          show: controller.complaint.value == null,
          child: Container(
              width: 60,
              height: 60,
              padding: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
              decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              )),
        ),
        CustomShimmer(
          show: controller.complaint.value == null,
          child: Container(
              width: 60,
              height: 60,
              padding: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
              decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              )),
        ),
        CustomShimmer(
          show: controller.complaint.value == null,
          child: Container(
              width: 60,
              height: 60,
              padding: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
              decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              )),
        )
      ];
    } else if (controller.complaint.value?.field_image == null) {
      return [];
    }
    List<Widget> response = [];
    controller.complaint.value?.field_image?.forEach((element) {
      response.add(Container(
        width: 60,
        height: 60,
        padding: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.3)),
        child: fullScreenImage(element),
      ));
    });
    return response;
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0.5,
      leading: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Icon(
          Icons.chevron_left,
          size: 42,
          color: Theme.of(context).disabledColor,
        ),
      ),
      title: Text(
        'Raised Complaint',
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }
}
