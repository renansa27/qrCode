import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:admob_flutter/admob_flutter.dart';
import 'package:createandreadqr/service/admob_service.dart';
import 'package:createandreadqr/translator/Translator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCreatorWidget extends StatefulWidget {
  const QRCreatorWidget({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRCreatorWidgetState();
}

class _QRCreatorWidgetState extends State<QRCreatorWidget> {
  //final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  GlobalKey _globalKey = new GlobalKey();
  var translator = getTranslators();
  Color bgColor = Color(0xFFFFFFFF);
  Color fgColor = Color(0xFF000000);
  String text = "QR Data";
  final ams = AdmobService();

  @override
  void initState() {
    super.initState();
    Admob.initialize(ams.getAdMobAppId());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            //"Create your QR Code",
            translator['createQRAppBar'],
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextField(
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, style: BorderStyle.solid),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, style: BorderStyle.solid),
                          ),
                          labelText: "QR Data",
                          labelStyle: TextStyle(color: Colors.black),
                          prefixIcon: Icon(Icons.edit)),
                      onChanged: (value) {
                        setState(() {
                          text = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Text(translator['background']),
                          SizedBox(
                            height: 35,
                            width: 35,
                            child: FloatingActionButton(
                              heroTag: 'PickerBgColor',
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              backgroundColor: bgColor,
                              onPressed: () {
                                return Get.dialog(
                                  Scaffold(
                                    resizeToAvoidBottomInset: false,
                                    backgroundColor: Colors.transparent,
                                    body: AlertDialog(
                                      content: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CircleColorPicker(
                                            initialColor: bgColor,
                                            onChanged: _onBgColorChanged,
                                            colorCodeBuilder: (context, color) {
                                              return Text(
                                                'rgb(${color.red}, ${color.green}, ${color.blue})',
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              );
                                            },
                                          ),
                                          RaisedButton(
                                            color: Colors.blue,
                                            child: Text('Select'),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                            ),
                                            onPressed: () {
                                              Get.back();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(translator['foreground']),
                          SizedBox(
                            height: 35,
                            width: 35,
                            child: FloatingActionButton(
                              heroTag: 'PickerFgColor',
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              backgroundColor: fgColor,
                              onPressed: () {
                                return Get.dialog(
                                  Scaffold(
                                    resizeToAvoidBottomInset: false,
                                    backgroundColor: Colors.transparent,
                                    body: AlertDialog(
                                      content: Column(
                                        children: [
                                          CircleColorPicker(
                                            initialColor: fgColor,
                                            onChanged: _onFgColorChanged,
                                            colorCodeBuilder: (context, color) {
                                              return Text(
                                                'rgb(${color.red}, ${color.green}, ${color.blue})',
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              );
                                            },
                                          ),
                                          RaisedButton(
                                            color: Colors.blue,
                                            child: Text(translator['select']),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                            ),
                                            onPressed: () {
                                              Get.back();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    //'Select strong and contrasting colors',
                    translator['colorsWarning'],
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (text != "")
                    Column(
                      children: [
                        Container(
                          child: RepaintBoundary(
                            key: _globalKey,
                            child: QrImage(
                              data: text,
                              backgroundColor: bgColor,
                              foregroundColor: fgColor,
                              size: 200.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: RaisedButton(
                            color: Colors.blue[100],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            child: Text(
                              //"Salvar na galeria",
                              translator['saveGallery'],
                            ),
                            onPressed: () {
                              saveImage();
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      ),
      persistentFooterButtons: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: AdmobBanner(
            //On Production
            adUnitId: ams.getBannerAdId(),
            //To test
            //adUnitId: "ca-app-pub-3940256099942544/6300978111",
            adSize: AdmobBannerSize.FULL_BANNER,
          ),
        ),
      ],
    );
  }

  void _onBgColorChanged(Color color) {
    setState(() => bgColor = color);
  }

  void _onFgColorChanged(Color color) {
    setState(() => fgColor = color);
  }

  Future<bool> getUserPermission() async {
    var res = await Permission.storage.request().isGranted;
    return res;
  }

  //Convert the QrCode to Image
  Future<Uint8List> _capturePng() async {
    try {
      RenderRepaintBoundary boundary =
          _globalKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData.buffer.asUint8List();
      //var bs64 = base64Encode(pngBytes);
      print(pngBytes);
      //print(bs64);
      setState(() {});
      return pngBytes;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void saveImage() {
    getUserPermission().then(
      (res) => {
        if (res)
          {
            _capturePng().then(
              (value) async => {
                //Salva QR CODE na galeria
                ImageGallerySaver.saveImage(value, quality: 100).then(
                  (response) => Get.snackbar(
                    //'Sucesso',
                    translator['success'],
                    //'QR Code foi enviado para a galeria!',
                    translator['saveSuccess'],
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.white,
                  ),
                ),
              },
            ),
          }
        else
          {
            Get.snackbar(
              //'Error',
              translator['error'],
              //'Permissão negada!',
              translator['errorMsg'],
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.white,
            ),
          },
      },
    );
  }
}
