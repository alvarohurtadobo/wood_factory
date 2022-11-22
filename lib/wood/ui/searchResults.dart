import 'package:flutter/material.dart';
import 'package:wood_center/common/sizes.dart';
import 'package:wood_center/common/ui/appbar.dart';
import 'package:wood_center/common/ui/drawer.dart';
import 'package:wood_center/wood/model/pallet.dart';
import 'package:wood_center/wood/model/product.dart';

class SearchResultsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        "Resultados de Búsqueda",
      ),
      drawer: MyDrawer(),
      body: Container(
        padding: EdgeInsets.only(top: Sizes.padding),
        height: Sizes.height,
        width: Sizes.width,
        child: ListView(children: myPallets.map((e) => palletTile(e)).toList()),
      ),
    );
  }

  Widget palletTile(Pallet myPallet) {
    double tileWidth = Sizes.width - 2 * Sizes.padding;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed("/updatePallet");
      },
      child: Container(
        width: tileWidth,
        // height: Sizes.height/8,
        margin: EdgeInsets.only(
            left: Sizes.padding,
            right: Sizes.padding,
            bottom: Sizes.boxSeparation),
        padding: EdgeInsets.symmetric(horizontal: Sizes.boxSeparation, vertical: Sizes.boxSeparation/2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(Sizes.radius)),
            border: Border.all(color: Colors.black)),
        child: Row(
          children: [
            SizedBox(
              width: tileWidth * 0.60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Producto: ${myPallet.productCode}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                      "${currentProduct.length}cm x${currentProduct.width}cm x${currentProduct.height}cm"),
                  Text("Ubicación: ${myPallet.locationName}"),
                ],
              ),
            ),
            SizedBox(
              width: Sizes.boxSeparation,
            ),
            SizedBox(
              width: tileWidth * 0.4 - 4 * Sizes.boxSeparation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(myPallet.amount.toString()),
                  Text(myPallet.statusName.toString()),
                  const Icon(Icons.edit)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
