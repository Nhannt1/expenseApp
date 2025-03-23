import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 375),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0, 0.183),
            end: Alignment(0, 1.2427),
            colors: [Color(0xFFFFF6E5), Color(0x00F8EDD8)],
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              color: const Color(0xFFFFF6E5),
              child: SafeArea(
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Color(0xFF7F3DFF),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            'Transactions',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Chip(
                            label: Text(
                              'Month',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            backgroundColor: Colors.blue,
                          ),
                          const SizedBox(width: 16),
                          Chip(
                            label: Text(
                              'All',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            backgroundColor: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance
                        .collection('transactions')
                        .where(
                          'uid',
                          isEqualTo:
                              FirebaseAuth
                                  .instance
                                  .currentUser
                                  ?.uid, // Lọc theo UID
                        )
                        .orderBy('createdAt', descending: true)
                        .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text("No transactions found"));
                  }

                  var transactions = snapshot.data!.docs;
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: transactions.length,
                    itemBuilder: (BuildContext context, int index) {
                      var transaction =
                          transactions[index].data() as Map<String, dynamic>;

                      // Kiểm tra và chuyển đổi Timestamp thành DateTime
                      String date = '';
                      if (transaction['createdAt'] is Timestamp) {
                        Timestamp timestamp = transaction['createdAt'];
                        DateTime dateTime = timestamp.toDate();
                        date = DateFormat('dd/MM/yyyy').format(dateTime);
                        // Kiểm tra xem ngày tháng có được định dạng đúng không
                      } else {
                        date = 'No date ';
                        // Nếu không có ngày, in ra giá trị này
                      }
                      return TransactionCard(
                        title: transaction['category'] ?? 'Unknown Category',
                        subtitle:
                            transaction['description'] ?? 'No description',
                        amount: transaction['amount'].toString(),
                        time: date,
                        isIncome: transaction['transactionType'] == 'Income',
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String amount;
  final String time;
  final bool isIncome;

  const TransactionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.time,
    required this.isIncome,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isIncome ? Colors.green : Colors.red, // Income/Expense color
          ),
        ),
        subtitle: Text(subtitle),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              amount,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color:
                    isIncome
                        ? Colors.green
                        : Colors.red, // Income/Expense color
              ),
            ),
            const SizedBox(height: 4),
            Text(time, style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
