import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TransactionItem extends StatefulWidget {
  final String amount;
  final String type;
  final bool isIncome;

  const TransactionItem({
    super.key,
    required this.amount,
    required this.type,
    required this.isIncome,
  });

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  @override
  Widget build(BuildContext context) {
    // Lấy kích thước màn hình
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.all(screenWidth * 0.04), // Padding tỷ lệ với màn hình
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(screenWidth * 0.015), // Bo góc động
      ),
      child: Row(
        children: [
          Container(
            width: screenWidth * 0.1, // Chiều rộng tỷ lệ 10% màn hình
            height: screenWidth * 0.1, // Chiều cao bằng chiều rộng (hình tròn)
            decoration: BoxDecoration(
              color: widget.isIncome ? Colors.green : Colors.red,
              shape: BoxShape.circle,
            ),
            margin: EdgeInsets.only(right: screenWidth * 0.04),
          ),
          Expanded(
            child: Row(
              children: [
                Icon(
                  Icons.attach_money,
                  size: screenWidth * 0.06, // Icon size tỷ lệ với màn hình
                ),
                SizedBox(width: screenWidth * 0.02),
                Text(
                  widget.amount,
                  style: TextStyle(
                    fontSize: screenWidth * 0.045, // Font size tỷ lệ
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Text(
            widget.type,
            style: TextStyle(
              fontSize: screenWidth * 0.04, // Font size tỷ lệ
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
