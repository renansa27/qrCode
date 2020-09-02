import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

//void main() => runApp(MaterialApp(home: QRViewWidget()));

const flashOn = 'FLASH ON';
const flashOff = 'FLASH OFF';
const frontCamera = 'FRONT CAMERA';
const backCamera = 'BACK CAMERA';

class QRViewWidget extends StatefulWidget {
  const QRViewWidget({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewWidgetState();
}

class _QRViewWidgetState extends State<QRViewWidget> {
  var flashState = flashOn;
  var cameraState = frontCamera;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.blue,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 20,
                        width: 20,
                        margin: EdgeInsets.only(left: 8, right: 8),
                        child: FloatingActionButton(
                          heroTag: 'flash',
                          onPressed: () {
                            if (controller != null) {
                              controller.toggleFlash();
                              if (_isFlashOn(flashState)) {
                                setState(() {
                                  flashState = flashOff;
                                });
                              } else {
                                setState(
                                  () {
                                    flashState = flashOn;
                                  },
                                );
                              }
                            }
                          },
                          child: flashState == flashOff
                              ? Icon(
                                  Icons.flash_on,
                                  size: 15,
                                )
                              : Icon(
                                  Icons.flash_off,
                                  size: 15,
                                ),
                        ),
                      ),
                      Container(
                        height: 20,
                        width: 20,
                        margin: EdgeInsets.only(
                            top: 5, left: 8, right: 8, bottom: 5),
                        child: FloatingActionButton(
                          heroTag: 'camera',
                          onPressed: () {
                            if (controller != null) {
                              controller.flipCamera();
                              if (_isBackCamera(cameraState)) {
                                setState(() {
                                  cameraState = frontCamera;
                                });
                              } else {
                                setState(() {
                                  cameraState = backCamera;
                                });
                              }
                            }
                          },
                          child: Icon(
                            Icons.switch_camera,
                            size: 15,
                          ),
                          /* Text(cameraState,
                                style: TextStyle(fontSize: 20)) */
                        ),
                      ),
                      /* Container(
                        margin: EdgeInsets.all(8),
                        child: FloatingActionButton(
                          heroTag: 'pause',
                          onPressed: () {
                            controller?.pauseCamera();
                          },
                          child: Icon(Icons.pause),
                          /* Text('pause', style: TextStyle(fontSize: 20)), */
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: FloatingActionButton(
                          heroTag: 'resume',
                          onPressed: () {
                            controller?.resumeCamera();
                          },
                          child: Icon(Icons.play_arrow),
                          /* Text('resume', style: TextStyle(fontSize: 20)), */
                        ),
                      ) */
                    ],
                  ),
                  /* Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(8),
                          child: RaisedButton(
                            onPressed: () {
                              controller?.pauseCamera();
                            },
                            child:
                                Text('pause', style: TextStyle(fontSize: 20)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(8),
                          child: RaisedButton(
                            onPressed: () {
                              controller?.resumeCamera();
                            },
                            child:
                                Text('resume', style: TextStyle(fontSize: 20)),
                          ),
                        )
                      ],
                    ), */
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  bool _isFlashOn(String current) {
    return flashOn == current;
  }

  bool _isBackCamera(String current) {
    return backCamera == current;
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      //controller?.pauseCamera();
      //Get.dialog(QrResultDialog(scanData));
      Get.toNamed('/qrcoderesult', arguments: scanData);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
