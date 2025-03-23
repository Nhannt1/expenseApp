import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newapp/Screen/FinancialReportScreen.dart';
import 'package:newapp/Screen/addTransactionScreen.dart';
import 'package:newapp/Screen/homeScreen.dart';
import 'package:newapp/Screen/profileScreen.dart';
import 'package:newapp/Screen/transaction.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      decoration: BoxDecoration(
        color: Color(0xFFFCFCFC),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon:
                    Icons
                        .home, // Thay thế icon từ file hình ảnh bằng icon Material
                label: 'Home',
                isSelected: currentIndex == 0,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
              ),
              InkWell(
                child: _NavItem(
                  icon:
                      Icons
                          .compare_arrows, // Thay thế icon từ file hình ảnh bằng icon Material
                  label: 'Transaction',
                  isSelected: currentIndex == 1,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransactionsScreen(),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: 57), // Space for add button
              _NavItem(
                icon:
                    Icons
                        .pie_chart, // Thay thế icon từ file hình ảnh bằng icon Material
                label: 'Statitics',
                isSelected: currentIndex == 2,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FinancialReportScreen(),
                    ),
                  );
                },
              ),
              _NavItem(
                icon:
                    Icons
                        .person, // Thay thế icon từ file hình ảnh bằng icon Material
                label: 'Profile',
                isSelected: currentIndex == 3,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransactionInputScreen(),
                    ),
                  );
                },
                child: Container(
                  width: 57,
                  height: 57,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF7F3DFF),
                  ),
                  child: Icon(Icons.add, color: Colors.white, size: 32),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    // ignore: unused_element_parameter
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? Color(0xFF7F3DFF) : Color(0xFFC6C6C6);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 32,
            color: color, // Sử dụng màu cho icon
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
