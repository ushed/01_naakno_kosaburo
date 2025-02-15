import 'package:flutter/material.dart';
import 'todohuken.dart';

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
    //画面の横幅取得
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
                //スクロールできるやつでラッピング
                child: Text(
                  style: TextStyle(fontSize: 16),
                  '今日の天気' * 80,
                ),
              ),
            ),
            SizedBox(height: 16), // ボタンとContainerの間のスペース
            ElevatedButton(
              onPressed: () async {
                // 都道府県選択画面に遷移
                final selectedTodohuken = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TodohukenListScreen()),
                );

                if (selectedTodohuken != null) {
                  // 選択された都道府県を表示
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('選択された都道府県'),
                        content: Text(selectedTodohuken),
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
                }
              },
              child: Text('都道府県を選択'),
            ),
          ],
        ),
      ),
    );
  }
}
