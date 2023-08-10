import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:linko/src/appcore/network/api.dart';
import 'package:linko/src/appcore/widgets/editable.text.form.dart';
import 'package:linko/src/appcore/widgets/loading.bar.dart';
import 'package:linko/src/application/user/profile.controller.dart';
import '../../../injectable/getit.dart';
import '../../appcore/widgets/image.form.dart';
import '../../infrastructure/user/dtos/user.dto.dart';

class ProfileBottomSheet extends StatefulWidget {
  const ProfileBottomSheet({super.key});

  @override
  State<ProfileBottomSheet> createState() => _ProfileBottomSheetState();
}

class _ProfileBottomSheetState extends State<ProfileBottomSheet> {
  late ProfileController controller;
  bool _editing = false;

  @override
  void initState() {
    controller = getIt<ProfileController>();
    controller.find(local: true);
    super.initState();
  }

  final List<Widget> states = <Widget>[
    Text('View'),
    Text('Edit'),
  ];
  final List<Widget> statesOnEdit = <Widget>[Text('Save'), Text('Cancel')];

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
                  child: _toggleBeforeEditing(),
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
    await controller.save(userDto: controller.userDto.value!);
    await controller.save(userDto: controller.userDto.value!);
    _cancel();
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
                    controller.user.value?.avatar ?? 'img/placeholder.jpg'),
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
        height: 30,
      ),
      Obx(
        () => EditableTextForm(
          controller.user.value?.fullName ?? 'Full Name',
          onSaveClicked: (val) async {
            if (val != null) {
              controller.userDto.value ??=
                  UserDto.fromEntity(controller.user.value);
              controller.userDto.value?.fullName = val;
              // await controller.save(userDto: controller.userDto.value!);
            }
          },
          editable: _editing,
          textEditorWidth: 180,
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

  Widget _changeLocales(BuildContext context) {
    return DropdownButton<Locale>(
      value: context.locale,
      icon: const Padding(
        padding: EdgeInsets.fromLTRB(3.0, 0, 0, 0),
        child: Icon(Icons.arrow_downward),
      ),
      underline: const SizedBox(height: 0),
      elevation: 16,
      items:
          context.supportedLocales.map<DropdownMenuItem<Locale>>((Locale loc) {
        return DropdownMenuItem<Locale>(
            value: loc, child: Text(context.tr(loc.languageCode)));
      }).toList(),
      onChanged: (Locale? newValue) {
        setState(() {
          if (newValue != null) context.setLocale(newValue);
        });
      },
    );
  }
}
