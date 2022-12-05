import 'package:flutter/material.dart';

AppBar myAppBar(String title) {
  return AppBar(
    title: Row(
      children: [
        Text(title),
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/logos/horizontal.jpeg'))),
        )
      ],
    ),
    backgroundColor: const Color(0xff3D464C),
  );
}
