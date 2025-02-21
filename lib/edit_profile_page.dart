//edit_profile_page
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // ← FirebaseAuth をインポート
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final Map<String, dynamic>? userData;

  const EditProfilePage({super.key, this.userData});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _iconUrlController;
  late TextEditingController _bioController;
  late TextEditingController _locationController;

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.userData?['name'] ?? '');
    _iconUrlController =
        TextEditingController(text: widget.userData?['iconUrl'] ?? '');
    _bioController =
        TextEditingController(text: widget.userData?['selfIntroText'] ?? '');
    _locationController =
        TextEditingController(text: widget.userData?['location'] ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _iconUrlController.dispose();
    _bioController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('プロフィール編集'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'ユーザー名'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _iconUrlController,
              decoration: const InputDecoration(labelText: 'アイコンURL'),
              maxLines: 1,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _bioController,
              decoration: const InputDecoration(labelText: '自己紹介'),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(labelText: '位置情報'),
              maxLines: 1,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final user = FirebaseAuth.instance.currentUser;
                if (user == null) return; // ログインしていない場合は何もしない

                final userDocRef = FirebaseFirestore.instance
                    .collection('users')
                    .doc(user.uid); // Firestore のドキュメントIDを UID にする

                // Firestore にデータを更新
                await userDocRef.set({
                  'name': _nameController.text,
                  'iconUrl': _iconUrlController.text,
                  'selfIntroText': _bioController.text,
                  'location': _locationController.text,
                  'updated_at': Timestamp.now(),
                }, SetOptions(merge: true)); // 既存データを上書きせずマージ

                Navigator.pop(context, true); // 編集が完了したら ProfilePage に戻る
              },
              child: const Text('保存'),
            ),
          ],
        ),
      ),
    );
  }
}
