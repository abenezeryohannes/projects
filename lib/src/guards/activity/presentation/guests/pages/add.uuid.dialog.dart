import 'package:flutter/material.dart';
import 'package:rnginfra/src/core/widgets/loading.bar.dart';

import '../../../../../../main/injectable/getit.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/widgets/app.snackbar.dart';
import '../../../../../core/widgets/text.input.form.dart';
import '../controller/add.guest.activity.controller.dart';

class AddUUIDDialog extends StatefulWidget {
  const AddUUIDDialog({super.key});

  @override
  State<AddUUIDDialog> createState() => _AddUUIDDialogState();
}

class _AddUUIDDialogState extends State<AddUUIDDialog> {
  String? text = '';
  bool loading = false;

  void _postScan(String qr) async {
    try {
      setState(() {
        loading = true;
      });
      await getIt<AddGuestActivityController>().checkGuestActivity(uuid: qr);
      //Get.back<String>(result: 'reload');
      // ignore: use_build_context_synchronously
      Navigator.maybePop<String>(context, 'reload');
    } catch (e) {
      AppSnackBar.failure(failure: Failure(message: e.toString()));
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Material(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.all(Radius.circular(50))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (loading)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: LoadingBar(),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30.0, bottom: 30, left: 35, right: 20),
                    child: Text(
                      'Enter Visitor Entrance Pass Code',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ),
                  SizedBox(
                    // width: MediaQuery.of(context).size.width * (6 / 12),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 24, right: 24),
                      child: TextInputForm(
                        radius: 10,
                        elevation: 0,
                        fillColor: Colors.transparent,
                        focusedBorderColor:
                            Theme.of(context).colorScheme.secondary,
                        focusedBorderWidth: 2,
                        initialValue: text,
                        validator: (val) => (val?.length ?? 0) < 4
                            ? 'Must be at least 3 characters!'
                            : null,
                        onChanged: (String val) {
                          setState(() {
                            text = val;
                          });
                        },
                        placeholder: 'Pass code',
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 50, right: 10.0, bottom: 10),
                        child: TextButton(
                            onPressed: () {
                              if (text == null || text!.trim().isEmpty) {
                              } else {
                                _postScan(text!);
                              }
                            },
                            child: Text(
                              'Add',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            )));
  }
}
