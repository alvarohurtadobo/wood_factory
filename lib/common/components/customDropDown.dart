import 'package:flutter/material.dart';
import 'package:wood_center/common/sizes.dart';
import 'package:wood_center/wood/model/product.dart';

Widget CustomDropDown(
    List<dynamic> myList, int? myValue, Function(int?) updateValue,
    {bool isExpanded = false, bool enabled = true, bool error = false}) {
  List<int> myValues = myList.map<int>((e) => e.id).toList();
  print("Dropdown initial $myValue in $myValues");
  return Container(
    width: isExpanded ? 0.75 * Sizes.width : 0.32 * Sizes.width,
    height: Sizes.tileNormal * 0.6,
    decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
                color: error
                    ? const Color(0xffbc171d)
                    : const Color(0xff343434)))),
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
                        height: Sizes.tileNormal * 0.6,
                        child: Text(
                          e.getName(),
                          maxLines: 1,
                        )),
                  ),
                ))
            .toList(),
        onChanged: enabled ? updateValue : null),
  );
}

Widget CustomDropDownProduct(
    List<Product> myList, int? myValue, Function(int?) updateValue,
    {bool isExpanded = false, bool enabled = true, bool error = false}) {
  List<int> myValues = myList.map<int>((e) => e.id).toList();
  print("Dropdown initial $myValue in $myValues");
  return Container(
    width: isExpanded ? 0.75 * Sizes.width : 0.32 * Sizes.width,
    height: Sizes.tileNormal * 0.6,
    decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
                color: error
                    ? const Color(0xffbc171d)
                    : const Color(0xff343434)))),
    child: DropdownButton<int>(
        alignment: Alignment.bottomLeft,
        value: myValue,
        isExpanded: true,
        underline: Container(),
        selectedItemBuilder: (context) => myList
            .map(
              (Product e) => Text(
                e.code,
                maxLines: 1,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            )
            .toList(),

        // iconEnabledColor: const Color(0xffbc171d),
        items: myList
            .map((Product e) => DropdownMenuItem<int>(
                  alignment: Alignment.bottomLeft,
                  value: e.id,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: const BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.black))),
                    height: Sizes.tileNormal * 0.86,
                    // width: 2*Sizes.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e.code,
                          maxLines: 1,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          e.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ))
            .toList(),
        onChanged: enabled ? updateValue : null),
  );
}
