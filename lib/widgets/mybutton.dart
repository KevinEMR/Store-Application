import 'package:flutter/material.dart';
import 'package:tienda_app/constantes.dart';

class MyButton extends StatelessWidget {
  final Function onPressed;
  final String name;
  MyButton({this.name, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.resolveWith((states) => kPrimaryColor),
        ),
        child: Text(
          name,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
