import 'package:flutter/material.dart';
import 'package:wood_center/common/sizes.dart';
import 'package:wood_center/wood/model/kit.dart';
import 'package:wood_center/common/ui/appbar.dart';
import 'package:wood_center/common/ui/drawer.dart';
import 'package:wood_center/wood/model/inventory.dart';
import 'package:wood_center/wood/ui/inventoryWidget.dart';
import 'package:wood_center/common/ui/genericConfirmationDialog.dart';

class InventoriesPage extends StatefulWidget {
  // InventoriesPage({key, })
  //     : super(key: key);
  @override
  State<StatefulWidget> createState() => _InventoriesPageState();
}

class _InventoriesPageState extends State<InventoriesPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Sizes.initSizes(width, height);
    print("Display kit is ${currentKit.describe()}");
    List<Widget> myDisplayWidget = [titleInventoryWidget()];
    myDisplayWidget.addAll(myInventories.map((e) => inventoryWidget(e)));
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: MyDrawer(),
      appBar: myAppBar("Inventarios Actuales"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: myDisplayWidget,
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        bool confirm = await genericConfirmationDialog(
            context, "¿Está seguro que desea abrir un nuevo inventario?");
        if (confirm) {
          Navigator.of(context).pushNamed("/inventory");
        }
      }, child: const Center(child: Text("+", style: TextStyle(color: Colors.white, fontSize: 24),)),),
    );
  }
}
