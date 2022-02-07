import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tienda_app/screens/home/home_screen.dart';
import 'package:tienda_app/screens/loginAndRegister/login.dart';
import 'package:tienda_app/widgets/changescreen.dart';
import 'package:tienda_app/widgets/mybutton.dart';
import 'package:tienda_app/widgets/mytextformField.dart';
import 'package:tienda_app/widgets/passwordtextformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

RegExp regExp = new RegExp(p);
bool obserText = true;
final TextEditingController email = TextEditingController();
final TextEditingController userName = TextEditingController();
final TextEditingController phoneNumber = TextEditingController();
final TextEditingController password = TextEditingController();
final TextEditingController address = TextEditingController();

bool isMale = true;
bool isLoading = false;

class _SignUpState extends State<SignUp> {
  void submit() async {
    UserCredential result;
    try {
      setState(() {
        isLoading = true;
      });
      result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
      print("este es el resultado");
      print(result);
    } on PlatformException catch (error) {
      var message = "Revisa tu conexión de internet ";
      if (error.message != null) {
        message = error.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message.toString()),
        duration: Duration(milliseconds: 600),
        backgroundColor: Theme.of(context).primaryColor,
      ));
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.toString()),
        duration: Duration(milliseconds: 600),
        backgroundColor: Theme.of(context).primaryColor,
      ));

      print(error);
    }
    FirebaseFirestore.instance.collection("User").doc(result.user.uid).set({
      "UserName": userName.text,
      "UserId": result.user.uid,
      "UserEmail": email.text,
      "UserAddress": address.text,
      "UserAuthorithy": isMale == true ? "Male" : "Female",
      "UserNumber": phoneNumber.text,
      "UserImage": "assets/images/Home/userImage.png",
    });
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => LocalesScreen()));
    setState(() {
      isLoading = false;
    });
  }

  void vaildation() async {
    if (userName.text.isEmpty &&
        email.text.isEmpty &&
        password.text.isEmpty &&
        phoneNumber.text.isEmpty &&
        address.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Todos los campos estan vacíos"),
        ),
      );
    } else if (userName.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("El nombre debe tener más de 5 caracteres"),
        ),
      );
    } else if (email.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("El email esta vacío"),
        ),
      );
    } else if (!regExp.hasMatch(email.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("EL email no es válido"),
        ),
      );
    } else if (password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("La contraseña esta vacía"),
        ),
      );
    } else if (password.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("La contraseña es demasiada corta"),
        ),
      );
    } else if (phoneNumber.text.length < 10 || phoneNumber.text.length > 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("El número de teléfono debe ser de 10 números"),
        ),
      );
    } else if (address.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("La dirección esta vacía"),
        ),
      );
    } else {
      submit();
    }
  }

  Widget _buildAllTextFormField() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          MyTextFormField(
            name: "Usuario",
            controller: userName,
          ),
          SizedBox(
            height: 10,
          ),
          MyTextFormField(
            name: "Email",
            controller: email,
          ),
          SizedBox(
            height: 10,
          ),
          PasswordTextFormField(
            obserText: obserText,
            controller: password,
            name: "Contraseña",
            onTap: () {
              FocusScope.of(context).unfocus();
              setState(() {
                obserText = !obserText;
              });
            },
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isMale = !isMale;
              });
            },
            child: Container(
              height: 60,
              padding: EdgeInsets.only(left: 10),
              width: double.infinity,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Center(
                child: Row(
                  children: [
                    Text(
                      isMale == true ? "Male" : "Female",
                      style: TextStyle(color: Colors.black87, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          MyTextFormField(
            name: "Número de Teléfono",
            controller: phoneNumber,
          ),
          SizedBox(
            height: 10,
          ),
          MyTextFormField(
            name: "Dirección",
            controller: address,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomPart() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildAllTextFormField(),
          SizedBox(
            height: 10,
          ),
          isLoading == false
              ? MyButton(
                  name: "Registrarse",
                  onPressed: () {
                    vaildation();
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
          ChangeScreen(
            name: "Login",
            whichAccount: "Ya tengo una cuenta",
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => Login(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ListView(
        children: [
          Container(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Registrarse",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 500,
            child: _buildBottomPart(),
          ),
        ],
      ),
    );
  }
}
