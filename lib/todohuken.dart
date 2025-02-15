import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;

class TodohukenListScreen extends StatefulWidget {
  @override
  _TodohukenListScreenState createState() => _TodohukenListScreenState();
}

class _TodohukenListScreenState extends State<TodohukenListScreen> {
  Map<String, String> Todohukens = {};

  @override
  void initState() {
    super.initState();
    loadTodohukens();
  }

  Future<void> loadTodohukens() async {
    // JSONファイルを読み込み
    final String response =
        await rootBundle.rootBundle.loadString('lib/Todohukens.json');
    final data = jsonDecode(response);

    // 都道府県のコードと名前をMapとして格納
    setState(() {
      Todohukens = Map<String, String>.from(data['TodohukensCode']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('都道府県リスト')),
      body: ListView.builder(
        itemCount: Todohukens.length,
        itemBuilder: (context, index) {
          String key = Todohukens.keys.elementAt(index);
          return ListTile(
            title: Text(Todohukens[key]!),
            onTap: () {
              // リストアイテムをタップすると前の画面にpopして、選択されたvalueを渡す
              Navigator.pop(context, Todohukens[key]);
            },
          );
        },
      ),
    );
  }
}
