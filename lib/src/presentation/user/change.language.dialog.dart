import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class ChangeLanguageDialog extends StatefulWidget {
  const ChangeLanguageDialog({super.key});

  @override
  State<ChangeLanguageDialog> createState() => _ChangeLanguageDialogState();
}

class _ChangeLanguageDialogState extends State<ChangeLanguageDialog> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 10, top: 20, left: 10, right: 10),
                child: _item(
                    ('english').tr,
                    'en-US',
                    Get.locale != null &&
                        Get.locale!.languageCode.toLowerCase().contains('en'),
                    context),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 20, top: 20, left: 20, right: 20),
                child: _item(
                    ('arabic').tr,
                    'ar-KW',
                    Get.locale != null &&
                        Get.locale!.languageCode.toLowerCase().contains('ar'),
                    context),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _item(String name, String code, bool selected, BuildContext context) {
    return InkWell(
      onTap: () async {
        setState(() {
          final locale = Locale(code.split('-')[0], code.split('-')[1]);
          GetStorage().write('lang', code.split('-')[0]);
          Get.updateLocale(locale);
          // final result = ref.refresh(localeProvider);
          // print(result);
          // context.setLocale(Locale('ar', 'KW'));
        });
      },
      child: Container(
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * (7 / 12),
            minWidth: MediaQuery.of(context).size.width * (7 / 12)),
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: selected
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).cardColor),
        child: Text(
          name,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: selected
                  ? Theme.of(context).colorScheme.onSecondary
                  : Theme.of(context).colorScheme.onBackground),
        ),
      ),
    );
  }
}
