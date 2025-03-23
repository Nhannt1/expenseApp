import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newapp/Screen/homeScreen.dart';

class TransactionInputScreen extends StatefulWidget {
  const TransactionInputScreen({super.key});

  @override
  _TransactionInputScreenState createState() => _TransactionInputScreenState();
}

class _TransactionInputScreenState extends State<TransactionInputScreen> {
  bool isIncome = true;
  // String amount = '556';
  final TextEditingController amountController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  void dispose() {
    amountController.dispose();
    categoryController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0, 0.183),
            end: Alignment(0, 1.2427),
            colors: [
              Color.fromARGB(255, 225, 204, 15), // light background color
              Color(0x00F8EDD8), // transparent color for gradient end
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 19,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Color.fromARGB(255, 1, 0, 2),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Add Transaction',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Inter',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 40), // For balance
                  ],
                ),
              ),

              // Amount Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 21),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'How much?',
                      style: TextStyle(
                        color: Color(0xFF0A0000),
                        fontFamily: 'Inter',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 17),
                    Row(
                      children: [
                        const Icon(
                          Icons.attach_money,
                          size: 36,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 9),
                        Expanded(
                          child: TextField(
                            controller: amountController,
                            decoration: InputDecoration(
                              hintText: '0',
                              hintStyle: TextStyle(
                                // Chỉnh kích thước chữ gợi ý
                                fontSize: 18, // Kích thước chữ
                                fontWeight: FontWeight.w400, // Độ đậm của chữ
                                color: Colors.grey, // Màu chữ gợi ý
                              ),
                              border: InputBorder.none,

                              contentPadding: const EdgeInsets.all(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Form Section
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF1F8E9), // Form background color
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        // Category Input
                        TextField(
                          controller: categoryController,
                          decoration: InputDecoration(
                            hintText: 'Category',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: const EdgeInsets.all(12),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Description Input
                        TextField(
                          controller: descriptionController,
                          decoration: InputDecoration(
                            hintText: 'Description',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: const EdgeInsets.all(12),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Transaction Type Toggle
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => isIncome = true),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        isIncome
                                            ? Colors.green
                                            : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color:
                                          isIncome
                                              ? Colors.green
                                              : const Color.fromARGB(
                                                255,
                                                19,
                                                200,
                                                80,
                                              ), // Nếu không phải income, viền màu đỏ
                                      width: 1.5, // Độ dày của viền
                                    ),
                                  ),
                                  child: Text(
                                    'Income',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color:
                                          isIncome
                                              ? Colors.white
                                              : Color.fromARGB(255, 48, 13, 13),
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
                                onTap: () => setState(() => isIncome = false),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        !isIncome
                                            ? Colors.red
                                            : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color:
                                          isIncome
                                              ? Colors.redAccent
                                              : Colors
                                                  .red, // Nếu không phải income, viền màu đỏ
                                      width: 1.5, // Độ dày của viền
                                    ),
                                  ),
                                  child: Text(
                                    'Expense',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color:
                                          isIncome
                                              ? const Color.fromARGB(
                                                255,
                                                5,
                                                1,
                                                1,
                                              )
                                              : Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Date Input
                        TextField(
                          controller: dateController,
                          decoration: InputDecoration(
                            hintText: 'Pick your date',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: const EdgeInsets.all(12),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Continue Button
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: _saveTransaction,
                            // Handle continue action
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue, // Primary color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              'Continue',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Inter',
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveTransaction() async {
    String amount = amountController.text;
    String category = categoryController.text;
    String description = descriptionController.text;
    String transactionType =
        isIncome ? "Income" : "Expense"; // Lấy giá trị đã chọn
    String pickdate = dateController.text;

    if (amount.isEmpty || category.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    } // Lấy UID của người dùng hiện tại
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("User not logged in")));
      return;
    }
    String uid = user.uid; // UID của người dùng
    try {
      await FirebaseFirestore.instance.collection('transactions').add({
        'uid': uid, // Lưu UID của người dùng
        'amount': double.parse(amount),
        'category': category,
        'description': description,
        'transactionType': transactionType, // Income hoặc Expense
        'date': pickdate,
        'createdAt': FieldValue.serverTimestamp(),
      });
      amountController.clear();
      descriptionController.clear();
      categoryController.clear();
      dateController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Transaction saved successfully!")),
      );
      print("them thanh cong");
      // Navigator.pop(context); // Quay lại màn hình trước
    } catch (e) {
      print("Error saving transaction: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }
}
