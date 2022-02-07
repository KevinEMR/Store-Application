import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:tienda_app/constantes.dart';
import 'package:tienda_app/models/locales.dart';
import 'package:tienda_app/models/productos.dart';
import 'package:tienda_app/screens/busquedas/busqueda_locales.dart';
import 'package:tienda_app/screens/busquedas/busqueda_productos.dart';
import 'package:tienda_app/screens/home/home_screen.dart';

class ChatAndAddToCart extends StatelessWidget {
  final Locales locales;
  final List<Productos> productosdb;
  final List<Locales> localesdb;
  final List categories;
  final List categoriesproductos;

  const ChatAndAddToCart(
      {Key key,
      this.locales,
      this.productosdb,
      this.localesdb,
      this.categories,
      this.categoriesproductos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(kDefaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFFCBF1E),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: <Widget>[
          TextButton.icon(
            onPressed: () {
              List listalocales = [];
              for (var i = 0; i < localesdb.length; i++) {
                if (localesdb[i].categoria == locales.categoria) {
                  listalocales.add(localesdb[i]);
                }
              }
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Scaffold(
                          appBar: LocalesScreen().createState().buildAppBar2(),
                          backgroundColor: kPrimaryColor,
                          body: Busquedalocales(
                              localesdb: listalocales,
                              categories: [locales.categoria]))));
            },
            icon: Icon(
              Icons.cabin,
              color: Colors.black,
            ),
            label: Text(
              "Buscar Similares",
              style: TextStyle(color: Colors.black),
            ),
          ),
          // it will cover all available spaces
          Spacer(),
          TextButton.icon(
            onPressed: () {
              List<Productos> listaproductos = [];
              for (var i = 0; i < productosdb.length; i++) {
                if (productosdb[i].local == locales.title) {
                  listaproductos.add(productosdb[i]);
                }
              }
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Scaffold(
                          appBar: LocalesScreen().createState().buildAppBar2(),
                          backgroundColor: kPrimaryColor,
                          body: BusquedaProductos(
                              productosdb: listaproductos,
                              categoriesproductos: categoriesproductos))));
            },
            icon: SvgPicture.asset(
              "assets/icons/shopping-bag.svg",
              height: 18,
              color: Colors.black,
            ),
            label: Text(
              "Buscar Productos",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
