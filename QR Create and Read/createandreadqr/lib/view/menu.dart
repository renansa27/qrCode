import 'package:createandreadqr/service/admob_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admob_flutter/admob_flutter.dart';
import '../translator/Translator.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final ams = AdmobService();
  var translator = getTranslators();

  //BannerAd _bannerAd;
  //InterstitialAd _interstitialAd;

  @override
  void initState() {
    super.initState();
    Admob.initialize(ams.getAdMobAppId());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
            title: Center(
              child: Text("QR Code Create and Read"),
            ),
          ), */
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width * 0.9,
              child: RaisedButton(
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt,
                      size: 60,
                      color: Colors.white,
                    ),
                    Text(
                      //"Leia um QR Code",
                      translator['readQR'],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  Get.toNamed('/qrcodereader');
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width * 0.9,
              child: RaisedButton(
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.create,
                      size: 60,
                      color: Colors.white,
                    ),
                    Text(
                      //"Crie seu proprio QR Code",
                      translator['createQR'],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  Get.toNamed('/qrcodecreator');
                },
              ),
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
