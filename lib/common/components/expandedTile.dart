import 'package:flutter/material.dart';
import 'package:wood_center/common/sizes.dart';

Widget expandedTile(String title, Widget right) {
  return Container(
    width: Sizes.width,
    height: Sizes.tileNormal*1.4,
    padding: EdgeInsets.symmetric(
        horizontal: Sizes.padding, vertical: Sizes.boxSeparation),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: Sizes.font12),),
        SizedBox(width:  Sizes.width-2*Sizes.padding, child: right)
      ],
    ),
  );
}
