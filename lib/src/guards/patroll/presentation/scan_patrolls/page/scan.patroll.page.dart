import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:rnginfra/main/injectable/getit.dart';
import 'package:rnginfra/src/core/errors/failure.dart';
import 'package:rnginfra/src/core/widgets/app.snackbar.dart';
import 'package:rnginfra/src/core/widgets/loading.bar.dart';
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
  late bool uploading = false;

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

      body: SafeArea(
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Column(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: QRView(
                    key: qrKey,
                    onQRViewCreated: (x) => _onQRViewCreated(x, context),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: (result == null)
                          ? InkWell(
                              onTap: () {
                                _postScan('13454235', context);
                              },
                              child: Text(getXController.status.value,
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                            )
                          : Text(
                              getXController.status.value,
                              style: Theme.of(context).textTheme.bodyMedium,
                            )),
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

  void _postScan(String? qr, BuildContext context) async {
    try {
      if (qr == null || int.tryParse(qr) == null) {
        throw Exception('Invlid Qr format (Must be a number)!');
      }
      Position p = await _determinePosition();
      setState(() {
        uploading = true;
      });
      await getXController.addQr(
          qr_code: int.parse(qr),
          latitude: p.latitude,
          longitude: p.longitude,
          context: context);
    } catch (e) {
      AppSnackBar.failure(failure: Failure(message: e.toString()));
    } finally {
      setState(() {
        uploading = false;
      });
    }
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
