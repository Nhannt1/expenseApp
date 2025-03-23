import 'package:flutter/material.dart';

class MonthSelector extends StatelessWidget {
  const MonthSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.only(bottom: 20),
      child: Container(
        padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
        decoration: BoxDecoration(
          color: Colors.white, // Nền trắng
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: Colors.grey[300]!), // Viền xám nhạt
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              Icons.keyboard_arrow_down,
              color: Colors.purple,
            ), // Icon màu tím
            SizedBox(width: 4),
            Text(
              'Month',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: Colors.black87, // Màu chữ xám đậm
              ),
            ),
          ],
        ),
      ),
    );
  }
}
