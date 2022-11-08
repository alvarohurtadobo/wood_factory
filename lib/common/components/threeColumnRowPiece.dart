import 'package:flutter/material.dart';
import 'package:wood_center/common/sizes.dart';

Widget threeColumnRowPiece(Widget left, Widget middle, Widget right) {
  return Container(
    width: Sizes.width,
    height: Sizes.tileNormal,
    padding: EdgeInsets.symmetric(
        horizontal: Sizes.padding, vertical: Sizes.boxSeparation),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(width: 0.16 * Sizes.width, child: left),
        Container(
            alignment: Alignment.centerLeft,
            width: 0.14 * Sizes.width,
            child: middle),
        Expanded(
            child: Container(alignment: Alignment.centerRight, child: right))
      ],
    ),
  );
}
