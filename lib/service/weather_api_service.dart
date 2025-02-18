//weather_api_service
import '../model/wether_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherApiService {
  Future<WeatherResponse> getWeather(String prefectureCode) async {
    final url =
        'https://www.jma.go.jp/bosai/forecast/data/overview_forecast/$prefectureCode.json';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final utfBody = utf8.decode(response.bodyBytes);
        final responseMap = json.decode(utfBody) as Map<String, dynamic>;
        return WeatherResponse.fromJson(responseMap);
      } else {
        throw Exception(
            'Failed to load weather. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('天気情報取得APIでエラー発生: $e');
    }
  }
}
