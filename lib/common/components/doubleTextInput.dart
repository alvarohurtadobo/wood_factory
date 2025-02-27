import 'package:flutter/material.dart';
import 'package:wood_center/common/sizes.dart';

Widget DoubleTextInput(Function(double) updateParam,
    {bool hasUnits = false, TextEditingController? controller, bool enabled=true, FocusNode? myFocusNode}) {
  return Container(
    // width: 0.32 * Sizes.width,
    height: Sizes.tileNormal,
    decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xff343434)))),
    child: TextField(
      controller: controller,
      focusNode: myFocusNode,
      textAlign: TextAlign.right,
      cursorColor: const Color(0xffbc171d),
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: Colors.white,
        border: InputBorder.none,
        hintText: "",
        contentPadding: EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
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
      enabled: enabled,
      onChanged: (value) {
        double? parsedValue = double.tryParse(value);
        if (parsedValue != null) {
          updateParam(parsedValue);
        } else {
          updateParam(0);
        }
      },
      keyboardType:
          const TextInputType.numberWithOptions(signed: false, decimal: false),
    ),
  );
}
