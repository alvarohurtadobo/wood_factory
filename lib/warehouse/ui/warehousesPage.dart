import 'package:flutter/material.dart';
import 'package:wood_center/common/sizes.dart';
import 'package:wood_center/common/ui/appbar.dart';
import 'package:wood_center/common/ui/drawer.dart';
import 'package:wood_center/warehouse/model/warehouse.dart';
import 'package:wood_center/common/components/rowPiece.dart';
import 'package:wood_center/common/components/customDropDown.dart';

class WarehousesMapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WarehousesMapPageState();
}

class _WarehousesMapPageState extends State<WarehousesMapPage> {
  int? currentWarehouseId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar("Mapa  de sucursales"),
      drawer: MyDrawer(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
        height: Sizes.height,
        width: Sizes.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: Sizes.padding,
            ),
            const Text("Localizaciones para mi ciudad asignada:"),
            SizedBox(
              height: Sizes.boxSeparation,
            ),
            rowPiece(
                const Text("Seleccionar"),
                CustomDropDown(myWarehouses, currentWarehouseId, (value) {
                  setState(() {
                    currentWarehouseId = value;
                  });
                })),
            SizedBox(
              height: Sizes.boxSeparation,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
              width: Sizes.width - 2 * Sizes.padding,
              height: Sizes.width - 2 * Sizes.padding,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBMwovx42WG251q_cvLdk2yKUglHUoRSEywQ&usqp=CAU"))),
            )
          ],
        ),
      ),
    );
  }
}
