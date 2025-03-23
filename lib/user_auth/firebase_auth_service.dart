import 'package:firebase_auth/firebase_auth.dart';
import 'package:newapp/user_auth/transaction_firebase.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // await credential.user?.updateProfile(displayName: displayName);
      // await credential.user?.reload(); // Tải lại thông tin người dùng
      User? user = credential.user; // Lấy user từ credential
      if (user != null) {
        await user.updateDisplayName(displayName); // Cập nhật tên
        await user.reload(); // Tải lại thông tin người dùng

        // Lưu thêm thông tin vào Firestore
        await createUserProfile(user, displayName);
      }
      return credential.user; // Trả về User nếu đăng ký thành công
    } catch (e) {
      print("Error during sign up: $e");
      return null; // Trả về null nếu có lỗi
    }
  }

  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      print('Error signing in: $e');
    }
    return null;
  }
}
