import 'package:flutter/material.dart';
import 'package:wood_center/common/sizes.dart';

Widget CustomDropDown(
    List<dynamic> myList, int? myValue, Function(int?) updateValue,
    {bool isExpanded = false}) {
  List<int> myValues = myList.map<int>((e) => e.id).toList();
  print("Dropdown initial $myValue in $myValues");
  return Container(
    width: isExpanded ? 0.75 * Sizes.width : 0.32 * Sizes.width,
    height: Sizes.tileNormal*0.6,
    decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xff343434)))),
    child: DropdownButton<int>(
        alignment: Alignment.bottomLeft,
        isExpanded: true,
        value: myValue,
        underline: Container(),
        // iconEnabledColor: const Color(0xffbc171d),
        items: myList
            .map((e) => DropdownMenuItem<int>(
                  alignment: Alignment.bottomLeft,
                  value: e.id,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                        height: Sizes.tileNormal*0.6,
                        child: Text(
                          e.getName(),
                          maxLines: 2,
                        )),
                  ),
                ))
            .toList(),
        onChanged: updateValue),
  );
}
