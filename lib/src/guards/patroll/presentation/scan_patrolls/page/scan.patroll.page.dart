import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:rnginfra/main/injectable/getit.dart';
import 'package:rnginfra/src/guards/patroll/presentation/scan_patrolls/controller/scan.patroll.controller.dart';

class ScanPatrollPage extends StatefulWidget {
  const ScanPatrollPage({super.key});

  @override
  State<ScanPatrollPage> createState() => _ScanPatrollPageState();
}

class _ScanPatrollPageState extends State<ScanPatrollPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  late final ScanPatrollController getXController;

  @override
  void initState() {
    super.initState();
    getXController = getIt<ScanPatrollController>();
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
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
                alignment: Alignment.center,
                // color: Colors.red,
                child: (result == null)
                    ? InkWell(
                        onTap: () {
                          int qr = Random().nextInt(2147483647);
                          double lat = 20.32;
                          double longitude = 23.02;
                          getXController.addQr(
                              qr_code: qr, latitude: lat, longitude: longitude);
                        },
                        child: Text(getXController.status.value),
                      )
                    : Text(
                        'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
