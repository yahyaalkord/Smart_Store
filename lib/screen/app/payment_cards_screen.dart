import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_store/model/payment_catds_controller.dart';
import 'package:smart_store/widget/card_info.dart';

class PaymentCardsScreen extends StatefulWidget {
  const PaymentCardsScreen({Key? key}) : super(key: key);

  @override
  State<PaymentCardsScreen> createState() => _PaymentCardsScreenState();
}

class _PaymentCardsScreenState extends State<PaymentCardsScreen> {
  final List<PaymentCards> _payment = <PaymentCards>[
    PaymentCards(name: 'Credit Card', type: 'VISA', holderName: 'YourBank', cardNumber: '1234 - 1234 - 1234', expirationDate: '15/9/2024', securityCode: 4565),
    PaymentCards(name: 'Credit Card', type: 'MASTER', holderName: 'Nordeo', cardNumber: '1234 - 1234 - 1234', expirationDate: '20/3/2023', securityCode: 1234),
  ];
  late PageController _pageController1;
  int _currentPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController1 = PageController(viewportFraction: 0.8, initialPage: 0);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _pageController1.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Payment Cards'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 25.h),
        children: [
          Text(
            '   My Wallet',
            style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold,fontSize: 20.sp),
            textAlign: TextAlign.start,
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 190),
            child: PageView(
              physics: const BouncingScrollPhysics(),
              // physics: ClampingScrollPhysics(),
              controller: _pageController1,
              scrollDirection: Axis.horizontal,
              onPageChanged: (int currentPage) {
                setState(() {
                  _currentPage = currentPage;
                });
              },
              children: const [
                Card(
                  elevation: 0,
                  child: Image(image: AssetImage('images/creditCard1.png')),
                ),
                Card(
                  elevation: 0,
                  child: Image(image: AssetImage('images/creditCard2.png')),
                ),

              ],
            ),
          ),
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: _payment.map((payment) {
      return GestureDetector(

        onTap: (){
          _procecsDialog();
        },
        child: Container(
          margin: EdgeInsetsDirectional.only(bottom: 15.h),
          height: 400.h,
          width: 295.w,
          decoration: BoxDecoration(
            boxShadow: [
              const BoxShadow(
                color: Colors.black45,
                offset: const Offset(3, 3),
                blurRadius: 6,
              )
            ],
              borderRadius: BorderRadius.circular(20.r),
              color: const Color(0XFFF9F3EE)
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CardInfo(title: 'Name:', info: payment.name),
              CardInfo(title: 'Type:', info: payment.type),
              CardInfo(title: 'Holder name:', info: payment.holderName),
              CardInfo(title: 'Card number:', info: payment.cardNumber),
              CardInfo(title: 'Expiration date:', info: payment.expirationDate),
              CardInfo(title: ' CCV – A security code:', info: payment.securityCode.toString()),
            ],
          ),
        ),
      );
    }).toList(),
          )
        ],
      ),
      floatingActionButton: Padding(
        padding:  EdgeInsetsDirectional.only(end: 55.w,bottom: 20.h),
        child: FloatingActionButton(
            backgroundColor: Color(0XFFFF7750),
            child: Icon(Icons.add),
            onPressed: (){

            }),
      ),
    );
  }

  void _procecsDialog() async {
    bool? result = await showDialog<bool>(
      // barrierColor: Colors.red.shade700.withOpacity(0.5),
      // barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              Row(
                children: [
                  const Spacer(),
                  TextButton(
                    onPressed: () {

                    },
                    child: const Text(
                      'Deleted',
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {

                    },
                    child: const Text(
                      'Updated'
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ],
          );
        });
  }
}


