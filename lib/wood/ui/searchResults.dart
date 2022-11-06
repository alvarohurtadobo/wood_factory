import 'package:flutter/material.dart';
import 'package:wood_center/common/sizes.dart';
import 'package:wood_center/common/ui/appbar.dart';
import 'package:wood_center/common/ui/drawer.dart';
import 'package:wood_center/wood/model/pallet.dart';

class SearchResultsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar("Resultados de Búsqueda",
      ),
      drawer: MyDrawer(),
      body: Expanded(child: ListView()),
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
        padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black))),
        child: Row(
          children: [
            SizedBox(
              width: tileWidth * 0.65,
              child: Column(children: [
                Text(myPallet.productId.toString()),
                Text("${myPallet.length}cm x${myPallet.width}cm x${myPallet.height}cm"),
                Text(myPallet.locationId.toString()),
              ],),
            ),
            SizedBox(
              width: Sizes.boxSeparation,
            ),
            SizedBox(
              width: tileWidth * 0.35 - Sizes.boxSeparation,
              child: Column(children: [
                Text(myPallet.amount.toString()),
                Text(myPallet.stateId.toString()),
              ],),
            )
          ],
        ),
      ),
    );
  }
}
