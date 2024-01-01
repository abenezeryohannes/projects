import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:rnginfra/main/injectable/getit.dart';
import 'package:rnginfra/src/core/widgets/big.text.button.dart';
import 'package:rnginfra/src/core/widgets/drop.down.rng.dart';
import 'package:rnginfra/src/core/widgets/loading.bar.dart';
import 'package:rnginfra/src/core/widgets/text.input.form.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/category.entity.dart';
import 'package:rnginfra/src/residents/visitors/domain/entities/help.request.type.dart';
import 'package:rnginfra/src/residents/visitors/presentation/helpdesk/controller/raise.complaint.controller.dart';

import '../widgets/add.images.form.dart';

@injectable
class RaiseCompliantPage extends StatefulWidget {
  const RaiseCompliantPage({super.key});

  @override
  State<RaiseCompliantPage> createState() => _RaiseCompliantPageState();
}

class _RaiseCompliantPageState extends State<RaiseCompliantPage> {
  late RaiseComplaintController raiseComplaintController;

  @override
  void initState() {
    raiseComplaintController = getIt<RaiseComplaintController>();
    raiseComplaintController.findCategories(limit: 100, page: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
        child: Obx(
      () => Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (raiseComplaintController.loading.value) const LoadingBar(),
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: TextInputForm(
                    // enabledBorderColor: Theme.of(context).colorScheme.secondary,
                    // enabledBorderWidth: 2,
                    initialValue:
                        raiseComplaintController.createComplaint.value.title,
                    textInputAction: TextInputAction.go,
                    focusedBorderColor: Theme.of(context).colorScheme.secondary,
                    placeholder: 'Title',
                    onChanged: (String? value) {
                      setState(() {
                        raiseComplaintController.createComplaint.value.title =
                            value;
                      });
                    }),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: TextInputForm(
                    minLines: 4,
                    maxLines: 8,
                    // enabledBorderColor: Theme.of(context).colorScheme.secondary,
                    // enabledBorderWidth: 2,
                    initialValue:
                        raiseComplaintController.createComplaint.value.body,
                    textInputAction: TextInputAction.go,
                    focusedBorderColor: Theme.of(context).colorScheme.secondary,
                    placeholder: 'Type your complaint here ....',
                    onChanged: (String? value) {
                      setState(() {
                        raiseComplaintController.createComplaint.value.body =
                            value;
                      });
                    }),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: DropDownRNG<CategoryEntity>(
                      title: 'Category',
                      items: raiseComplaintController.categories,
                      onSelected: (item) {
                        // print(raiseComplaintController.subCategories.toJson());

                        setState(() {
                          raiseComplaintController.selectedCategory.value =
                              item;
                          raiseComplaintController.subCategories.value = [item];
                          raiseComplaintController.categories
                              .where((p0) =>
                                  raiseComplaintController
                                          .selectedCategory.value !=
                                      null &&
                                  p0.parent_target_id ==
                                      raiseComplaintController
                                          .selectedCategory.value?.tid)
                              .toList();
                        });
                        // print(raiseComplaintController.subCategories.toJson());
                        raiseComplaintController.subCategories.refresh();
                      },
                      getOptionText: (dynamic item) {
                        return (item?.name as String).length > 15
                            ? (item?.name as String).substring(0, 15)
                            : item?.name;
                      }),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                  value: raiseComplaintController.urgent.value,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(3))),
                  onChanged: (bool? value) {
                    if (value != null) {
                      setState(() {
                        raiseComplaintController.urgent.value = value;
                      });
                    }
                  }),
              Text(
                'Is it Urgent?',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(
            height: 14,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Request Type',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    flex: 1,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio<HelpRequestType>(
                            value: HelpRequestType.UNIT_LEVEL,
                            groupValue: raiseComplaintController.requestType,
                            onChanged: (HelpRequestType? value) {
                              setState(() {
                                if (value != null) {
                                  raiseComplaintController.requestType = value;
                                }
                              });
                            }),
                        Text(
                          'Unit Level',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio<HelpRequestType>(
                            value: HelpRequestType.COMMUNITY_LEVEL,
                            groupValue: raiseComplaintController.requestType,
                            onChanged: (HelpRequestType? value) {
                              setState(() {
                                if (value != null) {
                                  raiseComplaintController.requestType = value;
                                }
                              });
                            }),
                        Text(
                          'Community Level',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                raiseComplaintController.requestType ==
                        HelpRequestType.UNIT_LEVEL
                    ? 'Visible your unit members only'
                    : 'Visible for all community',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          AddImagesForm(
            onLoadingChanged: (isLoading) {
              // setState(() {
              //   raiseComplaintController.loading.value = isLoading;
              // });
            },
            validator: () => null,
            placeholder: 'assets/icon/add_image.png',
            uploadImage: (String imgPath) {
              raiseComplaintController.uploadImage(
                  load: (loading) {
                    setState(() {
                      raiseComplaintController.loading.value = loading;
                    });
                  },
                  onUploaded: (imageDTO) {
                    setState(() {
                      raiseComplaintController.images.add(imageDTO);
                    });
                  },
                  file: imgPath);
            },
            bulkImages: raiseComplaintController.images,
          ),
          const SizedBox(
            height: 60,
          ),
          Obx(() => BigTextButton(
                onClick: () {
                  raiseComplaintController.save(
                      context,
                      (bool lo) => {
                            setState(() {
                              raiseComplaintController.loading.value = lo;
                            })
                          });
                },
                isLoading: raiseComplaintController.loading.value,
                text: 'Submit Complaint',
                fontSize: 18,
                fontWight: FontWeight.bold,
                cornerRadius: 30,
                borderWidth: 2,
                borderColor: Theme.of(context).colorScheme.secondary,
                backgroudColor: Theme.of(context).colorScheme.secondary,
                textColor: Theme.of(context).colorScheme.onBackground,
                padding: const EdgeInsets.symmetric(vertical: 18),
                horizontalMargin:
                    const EdgeInsets.only(left: 10, right: 10, bottom: 20),
              ))
        ],
      ),
    ));
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
        'Raise Complaint',
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }
}
