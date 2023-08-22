import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChooseAddingGuestMethodDialog extends StatefulWidget {
  const ChooseAddingGuestMethodDialog({super.key});

  @override
  State<ChooseAddingGuestMethodDialog> createState() =>
      _ChooseAddingGuestMethodDialogState();
}

class _ChooseAddingGuestMethodDialogState
    extends State<ChooseAddingGuestMethodDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Material(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width * (8 / 12),
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.all(Radius.circular(50))),
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back<String>(result: 'qr');
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        padding: const EdgeInsets.only(
                            top: 30.0, bottom: 30, left: 20, right: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.qr_code,
                              size: 48,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Qr Code',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.back<String>(result: 'text');
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        padding: const EdgeInsets.only(
                            top: 30.0, bottom: 30, left: 20, right: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.text_fields,
                              size: 48,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Pass Code',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
            )));
  }
}
