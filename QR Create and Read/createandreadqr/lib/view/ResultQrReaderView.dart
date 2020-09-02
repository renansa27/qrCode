import 'package:admob_flutter/admob_flutter.dart';
import 'package:createandreadqr/service/admob_service.dart';
import 'package:createandreadqr/translator/Translator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultQrReaderView extends StatefulWidget {
  @override
  _ResultQrReaderViewState createState() => _ResultQrReaderViewState();
}

class _ResultQrReaderViewState extends State<ResultQrReaderView> {
  String scanData = Get.arguments;
  final ams = AdmobService();
  var translator = getTranslators();
  //ResultQrReaderView({this.scanData});

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
          child: Text(translator['resultPage']),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              //"Qr Code Result:",
              translator['resultPage'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            if (scanData.contains('http'))
              Column(
                children: [
                  RaisedButton(
                    color: Colors.blue[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Text(
                      scanData,
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () async {
                      if (await canLaunch(scanData)) {
                        await launch(
                          scanData,
                          forceSafariVC: false,
                          forceWebView: false,
                          headers: <String, String>{
                            'my_header_key': 'my_header_value'
                          },
                        );
                      } else {
                        throw 'Could not launch $scanData';
                      }
                    },
                  ),
                  Text(
                    //'Click in to launch on browser',
                    translator['clickToLaunch'],
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            if (!scanData.contains('http'))
              Column(
                children: [
                  RaisedButton(
                    color: Colors.blue[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Text(scanData, style: TextStyle(fontSize: 18)),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: scanData)).then(
                        (value) => Get.snackbar(
                          //'Copied',
                          //'Data has been copied to clipboard',
                          translator['copied'],
                          translator['copiedMsg'],
                          backgroundColor: Colors.white,
                          snackPosition: SnackPosition.BOTTOM,
                        ),
                      );
                    },
                  ),
                  Text(
                    //'Click to copy to clipboard',
                    translator['clickCopy'],
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
      persistentFooterButtons: [
        //AdMob here
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
}
