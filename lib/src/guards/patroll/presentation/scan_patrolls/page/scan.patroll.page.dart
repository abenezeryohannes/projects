import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:rnginfra/main/injectable/getit.dart';
import 'package:rnginfra/src/core/widgets/app.snackbar.dart';
import 'package:rnginfra/src/core/widgets/custom.shimmer.dart';
import 'package:rnginfra/src/core/widgets/loading.bar.dart';
import 'package:rnginfra/src/guards/patroll/data/dtos/add.patroll.dto.dart';
import 'package:rnginfra/src/guards/patroll/presentation/scan_patrolls/controller/scan.patroll.controller.dart';

class ScanPatrollPage extends StatefulWidget {
  const ScanPatrollPage({super.key});

  @override
  State<ScanPatrollPage> createState() => _ScanPatrollPageState();
}

class _ScanPatrollPageState extends State<ScanPatrollPage> {
  Position? p;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  late final ScanPatrollController getXController;
  late bool uploading = false;

  @override
  void initState() {
    super.initState();
    getXController = getIt<ScanPatrollController>();
    getXController.canScan.value = true;
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
    loadPosition();

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
                      Expanded(
                          // flex: 5,
                          child: Container(
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
                      )),
                    ],
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
                                // _postScan('13454235', context);
                              },
                              child: CustomShimmer(
                                show: true,
                                baseColor: Colors.grey.shade700,
                                highlightColor: Colors.grey.shade300,
                                child: Text(getXController.status.value,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall),
                              ),
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
      if (!getXController.canScan.value) return;
      setState(() {
        uploading = true;
        result = scanData;
      });
      _postScan(scanData.code, context);
    });
  }

  void loadPosition() async {
    try {
      p = await _determinePosition();
    } catch (e) {
      AppSnackBar.error(message: e.toString());
    }
  }

  void _postScan(String? code, BuildContext context) {
    // p = await _determinePosition();
    AddPatrollDto addPatrollDto = AddPatrollDto(
        qr_code_id: int.parse(code!),
        latitude: p?.latitude ?? 0,
        longitude: p?.longitude ?? 0);
    Navigator.maybePop(context, addPatrollDto);
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position?> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    try {
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
          timeLimit: const Duration(seconds: 5),
          forceAndroidLocationManager: true);
    } catch (e) {
      return Geolocator.getLastKnownPosition(forceAndroidLocationManager: true);
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
