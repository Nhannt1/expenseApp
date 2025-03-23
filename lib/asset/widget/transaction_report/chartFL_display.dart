// ignore_for_file: unused_local_variable

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChartDisplay extends StatefulWidget {
  final Function(List<Map<String, dynamic>>) onDataUpdated;
  final bool isIncome; // Kiểm tra nếu là Income hay Expense

  const ChartDisplay({
    super.key,
    required this.onDataUpdated,
    required this.isIncome,
  });

  @override
  _ChartDisplayState createState() => _ChartDisplayState();
}

class _ChartDisplayState extends State<ChartDisplay> {
  List<PieChartSectionData> sections = [];
  double totalAmount = 0.0;
  List<Map<String, dynamic>> categoryDataList = [];

  Map<String, Color> categoryColors = {};

  @override
  void initState() {
    super.initState();
    fetchData(); // Lấy dữ liệu khi khởi tạo
  }

  // Lắng nghe sự thay đổi của widget.isIncome để fetch lại dữ liệu
  void didUpdateWidget(covariant ChartDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isIncome != widget.isIncome) {
      fetchData(); // Nếu chế độ Income/Expense thay đổi, gọi lại fetchData
    }
  }

  // Phương thức lấy dữ liệu Income hoặc Expense
  fetchData() async {
    if (widget.isIncome) {
      await fetchIncomeData();
    } else {
      await fetchExpenseData();
    }
  }

  // Lấy dữ liệu Income từ Firestore
  Future<void> fetchIncomeData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print("Người dùng chưa đăng nhập.");
        return;
      }

      String uid = user.uid;
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance
              .collection('transactions')
              .where('transactionType', isEqualTo: 'Income')
              .where('uid', isEqualTo: uid)
              .get();

      double newTotal = 0.0;
      List<PieChartSectionData> newSections = [];
      List<Map<String, dynamic>> newCategoryDataList = [];

      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String category = data['category'];
        double amount =
            (data['amount'] is int)
                ? (data['amount'] as int).toDouble()
                : (data['amount'] as double);
        Color categoryColor = _getCategoryColor(category);

        newTotal += amount;

        newSections.add(
          PieChartSectionData(
            color: categoryColor,
            value: amount,
            radius: 60,
            showTitle: false,
          ),
        );

        newCategoryDataList.add({
          'category': category,
          'amount': amount,
          'color': categoryColor,
        });
      }

      setState(() {
        totalAmount = newTotal;
        sections = newSections;
        categoryDataList = newCategoryDataList;
      });

      widget.onDataUpdated(newCategoryDataList);
    } catch (e) {
      print("Lỗi khi lấy dữ liệu Firestore: $e");
    }
  }

  // Lấy dữ liệu Expense từ Firestore
  // Lấy dữ liệu Expense từ Firestore và gộp danh mục trùng lặp
  Future<void> fetchExpenseData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print("Người dùng chưa đăng nhập.");
        return;
      }

      String uid = user.uid;
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance
              .collection('transactions')
              .where('transactionType', isEqualTo: 'Expense')
              .where('uid', isEqualTo: uid)
              .get();

      double newTotal = 0.0;
      List<PieChartSectionData> newSections = [];

      // Khai báo categoryTotal để lưu tổng tiền của từng danh mục
      Map<String, double> categoryTotal = {};

      // Khai báo categoryColors để lưu màu sắc cho từng danh mục
      Map<String, Color> categoryColors = {};

      // Lặp qua các giao dịch và gộp các danh mục trùng nhau lại
      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String category = data['category'];
        double amount =
            (data['amount'] is int)
                ? (data['amount'] as int).toDouble()
                : (data['amount'] as double);

        // Cộng dồn giá trị của từng danh mục
        categoryTotal[category] = (categoryTotal[category] ?? 0.0) + amount;

        // Lưu màu sắc cho từng danh mục nếu chưa có
        if (!categoryColors.containsKey(category)) {
          categoryColors[category] = _getRandomColor();
        }
      }

      // Xây dựng lại PieChart với dữ liệu đã gộp
      List<Map<String, dynamic>> newCategoryDataList = [];
      categoryTotal.forEach((category, totalAmount) {
        newTotal += totalAmount; // Cộng dồn tổng
        newSections.add(
          PieChartSectionData(
            color: categoryColors[category]!,
            value: totalAmount,
            radius: 60,
            showTitle: false,
          ),
        );

        newCategoryDataList.add({
          'category': category,
          'amount': totalAmount,
          'color': categoryColors[category],
        });
      });

      // Cập nhật dữ liệu trong state
      setState(() {
        totalAmount = newTotal;
        sections = newSections;
        categoryDataList = newCategoryDataList;
      });

      // Cập nhật dữ liệu cho FinancialReportScreen
      widget.onDataUpdated(newCategoryDataList);
    } catch (e) {
      print("Lỗi khi lấy dữ liệu Firestore: $e");
    }
  }

  // Hàm để lấy màu sắc cho mỗi danh mục
  Color _getCategoryColor(String category) {
    if (categoryColors.containsKey(category)) {
      return categoryColors[category]!;
    } else {
      Random random = Random();
      Color randomColor = _getRandomColor();
      categoryColors[category] = randomColor;
      return randomColor;
    }
  }

  // Lấy màu sắc ngẫu nhiên từ danh sách có sẵn
  Color _getRandomColor() {
    List<Color> availableColors = [
      Colors.green,
      Colors.blue,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.yellow,
      Colors.teal,
      Colors.indigo,
      Colors.brown,
      Colors.cyan,
      Colors.pink,
      Colors.amber,
      Colors.lime,
      Colors.deepPurple,
      Colors.deepOrange,
    ];

    Random random = Random();
    return availableColors[random.nextInt(availableColors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 40),
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            PieChartData(
              sections: sections.isEmpty ? [] : sections,
              sectionsSpace: 0,
              centerSpaceRadius: 60,
            ),
          ),
          Text(
            '\$ ${totalAmount.toStringAsFixed(1)}',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color:
                  widget.isIncome
                      ? const Color.fromARGB(221, 14, 184, 73) // Màu cho Income
                      : Colors.red, // Màu đỏ cho Expense
            ),
          ),
        ],
      ),
    );
  }
}
