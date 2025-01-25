import 'package:flutter/material.dart';

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

class WeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              padding: EdgeInsets.all(16.0),
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
            SizedBox(height: 16), // ボタンとContainerの間のスペース
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('都道府県を選択'),
                      content: Text('都道府県選択画面'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('閉じる'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('都道府県を選択'),
            ),
          ],
        ),
      ),
    );
  }
}
