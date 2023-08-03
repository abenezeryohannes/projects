import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:linko/src/appcore/network/api.dart';
import 'package:linko/src/appcore/widgets/big.text.button.dart';
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

  @override
  void initState() {
    controller = getIt<ProfileController>();
    controller.find(local: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * (5 / 12),
        padding: const EdgeInsets.only(bottom: 34),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: Theme.of(context).scaffoldBackgroundColor),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Obx(() => LoadingBar(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 2),
                    show: controller.loading.value,
                  )),
              Container(
                width: 60,
                height: 5,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: Theme.of(context).disabledColor,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
              ),
              ..._body(context)
            ]));
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
                  await controller.save(userDto: controller.userDto.value!);
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
              await controller.save(userDto: controller.userDto.value!);
            }
          },
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
      // _changeLocales(context),
      // Form(
      // key: _formKey,
      // child:

      // ),
      // Row(
      //   mainAxisSize: MainAxisSize.min,
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     // Text(
      //     //   'Language:  ',
      //     //   style: Theme.of(context).textTheme.bodySmall,
      //     // ),
      //     // const SizedBox(
      //     //   height: 10,
      //     // ),
      //     Text(
      //       'English',
      //       style: Theme.of(context).textTheme.bodySmall,
      //     ),
      //   ],
      // )
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
