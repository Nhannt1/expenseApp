import 'package:flutter/material.dart';

class TransactionTypeToggle extends StatelessWidget {
  final bool isIncome;
  final Function(bool) onChanged;

  const TransactionTypeToggle({
    super.key,
    required this.isIncome,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => onChanged(true),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 11),
              decoration: BoxDecoration(
                color:
                    isIncome
                        ? Colors.green
                        : Colors.transparent, // Income color (green)
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color:
                      isIncome
                          ? Colors.green
                          : Colors.red, // Nếu không phải income, viền màu đỏ
                  width: 1, // Độ dày của viền
                ),
              ),
              child: const Text(
                'Income',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GestureDetector(
            onTap: () => onChanged(false),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 11),
              decoration: BoxDecoration(
                color:
                    !isIncome
                        ? Colors.red
                        : Colors.transparent, // Expense color (red)
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Expense',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
