import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rnginfra/src/core/domain/entities/visitation.entity.dart';
import 'package:share_screenshot_widget/share_screenshot_widget.dart';

import 'package:flutter/services.dart';
import 'package:rnginfra/src/core/widgets/big.text.button.dart';

class VisitorAddedDialog extends StatefulWidget {
  const VisitorAddedDialog({super.key, this.visitation});
  final VisitationEntity? visitation;
  @override
  State<VisitorAddedDialog> createState() => _VisitorAddedDialogState();
}

class _VisitorAddedDialogState extends State<VisitorAddedDialog> {
  GlobalKey globalKey = GlobalKey();
  bool loading = false;
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ShareTextAsImage(
                globalKey: globalKey,
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  margin: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      QrImageView(
                        data: widget.visitation?.uuid ?? '',
                        version: 3,
                        size: 150,
                        gapless: false,
                        errorStateBuilder: (cxt, err) {
                          return const Center(
                            child: Text(
                              'Uh oh! Something went wrong try again later...',
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, bottom: 20, left: 20, right: 20),
                        child: Text(
                          widget.visitation?.uuid ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          'Residential Entrance Pass Code',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 20, right: 20),
                        child: Text(
                          'Your guests (visitors) can use this QR code to be granted access to enter at the gate. Enjoy a smoother check-in process and enhanced security.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                    ],
                  ),
                ),
              ),
              BigTextButton(
                  onClick: () async {
                    setState(() {
                      loading = true;
                    });
                    try {
                      shareWidgets(globalKey: globalKey);
                    } catch (_) {
                    } finally {
                      setState(() {
                        loading = false;
                      });
                    }
                  },
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  horizontalMargin: const EdgeInsets.symmetric(horizontal: 30),
                  cornerRadius: 20,
                  backgroudColor: Theme.of(context).cardColor,
                  borderColor: Theme.of(context).cardColor,
                  textWidget: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.share,
                        size: 24,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Share',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
