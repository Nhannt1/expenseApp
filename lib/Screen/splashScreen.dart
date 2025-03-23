import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newapp/createAccount/sign_Up.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 360),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Top Image
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60),
                    ),

                    child: Image.network(
                      'https://img.freepik.com/free-vector/credit-score-flat-background-with-male-character-holding-coin-surrounded-by-round-compositions-financial-icons-vector-illustration_1284-83829.jpg?t=st=1741696844~exp=1741700444~hmac=cc5ec0e6c8d2e232cb7fe10dda8957198a7e87cd237731c3142cb1a1d97614be&w=996',
                      width: double.infinity, // Điều chỉnh chiều ngang ảnh
                      height: 280,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Main Title
                  Container(
                    margin: const EdgeInsets.only(top: 80),
                    child: Text(
                      'Simple solution for\nyour budget.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  // Subtitle
                  Container(
                    margin: const EdgeInsets.only(top: 35),
                    child: Text(
                      'Counter and distribute the income\ncorrectly...',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  // Continue Button
                  Container(
                    margin: const EdgeInsets.only(top: 32),
                    child: Material(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpScreen(),
                            ),
                          );
                        },
                        child: Container(
                          width: 194,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 51,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.25),
                                offset: Offset(0, 4),
                                blurRadius: 4,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Text(
                            'Continue',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Bottom padding
                  const SizedBox(height: 31),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
