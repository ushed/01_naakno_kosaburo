import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CO36'),
        actions: [
          const SignOutButton(
            variant: ButtonVariant.text,
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                'assets/img.png',
                fit: BoxFit.cover,
                width: 300,
                height: 300,
              ),
            ),
            const SizedBox(height: 50),
            const Text('自己紹介'),
            const SizedBox(height: 50),
            const Text('位置情報'),
          ],
        ),
      ),
    );
  }
}
