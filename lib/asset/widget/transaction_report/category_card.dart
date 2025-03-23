import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Thêm thư viện để định dạng số tiền

class CategoryCard extends StatelessWidget {
  final String category;
  final double amount;
  final double progress;
  final Color color;
  final bool
  isIncome; // Thêm tham số isIncome để xác định là Income hay Expense

  const CategoryCard({
    super.key,
    required this.category,
    required this.amount,
    required this.progress,
    required this.color,
    required this.isIncome, // Thêm tham số này
  });

  @override
  Widget build(BuildContext context) {
    // Định dạng số tiền có dấu phân tách hàng nghìn
    final String formattedAmount = NumberFormat("#,##0").format(amount);

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Căn trái các phần tử
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(10, 6, 14, 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: color, // Màu sắc tương ứng với danh mục
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      category,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                isIncome
                    ? '+$formattedAmount' // Hiển thị + nếu là Income
                    : '-$formattedAmount', // Hiển thị - nếu là Expense
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color:
                      isIncome
                          ? const Color.fromARGB(
                            221,
                            14,
                            184,
                            73,
                          ) // Màu xanh cho Income
                          : Colors.red, // Màu đỏ cho Expense
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              minHeight: 12,
              value: progress.clamp(
                0.0,
                1.0,
              ), // Giới hạn giá trị từ 0.0 đến 1.0
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                color,
              ), // Màu trùng với danh mục
            ),
          ),
        ],
      ),
    );
  }
}
