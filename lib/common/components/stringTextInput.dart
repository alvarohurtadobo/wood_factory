import 'package:flutter/material.dart';
import 'package:wood_center/common/sizes.dart';

Widget StringTextInput(Function(double) updateParam, {String prevalue = ""}) {
  return Container(
    alignment: Alignment.center,
    // width: 0.32 * Sizes.width,
    height: Sizes.tileNormal,
    decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xff343434)))),
    child: TextField(
        enabled: false,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,
          hintText: prevalue,
          contentPadding: EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
          // enabledBorder: OutlineInputBorder(
          //   borderSide: const BorderSide(width: 1, color: Color(0xff343434)),
          //   borderRadius: BorderRadius.circular(8),
          // ),
          // focusedBorder: OutlineInputBorder(
          //   borderSide: const BorderSide(width: 1, color: Color(0xff0077CD)),
          //   borderRadius: BorderRadius.circular(8),
          // ),
          disabledBorder: null,
        ),
        onChanged: (value) {
          double? parsedValue = double.tryParse(value);
          if (parsedValue != null) {
            updateParam(parsedValue);
          }
        }),
  );
}
