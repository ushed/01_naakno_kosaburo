import 'package:flutter/material.dart';
import 'prefectures_list_page.dart';

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
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String? _selectPrefecture; // 選択した都道府県を保存する変数

  @override
  Widget build(BuildContext context) {
    // 画面の横幅・高さを取得
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('今日の天気'),
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
                child: Text(
                  '今日の天気' * 80,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 16), // ボタンとContainerの間のスペース
            ElevatedButton(
              onPressed: () async {
                // 都道府県選択画面に遷移し、選択結果を取得
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrefecturesListPage(),
                  ),
                );

                // 選択結果が null でない場合に状態を更新
                if (result != null) {
                  setState(() {
                    _selectPrefecture = result;
                  });
                }
              },
              child: Text(
                _selectPrefecture == null
                    ? '都道府県を選択'
                    : '$_selectPrefecture を選択',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
