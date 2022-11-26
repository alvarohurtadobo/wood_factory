import 'package:flutter/material.dart';
import 'package:wood_center/common/sizes.dart';
import 'package:wood_center/common/settings.dart';
import 'package:wood_center/user/model/user.dart';
import 'package:wood_center/user/model/role.dart';
import 'package:wood_center/common/model/regEx.dart';
import 'package:wood_center/user/bloc/userBloc.dart';
import 'package:wood_center/warehouse/model/city.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wood_center/common/ui/genericMessageDialog.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  String email = "";
  String password = "";
  bool canContinue = false;
  bool loading = false;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Sizes.initSizes(width, height);
    loading  = false; // TODO REmove

    return Scaffold(
      backgroundColor: Colors.white,
        body: Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5 * Sizes.boxSeparation,
            ),
            Hero(
              tag: "logo",
              child: Container(
                width: Sizes.width,
                height: Sizes.initialLogoSide / 2,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/logos/logo.png"),
                        fit: BoxFit.contain)),
              ),
            ),
            Expanded(
                child: SizedBox(
              height: 3 * Sizes.boxSeparation,
            )),
            const Text("Correo Electrónico"),
            TextFormField(
              validator: (value) {
                if (!isGoodEmail(value ?? "")) {
                  return "Introduzca un email válido";
                }
                return null;
              },
              onChanged: (value) {
                email = value;
                setState(() {
                  canContinue = isGoodEmail(email) && password != "";
                });
              },
            ),
            SizedBox(
              height: Sizes.boxSeparation,
            ),
            const Text("Contraseña"),
            TextFormField(
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Este campo es obligatorio";
                  }
                  return null;
                },
                onChanged: (value) {
                  password = value;
                  setState(() {
                    canContinue = isGoodEmail(email) && password != "";
                  });
                }),
            SizedBox(
              height: Sizes.boxSeparation,
            ),
            loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xff343434),
                      borderRadius: BorderRadius.circular(Sizes.radius),
                    ),
                    child: TextButton(
                        onPressed: () async {
                          if (loading) {
                            return;
                          }
                          setState(() {
                            loading = true;
                          });
                          print("Login view with $email, $password");
                          if (_formKey.currentState!.validate()) {
                            bool success = await login(email, password);
                            if (success) {
                              SharedPreferences.getInstance().then((prefs) {
                                prefs.setString("jwt", token);
                                prefs.setString("email", email);
                              });
                              print(
                                  "Login successful, user is $myUser, role: $myRole, city: $myCity");
                              Navigator.of(context)
                                  .pushReplacementNamed("/home");
                            } else {
                              await genericMessageDialog(
                                  context, "Verifique sus credenciales");
                            }
                          }
                          setState(() {
                            loading = false;
                          });
                        },
                        child: Text(
                          "Ingresar",
                          style: TextStyle(
                              color: canContinue ? Colors.white : Colors.grey),
                        ))),
            SizedBox(
              height: 5 * Sizes.boxSeparation,
            ),
          ],
        ),
      ),
    ));
  }
}
