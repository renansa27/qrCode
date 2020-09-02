import 'package:createandreadqr/view/ResultQrReaderView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './view/menu.dart';
import 'package:createandreadqr/view/QRCreatorView.dart';
import 'package:createandreadqr/view/QRReaderView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Code Reader & Creator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/home',
      getPages: [
        GetPage(
          name: '/home',
          page: () => Menu(),
        ),
        GetPage(
          name: '/qrcodereader',
          page: () => QRViewWidget(),
        ),
        GetPage(
          name: '/qrcodecreator',
          page: () => QRCreatorWidget(),
        ),
        GetPage(
          name: '/qrcoderesult',
          page: () => ResultQrReaderView(),
        ),
      ],
    );
  }
}
