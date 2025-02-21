import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? userDocId; // UID を格納する変数
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser; // 現在のログインユーザーを取得
    if (user == null) {
      print("ログインしていません");
      return;
    }

    userDocId = user.uid;
    print("ログインユーザーの UID: $userDocId");

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userDocId)
        .get();

    if (doc.exists) {
      setState(() {
        userData = doc.data();
      });
    } else {
      print("ユーザーデータが Firestore に見つかりません");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userData?['name'] ?? '名前がありません'),
        actions: [
          const SignOutButton(
            variant: ButtonVariant.text,
          )
        ],
      ),
      body: Center(
        child: userData == null
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 30),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      userData?['iconUrl'] ?? 'https://example.com/default.png',
                      fit: BoxFit.cover,
                      width: 200,
                      height: 200,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Text(userData?['selfIntroText'] ?? '自己紹介がありません'),
                  const SizedBox(height: 50),
                  Text(userData?['location'] ?? '位置情報なし'),
                  const SizedBox(height: 100),
                  ElevatedButton(
                    onPressed: () async {
                      final updated = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditProfilePage(userData: userData),
                        ),
                      );

                      if (updated == true) {
                        _fetchUserData();
                      }
                    },
                    child: const Text('プロフィール編集'),
                  ),
                ],
              ),
      ),
    );
  }
}
