import 'package:flutter/material.dart';
import './screens/home_page.dart';
import './profile_page.dart';

//ボトムナビゲーション
/*
ホームページ
プロフィール
*/
class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (_selectedIndex == 0) ? WeatherScreen() : const ProfilePage(),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile')
          ]),
    );
  }
}
