import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: GridView.builder(
          itemCount: 10,
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/product_screen');
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    const Spacer(
                      flex: 1,
                    ),
                    const CircleAvatar(
                      backgroundImage: AssetImage('images/shoes.png'),
                      radius: 60,
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    Text(
                      'Nike Jordan 1 Retro'
                      'Yellow',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.bold,
                          color: Color(0XFFFF7750)),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
