import 'dart:async';
import 'package:quotex291/const/strings.dart';
import 'package:http/http.dart' as http;

class LoadingApiClient {
  static Future<int> validateSesion(
      {required StreamController<String> errorController,
      required String udid,
      required int procentChargh,
      required bool isChargh,
      required bool isVpn}) async {
    try {
      final client = http.Client();
      final url = Uri.parse('https://$zaglushka');
      final response = await client.post(url, body: {
        'vivisWork': isVpn,
        'poguaKFP': udid,
        'Fpvbduwm': isChargh,
        'gfpbvjsoM': procentChargh
      });

      if (response.statusCode == 200) {
        final data = response.body;
        return int.tryParse(data) ?? 1;
      }
      return 1;
    } catch (_) {
      return 1;
    }
  }
}
