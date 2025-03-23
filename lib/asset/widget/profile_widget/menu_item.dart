import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuItem extends StatelessWidget {
  final String icon; // Icon path
  final String title; // Menu item title
  final Color iconColor; // Icon color

  const MenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 89,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.black.withOpacity(0.04))),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 17, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              // child: Center(
              //   // Use Image.asset instead of SvgPicture.asset
              //   child: Image.asset(
              //     icon, // Path to your image
              //     width: 32,
              //     height: 32,
              //     color:
              //         iconColor, // Apply color if needed (does not apply to PNGs)
              //   ),
              // ),
            ),
            SizedBox(width: 9),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF292B2D),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
