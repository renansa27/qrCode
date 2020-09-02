import 'dart:io';

//Id do projeto pelo AdMob
class AdmobService {
  String getAdMobAppId() {
    if (Platform.isIOS) {
      return '';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-4884096924376499~1148091878';
    }
    return null;
  }

  //Id da propaganda (na caso o home-banner-ad)
  String getBannerAdId() {
    if (Platform.isIOS) {
      return '';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-4884096924376499/5665921383';
    }
    return null;
  }
}
