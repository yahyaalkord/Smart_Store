import 'package:flutter/material.dart';

class PageViewIndicator extends StatelessWidget {
  const PageViewIndicator({
    required this.isCurrentPage,
    this.marginEnd=0,
    Key? key,
  }) : super(key: key);
 final bool isCurrentPage;
 final double marginEnd;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(end: marginEnd),
      height: 4,
      width: 18,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: isCurrentPage ?Color(0XFFFF7750): Colors.grey,
      ),
    );
  }
}