import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_store/api/categories_api_controller.dart';
import 'package:smart_store/screen/app/subcategory_screen.dart';

import '../../models/categories.dart';

String? title;

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Categories'),
        ),
        body: FutureBuilder<List<Categories>>(
          future: CategoriesApiController().getCategories(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SubCategoryScreen(id: snapshot.data![index].id),
                          ));
                      /* Navigator.pushNamed(context, '/subcategory_screen');*/
                      title = snapshot.data![index].nameEn;
                    },
                    child: Container(
                      height: 100,
                      margin: EdgeInsetsDirectional.only(
                          bottom: index == 9 ? 0 : 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black45,
                              offset: Offset(0, 0),
                              blurRadius: 5,
                            )
                          ]),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 40.r,
                              backgroundImage:
                                  NetworkImage(snapshot.data![index].imageUrl),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data![index].nameEn,
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.sp),
                                ),
                              ],
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, '/subcategory_screen');
                                },
                                icon: Icon(Icons.arrow_forward_ios))
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text(
                  'No DATA',
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.bold, fontSize: 20.sp),
                ),
              );
            }
          },
        ));
  }
}
