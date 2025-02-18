import 'package:flutter/material.dart';
import '../prefectures_list_page.dart';
import '../service/weather_api_service.dart';
import '../model/wether_response.dart';

class WeatherScreen extends StatefulWidget {
  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String? _selectedPrefectureCode;
  String? _selectedPrefectureName;
  WeatherResponse? _weatherData;
  final WeatherApiService _weatherApiService = WeatherApiService();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text('今日の天気')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: screenWidth * 0.8,
              height: screenHeight * 0.5,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(255, 31, 194, 253)),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: SingleChildScrollView(
                child: _selectedPrefectureCode == null
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          '都道府県を選択してください',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      )
                    : _weatherData != null
                        ? Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              _weatherData!.text, // 天気情報のテキストのみ表示
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        : Container(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PrefecturesListPage()),
                );

                if (result != null) {
                  setState(() {
                    _selectedPrefectureCode = result['code'];
                    _selectedPrefectureName = result['name'];
                  });

                  try {
                    final weatherData =
                        await _weatherApiService.getWeather(result['code']);
                    setState(() {
                      _weatherData = weatherData;
                    });
                  } catch (e) {
                    print(e);
                  }
                }
              },
              child: Text(
                _selectedPrefectureCode == null
                    ? '都道府県を選択'
                    : '$_selectedPrefectureName の天気を取得',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
