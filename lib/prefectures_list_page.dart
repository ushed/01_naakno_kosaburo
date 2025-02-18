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
        title: const Text('都道府県を選択'),
      ),
      body: ListView(
        children: prefecturesMap.entries.map((entry) {
          return ListTile(
            title: Text(entry.value), // 都道府県名
            onTap: () {
              // 都道府県コード（key）と都道府県名（value）をMapとして返す
              Navigator.pop(context, {'code': entry.key, 'name': entry.value});
            },
          );
        }).toList(),
      ),
    );
  }
}
