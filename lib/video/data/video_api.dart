import 'dart:convert';
import 'package:quotex291/const/strings.dart';
import 'package:http/http.dart' as http;
import '../domain/models/video_model.dart';

class ApiClentVideo {
  static Future<List<VideoModel>> getVideo() async {
    try {
      final client = http.Client();
      final url = Uri.parse('https://$apiDomain/api/v2/video?token=$apiToken');
      final response = await client.get(url);
      if (response.statusCode == 200) {
        final jsonT = jsonDecode(response.body) as Map<String, dynamic>;
        final json = jsonT['rows'] as List<dynamic>;
        final newChart = json.map((e) => e as Map<String, dynamic>).toList();
        final list = newChart.map((e) => VideoModel.fromMap(e)).toList();
        return list;
      }
      return [];
    } catch (_) {
      return [];
    }
  }
}
