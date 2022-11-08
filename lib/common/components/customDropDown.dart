import 'package:flutter/material.dart';
import 'package:wood_center/common/sizes.dart';

Widget CustomDropDown(
    List<dynamic> myList, int? myValue, Function(int?) updateValue) {
  return Container(
    width: 0.32 * Sizes.width,
    height: Sizes.tileNormal,
    decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xff343434)))),
    child: DropdownButton<int>(
        isExpanded: true,
        value: myValue,
        underline: Container(),
        items: myList
            .map((e) => DropdownMenuItem<int>(
                  value: e.id,
                  child: SizedBox(
                      height: Sizes.tileNormal, child: Text(e.getName())),
                ))
            .toList(),
        onChanged: updateValue),
  );
}
