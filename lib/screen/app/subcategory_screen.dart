import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_store/screen/app/products_screen.dart';

import '../../api/sup_categories_api_controller.dart';
import '../../models/sup_categories.dart';
import 'categories_screen.dart';

int? catId;

class SubCategoryScreen extends StatefulWidget {
  const SubCategoryScreen({required this.id, Key? key}) : super(key: key);

  final int id;

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title??''),
        ),
        body: FutureBuilder<List<SubCategories>>(
          future: SubCategoriesApiController()
              .getSubCategories(categoryId: widget.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return GridView.builder(
                  itemCount: snapshot.data!.length,
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductsScreen(id: snapshot.data![index].id),
                            ));
                        /*Navigator.pushNamed(context, '/product_screen');*/
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
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              // backgroundImage: ,
                              child: Image(
                                image: NetworkImage(
                                    snapshot.data![index].imageUrl),
                                fit: BoxFit.cover,
                              ),
                              radius: 60,
                            ),
                            const Spacer(
                              flex: 2,
                            ),
                            Text(
                              snapshot.data![index].nameEn,
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
                  });
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
