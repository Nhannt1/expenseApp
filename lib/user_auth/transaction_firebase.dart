import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> createUserProfile(User user, String displayName) async {
  try {
    // Tạo profile của người dùng trong Firestore
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'displayName': displayName, // Tên người dùng
      'email': user.email, // Email người dùng
      'uid': user.uid, // ID người dùng
      'createdAt': FieldValue.serverTimestamp(), // Thời gian tạo tài khoản
    });
  } catch (e) {
    print('Error creating user profile: $e');
  }
}
