import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:linko/src/appcore/network/api.dart';
import 'package:linko/src/appcore/widgets/big.text.button.dart';
import 'package:linko/src/appcore/widgets/editable.text.form.dart';
import 'package:linko/src/appcore/widgets/loading.bar.dart';
import 'package:linko/src/application/user/profile.controller.dart';
import '../../../injectable/getit.dart';
import '../../appcore/widgets/image.form.dart';
import '../../infrastructure/user/dtos/user.dto.dart';
import '../chat/widgets/chat.app.bar.dart';

class ProfileBottomSheet extends StatefulWidget {
  const ProfileBottomSheet({super.key});

  @override
  State<ProfileBottomSheet> createState() => _ProfileBottomSheetState();
}

class _ProfileBottomSheetState extends State<ProfileBottomSheet> {
  late ProfileController controller;
  bool _editing = true;

  @override
  void initState() {
    controller = getIt<ProfileController>();
    controller.find(local: true);
    super.initState();
  }

  late List<Widget> states;
  late List<Widget> statesOnEdit;

  Widget _toggleBeforeEditing() {
    return ToggleButtons(
      direction: Axis.horizontal,
      onPressed: (int index) {
        setState(() {
          switch (index) {
            case 0:
              if (_editing) {
                _save();
              } else {
                _cancel();
              }
              break;
            case 1:
              if (_editing) {
                _cancel();
              } else {
                _edit();
              }
              break;
          }
        });
      },
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      selectedBorderColor: Colors.red[700],
      selectedColor: Colors.white,
      fillColor: Colors.red[200],
      color: Colors.red[400],
      constraints: const BoxConstraints(
        minHeight: 40.0,
        minWidth: 80.0,
      ),
      isSelected: _editing ? [_editing, !_editing] : [_editing, !_editing],
      children: _editing ? statesOnEdit : states,
    );
  }

  @override
  Widget build(BuildContext context) {
    statesOnEdit = <Widget>[Text(('save').tr), Text(('cancel').tr)];
    states = <Widget>[
      Text(('view').tr),
      Text(('edit').tr),
    ];

    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * (6 / 12),
        padding: const EdgeInsets.only(bottom: 34),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: Theme.of(context).scaffoldBackgroundColor),
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Obx(() => LoadingBar(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 2),
                            show: controller.loading.value,
                          )),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 60,
                        height: 5,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            color: Theme.of(context).disabledColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                      ),
                    ),
                    ..._body(context)
                  ]),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(right: 0, bottom: 20.0),
                  child: BigTextButton(
                    onClick: () {
                      _save();
                    },
                    backgroudColor: Theme.of(context).colorScheme.secondary,
                    borderColor: Theme.of(context).colorScheme.secondary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    cornerRadius: 20,
                    horizontalMargin: EdgeInsets.symmetric(
                        horizontal:
                            MediaQuery.of(context).size.width * (2 / 12)),
                    text: 'save'.tr,
                  ),
                ),
              )
            ],
          ),
        ));
  }

  void _edit() {
    setState(() {
      _editing = true;
    });
  }

  void _cancel() {
    setState(() {
      _editing = false;
    });
  }

  void _save() async {
    ChatAppBar.refresh = true;
    await controller.save(userDto: controller.userDto.value!);
    await controller.save(userDto: controller.userDto.value!);
    // _cancel();
  }

  List<Widget> _body(BuildContext context) {
    return [
      const SizedBox(
        height: 20,
      ),
      Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ImageForm(
                image: Api.getMedia(
                    controller.user.value?.avatar ?? 'icon/user.png'),
                width: 120,
                height: 120,
                radius: 500,
                editable: _editing,
                isLoading: (val) {
                  setState(() {
                    controller.loading.value = val;
                  });
                },
                localImage: controller.userDto.value?.localImage,
                iconSize: 32,
                onUpload: (String localImage) async {
                  setState(() {
                    controller.userDto.value ??=
                        UserDto.fromEntity(controller.user.value);
                    controller.userDto.value?.localImage = localImage;
                  });
                },
                onSave: () async {
                  // await controller.save(userDto: controller.userDto.value!);
                },
              ),
            ],
          )),
      const SizedBox(
        height: 16,
      ),
      Obx(
        () => Text(
          controller.user.value?.fullName ?? controller.name.value,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      const SizedBox(
        height: 30,
      ),
      Obx(
        () => EditableTextForm(
          controller.name.value.tr,
          onSaveClicked: (val) async {
            ChatAppBar.refresh = true;
            if (val != null) {
              setState(() {
                controller.name.value = val;
                controller.userDto.value ??=
                    UserDto.fromEntity(controller.user.value);
                controller.userDto.value?.fullName = val;
              });
              // await controller.save(userDto: controller.userDto.value!);
            }
          },
          editable: _editing,
          editing: _editing,
          placeholder: 'change_your_name'.tr,
          textEditorWidth: MediaQuery.of(context).size.width * (8 / 12),
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
    ];
  }

  // Widget _changeLocales(BuildContext context) {
  // return DropdownButton<Locale>(
  //   value: context.locale,
  //   icon: const Padding(
  //     padding: EdgeInsets.fromLTRB(3.0, 0, 0, 0),
  //     child: Icon(Icons.arrow_downward),
  //   ),
  //   underline: const SizedBox(height: 0),
  //   elevation: 16,
  //   items:
  //       context.supportedLocales.map<DropdownMenuItem<Locale>>((Locale loc) {
  //     return DropdownMenuItem<Locale>(
  //         value: loc, child: Text((loc.languageCode)));
  //   }).toList(),
  //   onChanged: (Locale? newValue) {
  //     setState(() {
  //       if (newValue != null) context.setLocale(newValue);
  //     });
  //   },
  // );
  // }
}
