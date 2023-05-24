import 'package:flutter/material.dart';
import 'package:wood_center/common/sizes.dart';
import 'package:wood_center/wood/model/kit.dart';
import 'package:wood_center/common/ui/appbar.dart';
import 'package:wood_center/common/ui/drawer.dart';
import 'package:wood_center/wood/model/transformation.dart';
import 'package:wood_center/wood/ui/genericListViewWidget.dart';
import 'package:wood_center/common/ui/genericConfirmationDialog.dart';

class ProcessesPage extends StatefulWidget {
  // ProcessesPage({key, })
  //     : super(key: key);
  @override
  State<StatefulWidget> createState() => _ProcessesPageState();
}

class _ProcessesPageState extends State<ProcessesPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Sizes.initSizes(width, height);
    print("Display kit is ${currentKit.describe()}");
    List<Widget> myDisplayWidget = [titleTile("Id","Tipo de proceso", "Fecha de inicio")];
    myDisplayWidget.addAll(myTransforms.map((e) => listTile(e.id.toString(), e.processName,e.createdAt.toIso8601String().substring(0,16))));
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
          Navigator.of(context).pushNamed("/process");
        }
      }, child: const Center(child: Text("+", style: TextStyle(color: Colors.white, fontSize: 24),)),),
    );
  }
}
