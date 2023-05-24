import 'package:flutter/material.dart';
import 'package:wood_center/common/sizes.dart';

Widget listTile(String field1, String field2, String field3,
    {bool highlight = false}) {
  return Container(
    height: Sizes.tileNormal * 0.8,
    padding: EdgeInsets.symmetric(
        horizontal: Sizes.padding, vertical: Sizes.boxSeparation / 2),
    margin: EdgeInsets.only(bottom: Sizes.boxSeparation),
    decoration: BoxDecoration(
        color: highlight ? Colors.grey : Colors.white,
        border: const Border(bottom: BorderSide(color: Colors.grey))),
    child: Row(
      children: [
        Text(
          field1,
          style: const TextStyle(fontWeight: FontWeight.normal),
        ),
        const Expanded(child: SizedBox()),
        Container(
            alignment: Alignment.centerRight,
            width: Sizes.width / 3,
            child: Text(field2,
                maxLines: 1,
                textAlign: TextAlign.end,
                style: const TextStyle(fontWeight: FontWeight.normal))),
        Container(
          alignment: Alignment.centerRight,
          width: Sizes.width / 2.8,
          child: Text(field3,
              textAlign: TextAlign.end,
              maxLines: 1,
              style: const TextStyle(fontWeight: FontWeight.normal)),
        ),
      ],
    ),
  );
}

Widget titleTile(String field1, String field2, String field3) {
  return Container(
    padding: EdgeInsets.symmetric(
        horizontal: Sizes.padding, vertical: Sizes.boxSeparation / 2),
    margin: EdgeInsets.only(bottom: Sizes.boxSeparation),
    decoration: const BoxDecoration(
      color: Colors.white,
    ),
    child: Row(
      children: [
        Text(field1, style: const TextStyle(fontWeight: FontWeight.bold)),
        const Expanded(child: SizedBox()),
        Container(
            alignment: Alignment.centerRight,
            width: Sizes.width / 3,
            child: Text(field2,
                maxLines: 1,
                textAlign: TextAlign.end,
                style: const TextStyle(fontWeight: FontWeight.bold))),
        Container(
          alignment: Alignment.centerRight,
          width: Sizes.width / 2.8,
          child: Text(field3,
              textAlign: TextAlign.end,
              maxLines: 1,
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    ),
  );
}
