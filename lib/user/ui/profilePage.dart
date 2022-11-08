import 'package:flutter/material.dart';
import 'package:wood_center/common/sizes.dart';
import 'package:wood_center/common/ui/appbar.dart';
import 'package:wood_center/common/ui/drawer.dart';
import '../../common/components/stringTextInput.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar("Perfil"),
      drawer: MyDrawer(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
        height: Sizes.height,
        width: Sizes.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(Sizes.boxSeparation),
                  child: Container(
                    height: Sizes.height / 8 - 2 * Sizes.boxSeparation,
                    width: Sizes.height / 8 - 2 * Sizes.boxSeparation,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(Sizes.height / 16)),
                        image: const DecorationImage(
                            image: AssetImage("assets/images/avatar.png"),
                            fit: BoxFit.cover)),
                  ),
                ),
                const Text("Alvaro Hurtado Maldonado")
              ],
            ),
            SizedBox(
              height: Sizes.boxSeparation,
            ),
            const Text("Nombres"),
            StringTextInput((value) {}, prevalue: "Alvaro"),
            SizedBox(
              height: Sizes.boxSeparation,
            ),
            const Text("Apellidos"),
            StringTextInput((value) {}, prevalue: "Hurtado Maldonado"),
            SizedBox(
              height: Sizes.boxSeparation,
            ),
            const Text("Email"),
            StringTextInput((value) {}, prevalue: "a.hurtado.bo@gmail.com"),
            SizedBox(
              height: Sizes.boxSeparation,
            ),
            const Text("Ciudad"),
            StringTextInput((value) {}, prevalue: "Bogotá"),
          ],
        ),
      ),
    );
  }
}
