import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BalanceSection extends StatefulWidget {
  const BalanceSection({super.key});

  @override
  State<BalanceSection> createState() => _BalanceSectionState();
}

class _BalanceSectionState extends State<BalanceSection> {
  double totalIncome = 0.0;
  double totalExpense = 0.0;

  @override
  void initState() {
    super.initState();
    _getTotalIncomeAndExpense();
  }

  Future<void> _getTotalIncomeAndExpense() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        // Lọc theo UID người dùng
        QuerySnapshot snapshot =
            await FirebaseFirestore.instance
                .collection('transactions')
                .where('uid', isEqualTo: uid)
                .get();

        double income = 0.0;
        double expense = 0.0;

        for (var doc in snapshot.docs) {
          var data = doc.data() as Map<String, dynamic>;
          if (data['transactionType'] == 'Income') {
            income += data['amount'] ?? 0.0;
          } else if (data['transactionType'] == 'Expense') {
            expense += data['amount'] ?? 0.0;
          }
        }

        // Cập nhật lại UI sau khi lấy dữ liệu
        setState(() {
          totalIncome = income;
          totalExpense = expense;
        });
      }
    } catch (e) {
      print('Error fetching transactions: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Lấy kích thước màn hình
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.06), // 6% chiều rộng màn hình
      child: Column(
        children: [
          Text(
            'Account Balance',
            style: TextStyle(
              fontSize: screenWidth * 0.06, // Font size tỷ lệ với màn hình
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: screenHeight * 0.01), // Khoảng cách động
          Text(
            '\$ ${(totalIncome - totalExpense)} ',
            style: TextStyle(
              fontSize: screenWidth * 0.08, // Font size lớn hơn cho số dư
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: screenHeight * 0.025),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: _BalanceCard(
                  backgroundColor: Colors.green,
                  title: 'Income',
                  amount: '\$ ${(totalIncome)}',
                  isIncome: true,
                  icon: Icons.arrow_circle_up,
                ),
              ),
              SizedBox(width: screenWidth * 0.02),
              Expanded(
                child: _BalanceCard(
                  backgroundColor: Colors.red,
                  title: 'Expenses',
                  amount: '\$ ${(totalExpense)}',
                  isIncome: false,
                  icon: Icons.arrow_circle_down,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BalanceCard extends StatelessWidget {
  final Color backgroundColor;
  final String title;
  final String amount;
  final bool isIncome;
  final IconData icon; // Thêm tham số icon

  const _BalanceCard({
    // ignore: unused_element_parameter
    super.key,
    required this.backgroundColor,
    required this.title,
    required this.amount,
    required this.isIncome,
    required this.icon, // Nhận tham số icon
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.all(screenWidth * 0.04), // Padding tỷ lệ với màn hình
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(screenWidth * 0.07), // Bo góc động
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Căn chỉnh các phần tử sang 2 bên
        children: [
          Container(
            padding: EdgeInsets.all(screenWidth * 0.001),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Icon(
              icon,
              color: backgroundColor,
              size: screenWidth * 0.1, // Kích thước icon động theo màn hình
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: screenWidth * 0.04, // Font size tỷ lệ
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: screenWidth * 0.01),
              Text(
                amount,
                style: TextStyle(
                  fontSize: screenWidth * 0.05, // Font size cho số tiền
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
