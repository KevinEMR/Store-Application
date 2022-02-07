import 'package:tienda_app/constantes.dart';
import 'package:tienda_app/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) => LocalesScreen()));
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color(0xfff8f8f8),
          title: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: kPrimaryColor,
              size: 35,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => LocalesScreen()));
            },
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 27),
          height: double.infinity,
          width: double.infinity,
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sobre Nosotros",
                    style: TextStyle(
                      fontSize: 40,
                      color: kPrimaryColor,
                    ),
                  ),
                  Image(
                    image: AssetImage("assets/images/About/about.png"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 280,
                    width: 360,
                    child: Wrap(
                      children: [
                        Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                          style: TextStyle(fontSize: 22, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
