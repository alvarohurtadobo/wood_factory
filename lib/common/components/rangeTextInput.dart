import 'package:flutter/material.dart';
import 'package:wood_center/common/sizes.dart';

Widget DoubleRangeTextInput(Function(double) updateParam1,Function(double) updateParam2,
    {bool hasUnits = false,
    TextEditingController? controllerLeft,
    TextEditingController? controllerRight}) {
  return Row(
    children: [
      Padding(
          padding: EdgeInsets.only(right: Sizes.boxSeparation / 2),
          child: const Text("Entre")),
      Container(
        width: 0.16 * Sizes.width,
        height: Sizes.tileNormal,
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xff343434)))),
        child: TextField(
          controller: controllerLeft,
          cursorColor: const Color(0xffbc171d),
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: Colors.white,
            border: InputBorder.none,
            hintText: "",
            contentPadding:
                EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
            // enabledBorder: OutlineInputBorder(
            //   borderSide: const BorderSide(width: 1, color: Color(0xff343434)),
            //   borderRadius: BorderRadius.circular(8),
            // ),
            // focusedBorder: OutlineInputBorder(
            //   borderSide: const BorderSide(width: 1, color: Color(0xff0077CD)),
            //   borderRadius: BorderRadius.circular(8),
            // ),
            suffix: hasUnits ? const Text("cm") : null,
            disabledBorder: null,
          ),
          onChanged: (value) {
            double? parsedValue = double.tryParse(value);
            if (parsedValue != null) {
              updateParam1(parsedValue);
            }else{
              updateParam1(0);
            }
          },
          keyboardType: const TextInputType.numberWithOptions(
              signed: false, decimal: false),
        ),
      ),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.boxSeparation / 2),
          child: const Text("y")),
      Container(
        width: 0.16 * Sizes.width,
        height: Sizes.tileNormal,
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xff343434)))),
        child: TextField(
          controller: controllerRight,
          cursorColor: const Color(0xffbc171d),
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: Colors.white,
            border: InputBorder.none,
            hintText: "",
            contentPadding:
                EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
            // enabledBorder: OutlineInputBorder(
            //   borderSide: const BorderSide(width: 1, color: Color(0xff343434)),
            //   borderRadius: BorderRadius.circular(8),
            // ),
            // focusedBorder: OutlineInputBorder(
            //   borderSide: const BorderSide(width: 1, color: Color(0xff0077CD)),
            //   borderRadius: BorderRadius.circular(8),
            // ),
            suffix: hasUnits ? const Text("cm") : null,
            disabledBorder: null,
          ),
          onChanged: (value) {
            double? parsedValue = double.tryParse(value);
            if (parsedValue != null) {
              updateParam2(parsedValue);
            }else{
              updateParam2(0);
            }
          },
          keyboardType: const TextInputType.numberWithOptions(
              signed: false, decimal: false),
        ),
      ),
    ],
  );
}
