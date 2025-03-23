import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newapp/asset/bottomnavigation.dart';
import 'package:newapp/asset/widget/home_widget.dart/balance_section.dart';
import 'package:newapp/asset/widget/home_widget.dart/transaction_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedTab = 'Today'; // Biến để lưu trạng thái tab đang chọn
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _updateDateRange();
  }

  // Cập nhật dải ngày theo tab chọn
  void _updateDateRange() {
    final now = DateTime.now();

    switch (selectedTab) {
      case 'Today':
        _startDate = DateTime(now.year, now.month, now.day);
        _endDate = _startDate!.add(const Duration(days: 1)); // Ngày hôm nay
        break;
      case 'Week':
        // Lấy tuần trước: tính ngày bắt đầu của tuần trước
        _startDate = now.subtract(
          Duration(days: now.weekday + 6),
        ); // Bắt đầu từ chủ nhật tuần trước
        // Lấy ngày cuối tuần của tuần trước (chủ nhật tuần trước)
        _endDate = _startDate!.add(const Duration(days: 7));
        break;
      case 'Month':
        // Lấy tháng trước: tính ngày đầu tháng trước
        _startDate = DateTime(now.year, now.month - 1, 1);
        // Lấy ngày đầu tháng này
        _endDate = DateTime(now.year, now.month, 1);
        break;
      case 'Year':
        // Lấy năm trước: tính ngày đầu năm trước
        _startDate = DateTime(now.year - 1, 1, 1);
        // Lấy ngày đầu năm này
        _endDate = DateTime(now.year, 1, 1);
        break;
    }

    setState(() {}); // Cập nhật lại giao diện sau khi thay đổi dải ngày
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                _buildHeader(screenWidth, screenHeight),
                const BalanceSection(),
                _buildTabs(screenWidth),
                _buildTransactionsList(screenWidth, screenHeight),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CustomBottomNav(
                currentIndex: 0,
                onTap: (index) {
                  // Handle navigation
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(double screenWidth, double screenHeight) {
    User? user = FirebaseAuth.instance.currentUser;
    // Danh sách tên các tháng
    List<String> monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    // Lấy thời gian hiện tại
    DateTime now = DateTime.now();
    String day = now.day.toString(); // Lấy ngày hiện tại
    String month = monthNames[now.month - 1]; // Lấy tên tháng từ danh sách
    String year = now.year.toString(); // Lấy năm hiện tại

    // Lấy tên ngày trong tuần
    String dayOfWeek = _getDayOfWeek(
      now.weekday,
    ); // Hàm lấy tên ngày trong tuần

    return Container(
      padding: EdgeInsets.all(screenWidth * 0.05),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF7F3DFF), Colors.transparent],
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(screenWidth * 0.08),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hiển thị tên ngày trong tuần và ngày
              Text(
                '$dayOfWeek $day',

                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              // Hiển thị tên tháng và năm
              Text(
                '$month $year',
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          // Hiển thị tên người dùng hoặc thông tin khác
          Text(
            user?.displayName ?? 'nhan',
            style: TextStyle(
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // Hàm lấy tên ngày trong tuần
  String _getDayOfWeek(int weekday) {
    switch (weekday) {
      case 0:
        return 'SUNDAY';
      case 1:
        return 'MONDAY';
      case 2:
        return 'TUESDAY';
      case 3:
        return 'WEDNESDAY';
      case 4:
        return 'THURSDAY';
      case 5:
        return 'FRIDAY';
      case 6:
        return 'SATURDAY';
      default:
        return '';
    }
  }

  Widget _buildTabs(double screenWidth) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenWidth * 0.06,
      ),
      padding: EdgeInsets.all(screenWidth * 0.01),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.04),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _TabItem(
            label: 'Today',
            isActive: selectedTab == 'Today',
            screenWidth: screenWidth,
            onTap: () {
              setState(() {
                selectedTab = 'Today';
                _updateDateRange(); // Cập nhật bộ lọc
              });
            },
          ),
          _TabItem(
            label: 'Week',
            isActive: selectedTab == 'Week',
            screenWidth: screenWidth,
            onTap: () {
              setState(() {
                selectedTab = 'Week';
                _updateDateRange(); // Cập nhật bộ lọc
              });
            },
          ),
          _TabItem(
            label: 'Month',
            isActive: selectedTab == 'Month',
            screenWidth: screenWidth,
            onTap: () {
              setState(() {
                selectedTab = 'Month';
                _updateDateRange(); // Cập nhật bộ lọc
              });
            },
          ),
          _TabItem(
            label: 'Year',
            isActive: selectedTab == 'Year',
            screenWidth: screenWidth,
            onTap: () {
              setState(() {
                selectedTab = 'Year';
                _updateDateRange(); // Cập nhật bộ lọc
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsList(double screenWidth, double screenHeight) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Transaction',
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'View All',
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance
                        .collection('transactions')
                        .where(
                          'uid',
                          isEqualTo: FirebaseAuth.instance.currentUser?.uid,
                        )
                        .orderBy('createdAt')
                        .startAt([Timestamp.fromDate(_startDate!)])
                        .endAt([Timestamp.fromDate(_endDate!)])
                        .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text(
                        "No transactions found",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    );
                  }

                  var transactions = snapshot.data!.docs;

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      var transaction =
                          transactions[index].data() as Map<String, dynamic>;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 5,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: screenWidth * 0.1,
                              height: screenWidth * 0.1,
                              decoration: BoxDecoration(
                                color:
                                    transaction['transactionType'] == 'Income'
                                        ? Colors.green
                                        : Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                transaction['transactionType'] == 'Income'
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "\$ ${transaction['amount'].toString()}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              transaction['category'] ?? 'Unknown',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black45,
                              ),
                            ),
                          ],
                        ),
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

class _TabItem extends StatelessWidget {
  final String label;
  final double screenWidth;
  final bool isActive;
  final VoidCallback onTap;

  const _TabItem({
    // ignore: unused_element_parameter
    super.key,
    required this.label,
    required this.screenWidth,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.06,
          vertical: screenWidth * 0.02,
        ),
        decoration: BoxDecoration(
          color: isActive ? Colors.purple : Colors.transparent,
          borderRadius: BorderRadius.circular(screenWidth * 0.04),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black,
            fontSize: screenWidth * 0.04,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
