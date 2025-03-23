import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newapp/asset/widget/transaction_report/category_card.dart';
import 'package:newapp/asset/widget/transaction_report/chartFL_display.dart';
import 'package:newapp/asset/widget/transaction_report/customTag.dart';
import 'package:newapp/asset/widget/transaction_report/month_selecter.dart';

class FinancialReportScreen extends StatefulWidget {
  const FinancialReportScreen({super.key});

  @override
  State<FinancialReportScreen> createState() => _FinancialReportScreenState();
}

class _FinancialReportScreenState extends State<FinancialReportScreen> {
  int _selectedTabIndex = 0;
  List<Map<String, dynamic>> categoryDataList = [];
  List<Map<String, dynamic>> expenseDataList = [];

  void updateCategoryData(List<Map<String, dynamic>> categories) {
    setState(() {
      if (_selectedTabIndex == 0) {
        // Cập nhật danh mục cho Income
        categoryDataList = categories;
      } else {
        // Cập nhật danh mục cho Expense
        expenseDataList = categories;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Màu nền xám nhạt
      body: SafeArea(
        child: Column(
          children: [
            _buildTopNav(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    MonthSelector(),
                    // Hiển thị biểu đồ và cập nhật dữ liệu khi có thay đổi tab
                    ChartDisplay(
                      onDataUpdated: updateCategoryData,
                      isIncome:
                          _selectedTabIndex ==
                          0, // Kiểm tra Income hoặc Expense
                    ),
                    CustomTabSelector(
                      selectedIndex: _selectedTabIndex,
                      onTabSelected: (index) {
                        setState(() {
                          _selectedTabIndex = index;
                        });
                        // Gọi lại dữ liệu đúng (không cần gọi fetchData nữa nếu ChartDisplay đã xử lý)
                        // Khi tab thay đổi, bạn chỉ cần truyền lại dữ liệu cho ChartDisplay
                        updateCategoryData(
                          _selectedTabIndex == 0
                              ? categoryDataList
                              : expenseDataList,
                        );
                      },
                    ),
                    _buildCategories(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopNav() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: Colors.purple, // Màu tím
              size: 32,
            ),
          ),
          Expanded(
            child: Text(
              'Financial Report',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87, // Màu đen đậm
              ),
            ),
          ),
          const SizedBox(width: 32), // Dành cho khoảng cách
        ],
      ),
    );
  }

  Widget _buildCategories() {
    // Lấy danh mục hiện tại dựa trên tab được chọn (Income/Expense)
    List<Map<String, dynamic>> currentCategoryData =
        _selectedTabIndex == 0 ? categoryDataList : expenseDataList;

    // Kiểm tra nếu danh mục dữ liệu trống
    if (currentCategoryData.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Text(
            "Không có dữ liệu danh mục!",
            style: TextStyle(fontSize: 16, color: Colors.black45),
          ),
        ),
      );
    }

    // Xây dựng danh sách các CategoryCard
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children:
            currentCategoryData.map((data) {
              // Tính tỷ lệ phần trăm cho mỗi danh mục
              double totalAmount = currentCategoryData.fold(
                0.0,
                (sum, item) => sum + item['amount'],
              );
              double progress = (data['amount'] / totalAmount);

              return CategoryCard(
                category: data['category'],
                amount: data['amount'],
                progress: progress, // Tỷ lệ phần trăm
                color: data['color'],
                isIncome: _selectedTabIndex == 0, // Dựa trên tab hiện tại
              );
            }).toList(),
      ),
    );
  }
}
