import 'package:flutter/material.dart';
import 'package:wood_center/common/sizes.dart';
import 'package:wood_center/user/model/role.dart';
import 'package:wood_center/user/model/user.dart';
import 'package:wood_center/common/ui/appbar.dart';
import 'package:wood_center/common/ui/drawer.dart';
import 'package:wood_center/warehouse/model/city.dart';
import 'package:wood_center/common/components/stringTextInput.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppBar("Perfil"),
      drawer: MyDrawer(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
        height: Sizes.height,
        width: Sizes.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Sizes.padding,
            ),
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
                        image: DecorationImage(
                            image: NetworkImage(myUser.photoUrl),
                            fit: BoxFit.cover)),
                  ),
                ),
                Text(myUser.fullName())
              ],
            ),
            SizedBox(
              height: Sizes.boxSeparation,
            ),
            const Text("Nombres"),
            StringTextInput((value) {}, prevalue: myUser.firstName),
            SizedBox(
              height: Sizes.boxSeparation,
            ),
            const Text("Apellidos"),
            StringTextInput((value) {}, prevalue: myUser.lastName),
            SizedBox(
              height: Sizes.boxSeparation,
            ),
            const Text("Email"),
            StringTextInput((value) {}, prevalue: myUser.email),
            SizedBox(
              height: Sizes.boxSeparation,
            ),
            const Text("Ciudad"),
            StringTextInput((value) {}, prevalue: myCity.name),
            SizedBox(
              height: Sizes.boxSeparation,
            ),
            const Text("Cargo"),
            StringTextInput((value) {}, prevalue: myRole.name),
          ],
        ),
      ),
    );
  }
}
