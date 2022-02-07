import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:tienda_app/constantes.dart';
import 'package:tienda_app/models/productos.dart';
import 'package:tienda_app/screens/busquedas/busqueda_productos.dart';
import 'package:tienda_app/screens/home/home_screen.dart';
import 'package:tienda_app/screens/carro/checkout.dart';

class ChatAndProducto extends StatelessWidget {
  final List<Productos> productosdb;
  final Productos productos;

  final String image;
  final String name;
  final double price;
  final int quentity;
  ChatAndProducto(
      {this.image,
      this.name,
      this.price,
      this.productosdb,
      this.productos,
      this.quentity});

  Future<void> myDialogBox(context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Producto añadido"),
            actions: [
              TextButton(
                child: Text("Seguir comprando"),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => LocalesScreen(),
                    ),
                  );
                },
              ),
              TextButton(
                child: Text("Ir al Carro"),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => CheckOut(),
                    ),
                  );
                },
              ),
            ],
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text("Tu productos ha sido añadido al Carro de compras."),
                ],
              ),
            ),
          );
        });
  }

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
              List<Productos> listaproductos = [];
              for (var i = 0; i < productosdb.length; i++) {
                if (productosdb[i].categoria == productos.categoria) {
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
                              categoriesproductos: [productos.categoria]))));
            },
            icon: SvgPicture.asset(
              "assets/icons/shopping-bag.svg",
              height: 18,
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
              productProvider.getCheckOutData(
                image: image,
                name: name,
                price: price,
                quentity: quentity,
              );
              productProvider.addProducto("Producto");
              myDialogBox(context);
            },
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: Colors.black,
            ),
            label: Text(
              "Añadir al carro",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
