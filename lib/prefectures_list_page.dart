//prefectures_list_page
import 'package:flutter/material.dart';
import 'dart:convert';
import 'prefectures.dart';

class PrefecturesListPage extends StatefulWidget {
  const PrefecturesListPage({super.key});

  @override
  State<PrefecturesListPage> createState() => _PrefecturesListPage();
}

class _PrefecturesListPage extends State<PrefecturesListPage> {
  late Map<String, dynamic> prefecturesMap;

  @override
  void initState() {
    super.initState();
    // JSONデコードしてMapに変換
    prefecturesMap = json.decode(jsonStringPrefecture)['prefecturesCode'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('都道府県'),
      ),
      body: ListView(
        children: prefecturesMap.entries.map((entry) {
          return ListTile(
            title: Text(entry.value), // 都道府県名
            onTap: () {
              Navigator.pop(context, entry.value); // 選択した都道府県を返す
            },
          );
        }).toList(),
      ),
    );
  }
}
