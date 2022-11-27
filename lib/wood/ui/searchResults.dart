import 'package:flutter/material.dart';
import 'package:wood_center/common/settings.dart';
import 'package:wood_center/common/sizes.dart';
import 'package:wood_center/wood/model/kit.dart';
import 'package:wood_center/common/ui/appbar.dart';
import 'package:wood_center/common/ui/drawer.dart';

class SearchResultsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> myList = [SizedBox(height: Sizes.padding)];
    myKits.removeWhere((element) => element.id == deletedKitId);
    myList.addAll(myKits.map((e) => kitTile(e)));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppBar(
        "Resultados de Búsqueda",
      ),
      drawer: MyDrawer(),
      body: SizedBox(
        height: Sizes.height,
        width: Sizes.width,
        child: myKits.isEmpty
            ? Padding(
                padding: EdgeInsets.all(Sizes.tileNormal),
                child: const Text(
                    "No se encontraron resultados para esta búsqueda"),
              )
            : ListView(children: myList),
      ),
    );
  }

  Widget kitTile(Kit displayKit) {
    double tileWidth = Sizes.width - 2 * Sizes.padding;
    // print("Building tile for kit ${displ}")
    return GestureDetector(
      onTap: () {
        currentKit = displayKit;
        Navigator.of(context).pushNamed("/updateKit").then((value) {
          setState(() {});
        });
      },
      child: SizedBox(
        width: tileWidth,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                // height: Sizes.height/8,
                margin: EdgeInsets.only(
                    left: Sizes.padding, bottom: Sizes.boxSeparation),
                padding: EdgeInsets.symmetric(
                    horizontal: Sizes.boxSeparation,
                    vertical: Sizes.boxSeparation / 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Sizes.radius),
                        bottomLeft: Radius.circular(Sizes.radius)),
                    border: Border.all(color: Color(0xff343434))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Producto: ${displayKit.productCode}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff343434)),
                    ),
                    Text(
                      displayKit.productName,
                      maxLines: 1,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Color(0xff343434)),
                    ),
                    displayKit.productIsWood
                        ? Text(
                            "${displayKit.productLength}cm x${displayKit.productWidth}cm x${displayKit.productHeight}cm",
                            maxLines: 1,
                            style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Color(0xff343434)))
                        : const Text(""),
                    SizedBox(
                      height: Sizes.boxSeparation / 2,
                    ),
                    const Text("Ubicación: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff343434))),
                    Text(
                        "${displayKit.locationName} - ${displayKit.warehouseName}",
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Color(0xff343434))),
                  ],
                ),
              ),
            ),
            Container(
              width: 0.26 * tileWidth,
              // height: Sizes.height/8,
              margin: EdgeInsets.only(
                  right: Sizes.padding, bottom: Sizes.boxSeparation),
              padding: EdgeInsets.symmetric(
                  horizontal: Sizes.boxSeparation,
                  vertical: Sizes.boxSeparation / 2),
              decoration: BoxDecoration(
                  color: const Color(0xffbc171d),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Sizes.radius),
                      bottomRight: Radius.circular(Sizes.radius)),
                  border: Border.all(color: const Color(0xffbc171d))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(displayKit.amount.toString(),
                      maxLines: 1,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  Text(displayKit.woodStatusName.toString(),
                      maxLines: 1,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal, color: Colors.white)),
                  const Text(""),
                  const Text(""),
                  const Icon(
                    Icons.edit,
                    color: Colors.white,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
