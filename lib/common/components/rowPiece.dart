import 'package:flutter/material.dart';
import 'package:wood_center/common/sizes.dart';

Widget rowPiece(Widget left, Widget right, {bool flat = false}) {
  return Container(
    width: Sizes.width,
    height: flat?Sizes.tileNormal/2:Sizes.tileNormal,
    padding: EdgeInsets.symmetric(
        horizontal: Sizes.padding, vertical: flat?0:Sizes.boxSeparation),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [left, const Expanded(child: SizedBox()), SizedBox(width: 0.32 * Sizes.width, child: right)],
    ),
  );
}
