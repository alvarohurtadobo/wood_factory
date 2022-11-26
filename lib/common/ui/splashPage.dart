import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wood_center/common/sizes.dart';
import 'package:wood_center/user/bloc/userBloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      SharedPreferences.getInstance().then((prefs) {
        String jwt = prefs.getString("jwt") ?? "";
        String email = prefs.getString("email") ?? "";
        if (jwt == "" && email == "") {
          Navigator.of(context).pushReplacementNamed("/login");
        } else {
          loginWithEmail(email).then((value) {
            Navigator.of(context).pushReplacementNamed("/home");
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Sizes.initSizes(width, height);
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed("/login");
        },
        child: Center(
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/login");
            },
            child: Hero(
              tag: "logo",
              child: Container(
                width: Sizes.initialLogoSide,
                height: Sizes.initialLogoSide,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/logos/logo.png"),
                        fit: BoxFit.contain)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
