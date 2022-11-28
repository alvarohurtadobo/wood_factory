// ignore_for_file: use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:wood_center/common/sizes.dart';
import 'package:wood_center/user/model/role.dart';
import 'package:wood_center/user/model/user.dart';
import 'package:wood_center/common/repository/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wood_center/common/ui/genericConfirmationDialog.dart';

class MyDrawer extends StatelessWidget {
  // const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("URL ${serverUrl + myUser.photoUrl}");
    return Drawer(
      backgroundColor: const Color(0xffbc171d),
      child: SafeArea(
        child: Container(
          color: Colors.white,
          height: Sizes.height - Sizes.height / 5.2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.of(context).pushNamed("/profile");
                },
                child: Container(
                  height: Sizes.height / 5.2,
                  padding: EdgeInsets.all(Sizes.padding * 0.6),
                  decoration: const BoxDecoration(
                    color: Color(0xffbc171d),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: Sizes.width / 5.4,
                        width: Sizes.width / 5.4,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(Sizes.width / 10.8)),
                            image: DecorationImage(
                                image:
                                    NetworkImage(serverUrl + myUser.photoUrl),
                                fit: BoxFit.cover)),
                      ),
                      SizedBox(width: Sizes.boxSeparation),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "¡Hola!",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Sizes.font06,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              width: Sizes.width * 0.5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    myUser.fullName(),
                                    maxLines: 3,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: Sizes.font08,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    myRole.name,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: Sizes.font08,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            )
                          ])
                    ],
                  ),
                ),
              ),
              drawerTile(context, Icons.home, "Inicio", "Ventana principal",
                  route: "/home"),
              drawerTile(context, Icons.person, "Mi Perfil",
                  "Actualiza tu información",
                  route: "/profile"),
              drawerTile(
                  context, Icons.search, "Búsqueda", "Búsqueda de inventario",
                  route: "/search"),
              drawerTile(context, Icons.map, "Mapas", "Mapas guia de tu zona",
                  route: "/maps"),
              logoutTile(context),
              Padding(
                padding: EdgeInsets.only(
                    left: Sizes.padding, top: Sizes.boxSeparation),
                child: Text("Versión 0.9.0",
                    style: TextStyle(
                        color: const Color(0xff4F5051),
                        fontSize: Sizes.font10,
                        fontWeight: FontWeight.normal)),
              ),
              Expanded(
                child: Container(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget drawerTile(
      BuildContext context, IconData myIcon, String title, String subtitle,
      {String route = "/"}) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        // Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushNamed(route);
      },
      child: Container(
          padding: EdgeInsets.symmetric(
              vertical: Sizes.boxSeparation, horizontal: Sizes.padding),
          // margin: EdgeInsets.symmetric(horizontal: Sizes.padding),
          decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Color(0xffB1B2B3)))),
          child: Row(
            children: [
              Icon(myIcon, color: const Color(0xff3D464C)),
              SizedBox(
                width: Sizes.padding,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          color: const Color(0xff4F5051),
                          fontSize: Sizes.font08,
                          fontWeight: FontWeight.bold)),
                  subtitle == ""
                      ? Container()
                      : Text(subtitle,
                          style: TextStyle(
                              color: const Color(0xff4F5051),
                              fontSize: Sizes.font10,
                              fontWeight: FontWeight.normal))
                ],
              ),
            ],
          )),
    );
  }

  Widget logoutTile(BuildContext context) {
    return GestureDetector(
      onTap: () {
        genericConfirmationDialog(context, "Está seguro de cerrar sesión")
            .then((confirm) {
          if (confirm) {
            SharedPreferences.getInstance().then((prefs) {
              prefs.remove("jwt");
              prefs.clear();
              Navigator.of(context).pop();
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context).pop(); // Para el drawer???
              Navigator.of(context).pushNamed("/login");
            });
          }
        });
      },
      child: Container(
          padding: EdgeInsets.symmetric(
              vertical: Sizes.boxSeparation, horizontal: Sizes.padding),
          // margin: EdgeInsets.symmetric(horizontal: Sizes.padding),
          decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Color(0xffB1B2B3)))),
          child: Row(
            children: [
              const Icon(
                Icons.exit_to_app,
                color: Color(0xff3D464C),
              ),
              SizedBox(
                width: Sizes.padding,
              ),
              Text("Cerrar sesión",
                  style: TextStyle(
                      color: const Color(0xff4F5051),
                      fontSize: Sizes.font08,
                      fontWeight: FontWeight.bold)),
            ],
          )),
    );
  }
}
