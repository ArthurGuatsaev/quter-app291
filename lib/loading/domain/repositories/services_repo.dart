import 'dart:async';
import 'package:amplitude_flutter/amplitude.dart';
import 'package:apphud/apphud.dart';
// import 'package:dio/dio.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:quotex291/loading/domain/model/loading_model.dart';

class VServices {
  final String apphudApiKey = 'app_XzUrxsnCmYGZ91Y5xdtjmVBeSrw42M';
  final String amplitudeApiKey = '8f09966375731516cc447a7c0021be5b';
  String userId = '';
  Future<void> initApphud(
      {required StreamController<VLoading> controller}) async {
    await Apphud.start(
        apiKey: apphudApiKey, observerMode: false, userID: userId);
    controller.add(VLoading.apphud);
    userId = await Apphud.userID();
  }

  Future<void> initAmplitude(
      {required StreamController<VLoading> controller}) async {
    final analytics =
        Amplitude.getInstance(instanceName: '744448e6578aea3bc1c9acb41b06302d');
    await analytics.init(amplitudeApiKey);
    await analytics.trackingSessionEvents(true);
    await analytics.setUserId(userId);
    controller.add(VLoading.amplitude);
  }

  Future<void> initOneSignal(
      {required StreamController<VLoading> controller}) async {
    await getReadyNotificationSystem();
    OneSignal.initialize("");
    controller.add(VLoading.onesignal);
  }

  Future<void> getReadyNotificationSystem() async {
    try {
      // const url = '';
      // final dio = Dio();
      // final response = await dio.get(url);
      // if (response.statusCode == 200) {
      //   print('ok');
      //   print(response.data['result']);
      // } else {}
    } catch (_) {}
  }

  Future<void> logAmplitude() async {
    await Amplitude.getInstance().logEvent('did_show_main_screen');
  }
}
