import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 21),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(color: Color(0xFFF5F5F5), spreadRadius: 4),
                BoxShadow(color: Color(0xFFAD00FF), spreadRadius: 2),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              // child: Image.network(
              //   'https://placehold.co/160x160/7f3dff/7f3dff',
              //   fit: BoxFit.cover,
              // ),
            ),
          ),
          SizedBox(width: 28),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Username',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF91919F),
                ),
              ),
              SizedBox(height: 6),
              Text(
                user?.displayName ?? 'nhan',
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF161719),
                ),
              ),
            ],
          ),
          Spacer(),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Color(0xFFF1F1FA)),
            ),
            child: Center(
              child: Icon(
                Icons.edit_outlined,
                size: 24,
                color: Color(0xFF212325),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
