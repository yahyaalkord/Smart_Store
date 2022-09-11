import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_store/get/address_getx_controller.dart';
import 'package:smart_store/get/cities_getx_controller.dart';
import 'package:smart_store/model/country.dart';
import 'package:smart_store/widget/app_text_field.dart';

import '../../../models/address.dart';
import '../../../utils/helpers.dart';

class UpdatedAddressScreen extends StatefulWidget {
  /*const*/ UpdatedAddressScreen({Key? key,required this.address,required this.index}) : super(key: key);
  Address address;
  int index;

  @override
  State<UpdatedAddressScreen> createState() => _UpdatedAddressScreenState();
}

class _UpdatedAddressScreenState extends State<UpdatedAddressScreen> with Helpers{
  late TextEditingController _nameTextController;
  late TextEditingController _mobileTextController;
  late TextEditingController _infoTextController;
  int? _selectedCountryId;

 /* final List<Country> _country = <Country>[
    const Country(id: 1, title: 'North'),
    const Country(id: 2, title: 'Gaza'),
    const Country(id: 3, title: 'Central Region'),
    const Country(id: 4, title: 'Khan Younes'),
    const Country(id: 4, title: 'Rafah'),
  ];*/

  @override
  void initState() {
    super.initState();
    _nameTextController = TextEditingController()..text =  widget.address.name;
    _mobileTextController = TextEditingController()..text =  widget.address.contactNumber;
    _infoTextController = TextEditingController()..text =  widget.address.info;
    _selectedCountryId = widget.address.cityId;
  }

  @override
  void dispose() {
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
            deleted();
            // Navigator.pushReplacementNamed(context, '/address_screen');
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
                controller: _infoTextController),
            SizedBox(height: 15.h,),
            AppTextField(
                hint: 'Contact number',
                prefixIcon: Icons.phone,
                keyboardType: TextInputType.numberWithOptions(
                    decimal: false, signed: false),
                controller: _mobileTextController),
            SizedBox(height: 25.h,),
            DropdownButton(
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
              items: CitiesGetxController.to.citiesItems.map((country) {
                return DropdownMenuItem(
                  value: country.id,
                  child: Text(country.nameEn),
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


  void _performOk() async{
    if (_checkData()) {
      var address = Address(
        name: _nameTextController.text,
        info: _infoTextController.text,
        contactNumber: _mobileTextController.text,
        cityId: _selectedCountryId!,);
      address.id = widget.address.id;
      var response = await AddressGetController.to.updateAddress(address);
      if(response.status){
        _ok();
      }
      showSnackBar(context, message: response.message,erorr: !response.status);
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
  void deleted() async {
    var response = await AddressGetController.to.deleteAddress(widget.index);
    if(response.status){
      // ignore: use_build_context_synchronously
      showSnackBar(context, message: response.message);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
    // ignore: use_build_context_synchronously
    showSnackBar(context, message: response.message,erorr: !response.status);
  }
}
