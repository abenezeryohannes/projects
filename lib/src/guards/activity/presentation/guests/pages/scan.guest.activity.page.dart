import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../../../core/animations/delayed.animation.dart';
import '../../../../../core/widgets/custom.shimmer.dart';
import '../../../../../core/widgets/loading.bar.dart';
import 'add.uuid.dialog.dart';

class ScanGuestActivityPage extends StatefulWidget {
  const ScanGuestActivityPage({super.key});

  @override
  State<ScanGuestActivityPage> createState() => _ScanGuestActivityPageState();
}

class _ScanGuestActivityPageState extends State<ScanGuestActivityPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  late bool uploading = false;
  String status = 'Scanning';

  @override
  void initState() {
    super.initState();
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.amber,

      body: SafeArea(
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Column(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Stack(
                    children: [
                      QRView(
                        key: qrKey,
                        onQRViewCreated: (x) => _onQRViewCreated(x, context),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: Colors.black.withOpacity(0.3),
                                    width: MediaQuery.of(context).size.height *
                                        (2 / 12)),
                                bottom: BorderSide(
                                    color: Colors.black.withOpacity(0.3),
                                    width: MediaQuery.of(context).size.height *
                                        (2 / 12)),
                                right: BorderSide(
                                    color: Colors.black.withOpacity(0.3),
                                    width: MediaQuery.of(context).size.width *
                                        (2 / 12)),
                                left: BorderSide(
                                    color: Colors.black.withOpacity(0.3),
                                    width: MediaQuery.of(context).size.width *
                                        (2 / 12)))),
                        child: Container(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    // padding: const EdgeInsets.only(top: 10, bottom: 10),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: (result == null)
                        ? InkWell(
                            onTap: () {
                              _postScan('127031d6-ccc1-43ea-8a82-7d4ae9670db1',
                                  context);
                            },
                            child: CustomShimmer(
                              show: true,
                              baseColor: Colors.grey.shade700,
                              highlightColor: Colors.grey.shade300,
                              child: Text(status,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                            ),
                          )
                        : Text(
                            status,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.background,
                child: IconButton(
                    onPressed: () {
                      Navigator.maybePop(context);
                    },
                    // color: Theme.of(context).colorScheme.secondary,
                    icon: Icon(
                      Icons.chevron_left,
                      color: Theme.of(context).colorScheme.onBackground,
                    )),
              ),
            ),
            if (uploading)
              LoadingBar(
                backColor: Theme.of(context).scaffoldBackgroundColor,
                color: Theme.of(context).colorScheme.secondary,
              ),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller, BuildContext context) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        uploading = true;
        result = scanData;
      });
      _postScan(scanData.code, context);
    });
  }

  void _postScan(String? code, BuildContext context) {
    Navigator.maybePop(context, code);
  }

  void onInputUUID(BuildContext context) {
    Get.dialog<String?>(const AddUUIDDialog()).then((value) {
      if (value != null && value.isNotEmpty) {
        _postScan(value, context);
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
