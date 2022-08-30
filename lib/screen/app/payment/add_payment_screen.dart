import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_store/utils/helpers.dart';
import 'package:smart_store/widget/app_elevated_botton.dart';
import 'package:smart_store/widget/app_text_field.dart';

class AddPaymentScreen extends StatefulWidget {
  const AddPaymentScreen({Key? key}) : super(key: key);

  @override
  State<AddPaymentScreen> createState() => _AddPaymentScreenState();
}

class _AddPaymentScreenState extends State<AddPaymentScreen> with Helpers{
  late TextEditingController _textEditingController;
  late TextEditingController _textEditingController1;
  late TextEditingController _textEditingController2;
  late TextEditingController _textEditingController3;
  late TextEditingController _textEditingController4;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textEditingController = TextEditingController();
    _textEditingController1 = TextEditingController();
    _textEditingController2 = TextEditingController();
    _textEditingController3 = TextEditingController();
    _textEditingController4 = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _textEditingController1.dispose();
    _textEditingController2.dispose();
    _textEditingController3.dispose();
    _textEditingController4.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('New Payment'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
        child: Column(
          children: [
            AppTextField(
              hint: 'card Number',
              prefixIcon: Icons.payment,
              keyboardType: TextInputType.numberWithOptions(
                  signed: false, decimal: false),
              controller: _textEditingController,
            ),
            SizedBox(
              height: 20.h,
            ),
            AppTextField(
              hint: 'Full Name',
              prefixIcon: Icons.person,
              keyboardType: TextInputType.numberWithOptions(
                  signed: false, decimal: false),
              controller: _textEditingController1,
            ),
            SizedBox(
              height: 20.h,
            ),
            AppTextField(
              hint: 'Type',
              prefixIcon: Icons.payments,
              keyboardType: TextInputType.numberWithOptions(
                  signed: false, decimal: false),
              controller: _textEditingController2,
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                SizedBox(
                  height: 100.h,
                  width: 100.w,
                  child: TextField(
                    controller: _textEditingController3,
                    maxLength: 4,
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: false, signed: false),
                    decoration: InputDecoration(
                      hintText: 'CCV',
                    ),
                  ),
                ),
                Spacer(),
                SizedBox(
                  height: 100.h,
                  width: 150.w,
                  child: AppTextField(
                      hint: 'XX/YY',
                      prefixIcon: Icons.date_range,
                      keyboardType: TextInputType.text,
                      controller: _textEditingController4),
                )
              ],
            ),
            Spacer(),
            AppElevatedBotton(title: 'Save', onPressed: () =>_performSave())
          ],
        ),
      ),
    );
  }

  void _performSave() {
    if (_checkData()) {
      _save();
    }
  }

  bool _checkData() {
    if (_textEditingController.text.isNotEmpty &&
        _textEditingController1.text.isNotEmpty &&
        _textEditingController2.text.isNotEmpty &&
        _textEditingController3.text.isNotEmpty &&
        _textEditingController4.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context, message: 'Enter Your Required Data');
    return false;
  }

  void _save() {
    Navigator.pop(context);
    showSnackBar(context, message: 'Save Successfully', erorr: false);
  }
}
