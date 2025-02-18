import 'package:flutter/material.dart';
import 'prefectures_list_page.dart';
import '../service/weather_api_service.dart';
import '../model/wether_response.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '今日の天気',
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String? _selectedPrefectureCode;
  String? _selectedPrefectureName; // 都道府県名を保持する変数
  WeatherResponse? _weatherData;
  final WeatherApiService _weatherApiService = WeatherApiService();

  @override
  Widget build(BuildContext context) {
    // 画面の横幅・高さを取得
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('今日の天気'),
      ),
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
                    ? // 都道府県が選択されていない場合
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          '都道府県を選択してください',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      )
                    : _weatherData != null
                        ? Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // "text" のみを表示
                                Text(
                                  _weatherData!.text,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          )
                        : Container(), // 天気情報がない場合
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // 都道府県選択画面へ遷移し、選択した都道府県コードと名前を受け取る
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrefecturesListPage(),
                  ),
                );

                if (result != null) {
                  setState(() {
                    _selectedPrefectureCode = result['code'];
                    _selectedPrefectureName = result['name']; // 都道府県名を保存
                  });

                  // 選択した都道府県の天気データを取得
                  try {
                    final weatherData =
                        await _weatherApiService.getWeather(result['code']);
                    setState(() {
                      _weatherData = weatherData;
                    });
                  } catch (e) {
                    print(e); // エラーハンドリング
                  }
                }
              },
              child: Text(
                _selectedPrefectureCode == null
                    ? '都道府県を選択'
                    : '$_selectedPrefectureName の天気を取得', // nameを表示
              ),
            ),
          ],
        ),
      ),
    );
  }
}
