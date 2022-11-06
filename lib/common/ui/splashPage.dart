import '../sizes.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Sizes.initSizes(width, height);
    return Scaffold(
      body: GestureDetector(
        onTap: (){
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
                          image: AssetImage("assets/logos/logo.jpeg"),
                          fit: BoxFit.contain)),
                ),
            ),
          ),
        ),
      ),
    );
  }
}
