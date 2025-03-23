import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newapp/Screen/splashScreen.dart';
import 'package:newapp/asset/bottomnavigation.dart';
import 'package:newapp/asset/widget/profile_widget/profile_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.00, -1.00),
                  end: Alignment(0, 1.24),
                  colors: [Color(0xFFFFF6E5), Color(0x00F8EDD8)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 118),
                  ProfileHeader(),
                  SizedBox(height: 20),
                  Expanded(
                    // Dùng Expanded để tự động chiếm không gian còn lại
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 11),
                      child: ListView(
                        children: [
                          ListTile(
                            leading: Icon(
                              Icons
                                  .account_balance_wallet, // Sử dụng icon tài khoản
                              color: Color(0xFF7F3DFF),
                            ),
                            title: Text('Account'),
                            onTap: () {
                              // Xử lý khi người dùng chọn mục này
                            },
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.settings, // Sử dụng icon cài đặt
                              color: Color(0xFF7F3DFF),
                            ),
                            title: Text('Settings'),
                            onTap: () {
                              // Xử lý khi người dùng chọn mục này
                            },
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.upload_file, // Sử dụng icon tải lên
                              color: Color(0xFF7F3DFF),
                            ),
                            title: Text('Export Data'),
                            onTap: () {
                              // Xử lý khi người dùng chọn mục này
                            },
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.logout, // Sử dụng icon đăng xuất
                              color: Color(0xFFFD3C4A),
                            ),
                            title: Text('Logout'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SplashScreen(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CustomBottomNav(
                currentIndex: 3,
                onTap: (index) {
                  // Handle navigation
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
