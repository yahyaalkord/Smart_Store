import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_store/model/country.dart';
import 'package:smart_store/widget/app_text_field.dart';

import '../../utils/helpers.dart';

class UpdatedAddressScreen extends StatefulWidget {
  const UpdatedAddressScreen({Key? key}) : super(key: key);

  @override
  State<UpdatedAddressScreen> createState() => _UpdatedAddressScreenState();
}

class _UpdatedAddressScreenState extends State<UpdatedAddressScreen> with Helpers{
  late TextEditingController _nameTextController;
  late TextEditingController _mobileTextController;
  late TextEditingController _infoTextController;
  int? _selectedCountryId;

  final List<Country> _country = <Country>[
    const Country(id: 1, title: 'North'),
    const Country(id: 2, title: 'Gaza'),
    const Country(id: 3, title: 'Central Region'),
    const Country(id: 4, title: 'Khan Younes'),
    const Country(id: 4, title: 'Rafah'),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameTextController = TextEditingController();
    _mobileTextController = TextEditingController();
    _infoTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameTextController.dispose();
    _mobileTextController.dispose();
    _infoTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('UpdatedAddress'),
        actions: [
          IconButton(onPressed: (){
            showSnackBar(context, message: 'Deleted Successfully',erorr: false);
            Navigator.pushReplacementNamed(context, '/address_screen');
          }, icon: Icon(Icons.delete,color: Colors.red,),)
        ],
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 25.w,vertical: 40.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.r),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.orange.shade100
                    )
                  ]
              ),
              child: Icon(Icons.location_pin,size: 100,),
            ),
            SizedBox(height: 50.h,),
            AppTextField(
                hint: 'Name',
                prefixIcon: Icons.person,
                keyboardType: TextInputType.name,
                controller: _nameTextController),
            SizedBox(height: 15.h,),
            AppTextField(
                hint:
                    'Info (brief description for the street and building name for example)',
                prefixIcon: Icons.info,
                keyboardType: TextInputType.text,
                controller: _mobileTextController),
            SizedBox(height: 15.h,),
            AppTextField(
                hint: 'Contact number',
                prefixIcon: Icons.phone,
                keyboardType: TextInputType.numberWithOptions(
                    decimal: false, signed: false),
                controller: _infoTextController),
            SizedBox(height: 25.h,),
            DropdownButton<int>(
              hint: const Text('Select your Country'),
              style: GoogleFonts.montserrat(color: Colors.black),
              onTap: () {
              },
              icon: const Icon(Icons.keyboard_arrow_down),
              // itemHeight: 65,
              dropdownColor: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
              elevation: 5,
              underline: const Divider(
                color: Colors.black,
                thickness: 1,
                height: 0,
              ),
              isExpanded: true,
              value: _selectedCountryId,
              onChanged: (int? value) {
                setState(() {
                  _selectedCountryId = value;
                });
              },
              items: _country.map((country) {
                return DropdownMenuItem<int>(
                  value: country.id,
                  child: Text(country.title),
                );
              },
              ).toList(),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding:  EdgeInsetsDirectional.only(end: 25.w,bottom: 25.h),
        child: FloatingActionButton(
          backgroundColor: Color(0XFFFF7750),
            child: Icon(Icons.done),
            onPressed: (){
              _performOk();
        }),
      ),
    );
  }
  


  void _performOk() {
    if (_checkData()) {
      _ok();
    }
  }

  bool _checkData() {
    if (_nameTextController.text.isNotEmpty &&
        _infoTextController.text.isNotEmpty &&
        _mobileTextController.text.isNotEmpty&&
        _selectedCountryId != null
        ) {
      return true;
    }
    showSnackBar(context, message: 'Check your required  Data',erorr: true);
    return false;
  }

  void _ok() {
    Future.delayed(Duration(seconds: 1),(){

      showDialog(
          context: context,
          builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset('images/Fill.png'),
                    Center(child: Icon(Icons.done,color: Color(0XFF31D1DA),size: 50.sp,))
                  ],
                ),
                AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r)
                  ),
                  title: Text(
                    'Updated Address Successfully!',
                    style: GoogleFonts.nunitoSans(
                        fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  content: Text(
                    'Check for Your addresses',
                    style: GoogleFonts.nunitoSans(fontSize: 14),
                  ),
                ),
              ],
            );
          });
    });
    Future.delayed(Duration(seconds: 3),(){
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, '/address_screen');
    });
  }
}
