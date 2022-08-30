import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

mixin Helpers {
  void showSnackBar(BuildContext context, {required String message, bool erorr = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message,style: GoogleFonts.nunitoSans(),),
        backgroundColor: erorr ? Colors.red.shade700 : Colors.blue.shade300,
        duration: Duration(seconds: 2),
        dismissDirection: DismissDirection.horizontal,

      ),
    );
  }
}
