import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_store/get/address_getx_controller.dart';
import 'package:smart_store/model/country.dart';
import 'package:smart_store/models/address.dart';
import 'package:smart_store/screen/app/addresses/updated_address_screen.dart';
import 'package:smart_store/widget/app_text_field.dart';

import '../../../get/cities_getx_controller.dart';
import '../../../models/cities.dart';
import '../../../utils/helpers.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> with Helpers {
  CitiesGetxController citiesGetxController =
      Get.put<CitiesGetxController>(CitiesGetxController());
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
    Get.put<AddressGetController>(AddressGetController());
    Get.put<CitiesGetxController>(CitiesGetxController());
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
      appBar: AppBar(
        title: const Text('Addresses'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
        children: [
          GestureDetector(
            onTap: () {
              _showConfirmyBottomSheet();
            },
            child: Container(
              height: 100,
              child: Row(
                children: [
                  const Icon(Icons.location_pin,
                      size: 30, color: Color(0XFFFF7750)),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    'Your Addresses',
                    style: GoogleFonts.nunitoSans(
                        fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      _showConfirmyBottomSheet();
                    },
                    icon: const Icon(Icons.arrow_forward_ios,
                        color: const Color(0XFFFF7750)),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 25.h,
          ),
          AppTextField(
              hint: 'Name',
              prefixIcon: Icons.person,
              keyboardType: TextInputType.name,
              controller: _nameTextController),
          SizedBox(
            height: 15.h,
          ),
          AppTextField(
              hint:
                  'Info (brief description for the street and building name for example)',
              prefixIcon: Icons.info,
              keyboardType: TextInputType.text,
              controller: _infoTextController),
          SizedBox(
            height: 15.h,
          ),
          AppTextField(
              hint: 'Contact number',
              prefixIcon: Icons.phone,
              format: [
                LengthLimitingTextInputFormatter(9),
                FilteringTextInputFormatter.digitsOnly
              ],
              keyboardType: const TextInputType.numberWithOptions(
                  decimal: false, signed: false),
              controller: _mobileTextController),
          SizedBox(
            height: 25.h,
          ),
          GetBuilder<CitiesGetxController>(builder: (controller) {
            List<Cities> city = controller.citiesItems;
            return DropdownButton(
              hint: const Text('Select your Country'),
              style: GoogleFonts.montserrat(color: Colors.black),
              onTap: () {},
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
              items: city.map(
                (country) {
                  return DropdownMenuItem(
                    value: country.id,
                    child: Text(country.nameEn),
                  );
                },
              ).toList(),
            );
          })
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsetsDirectional.only(end: 25.w, bottom: 25.h),
        child: FloatingActionButton(
          backgroundColor: const Color(0XFFFF7750),
          child: const Icon(Icons.done),
          onPressed: () {
            _performOk();
          },
        ),
      ),
    );
  }

  void _showConfirmyBottomSheet() {
    Address? address;
    int? gIndex;
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.r),
                topLeft: Radius.circular(20.r))),
        clipBehavior: Clip.antiAlias,
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return BottomSheet(onClosing: () {
            Navigator.pop(context);
          }, builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
                  child: GetBuilder<AddressGetController>(
                    builder: (controller) {
                      var list = controller.list;

                      return Column(
                        children: [
                          Text(
                            'Your Adresses',
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.bold),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              address = list[index];
                              gIndex = index;
                              print("size ${list.length}");
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Stack(
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.location_pin,
                                              size: 30,
                                              color: const Color(0XFFFF7750)),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Text(
                                            list[index].info,
                                            style: GoogleFonts.nunitoSans(
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional.centerEnd,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(40.r),
                                              boxShadow: [
                                                BoxShadow(
                                                    color:
                                                        Colors.orange.shade100)
                                              ]),
                                          child: IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(Icons.update),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  const Divider(),
                                ],
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            );
          });
        }).then(
      (value) => {
        if(address != null){
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return UpdatedAddressScreen(address: address!, index: gIndex!);
          },))
        }
      },
    );
  }

  void _performOk() async {
    if (_checkData()) {
      print("number ${_mobileTextController.text}");
      var res = await AddressGetController.to.createNewAddress(
        Address(
          name: _nameTextController.text,
          info: _infoTextController.text,
          contactNumber: _mobileTextController.text,
          cityId: _selectedCountryId!,
        ),
      );
      if (res.status) {
        _ok();
      }
      // ignore: use_build_context_synchronously
      showSnackBar(context, message: res.message, erorr: !res.status);
    }
  }

  bool _checkData() {
    if (_nameTextController.text.isNotEmpty &&
        _infoTextController.text.isNotEmpty &&
        _mobileTextController.text.isNotEmpty &&
        _mobileTextController.text.length == 9 &&
        _selectedCountryId != null) {
      return true;
    }
    showSnackBar(context, message: 'Check your required  Data', erorr: true);
    return false;
  }

  void _ok() {
    Future.delayed(const Duration(milliseconds: 500), () {
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
                    Center(
                        child: Icon(
                      Icons.done,
                      color: const Color(0XFF31D1DA),
                      size: 50.sp,
                    ))
                  ],
                ),
                AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r)),
                  title: Text(
                    'Add Address Successfully!',
                    style: GoogleFonts.nunitoSans(
                        fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  content: Text(
                    'You can add more addresses',
                    style: GoogleFonts.nunitoSans(fontSize: 14),
                  ),
                ),
              ],
            );
          });
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pop(context);
      });
    });
  }
}
