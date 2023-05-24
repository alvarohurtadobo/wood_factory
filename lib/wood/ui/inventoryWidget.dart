import 'package:flutter/material.dart';
import 'package:wood_center/common/sizes.dart';
import 'package:wood_center/wood/model/inventory.dart';

Widget inventoryWidget(Inventory currentInventory) {
  return Container(
    height: Sizes.tileNormal*0.8,
    padding: EdgeInsets.symmetric(
        horizontal: Sizes.padding, vertical: Sizes.boxSeparation / 2),
    margin: EdgeInsets.only(bottom: Sizes.boxSeparation),
    decoration: BoxDecoration(
      color: currentInventory.status == "OPEN"
                  ?Colors.grey:Colors.white,
        border: const Border(bottom: BorderSide(color: Colors.grey))),
    child: Row(
      children: [
        Text(currentInventory.id.toString()),
        const Expanded(child: SizedBox()),
        Container(
            alignment: Alignment.centerRight,
            width: Sizes.width / 3,
            child: Text(
              currentInventory.inventoryOpenDate.toString(),
              maxLines: 1,
              textAlign: TextAlign.end,
            )),
        Container(
          alignment: Alignment.centerRight,
          width: Sizes.width / 3,
          child: Text(
              currentInventory.status == "OPEN"
                  ? currentInventory.statusName
                  : currentInventory.inventoryCloseDate.toString(),
              textAlign: TextAlign.end,
              maxLines: 1),
        ),
      ],
    ),
  );
}


Widget titleInventoryWidget() {
  return Container(
    padding: EdgeInsets.symmetric(
        horizontal: Sizes.padding, vertical: Sizes.boxSeparation / 2),
    margin: EdgeInsets.only(bottom: Sizes.boxSeparation),
    decoration: const BoxDecoration(
      color: Colors.white,),
    child: Row(
      children: [
        Text("Id"),
        const Expanded(child: SizedBox()),
        Container(
            alignment: Alignment.centerRight,
            width: Sizes.width / 3,
            child: const Text(
              "Apertura",
              maxLines: 1,
              textAlign: TextAlign.end,
            )),
        Container(
          alignment: Alignment.centerRight,
          width: Sizes.width / 3,
          child: const Text(
              "Cierre",
              textAlign: TextAlign.end,
              maxLines: 1),
        ),
      ],
    ),
  );
}