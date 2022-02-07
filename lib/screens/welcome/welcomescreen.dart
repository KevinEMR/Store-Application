import 'package:firebase_auth/firebase_auth.dart';
import 'package:tienda_app/screens/home/home_screen.dart';
import 'package:tienda_app/screens/loginAndRegister/login.dart';
import 'package:tienda_app/screens/loginAndRegister/signup.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 600,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 350,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("images/shopping.png"))),
                    ),
                    Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      height: 100,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "¿Listo para comenzar a comprar?",
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "Para empezar",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => Color(0xff746bc9)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        child: Text(
                          "Registrarse",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (ctx) => SignUp(),
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Ya tienes cuenta? ",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (ctx) => StreamBuilder(
                                  stream:
                                      FirebaseAuth.instance.authStateChanges(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return LocalesScreen();
                                    } else {
                                      return Login();
                                    }
                                  },
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff7746bc9),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
