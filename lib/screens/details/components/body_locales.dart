import 'package:flutter/material.dart';
import 'package:tienda_app/constantes.dart';
import 'package:tienda_app/models/locales.dart';
import 'package:tienda_app/models/productos.dart';
import 'package:tienda_app/screens/googleMaps/googleMaps.dart';

import 'chat_and_productos.dart';
import 'product_image.dart';

class Body extends StatelessWidget {
  final Locales locales;
  final List<Productos> productosdb;
  final List<Locales> localesdb;
  final List categories;
  final List categoriesproductos;

  const Body({
    Key key,
    this.locales,
    this.productosdb,
    this.categories,
    this.categoriesproductos,
    this.localesdb,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // it provide us total height and width
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small devices
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              decoration: BoxDecoration(
                color: kBackgroundColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Hero(
                      tag: '${locales.id}',
                      child: ProductPoster(
                        size: size,
                        image: locales.image,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: kDefaultPadding / 2),
                    child: Text(
                      locales.title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Text(
                    '${locales.telefono}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: kSecondaryColor,
                    ),
                  ),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                      child: Text(
                        "${locales.address}",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      )),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                    child: Text(
                      "\n${locales.description}",
                      style: TextStyle(color: kTextLightColor),
                    ),
                  ),
                  SizedBox(height: kDefaultPadding),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Googlemap(
                                          address: locales.address,
                                          name: locales.title,
                                        )));
                          },
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
                                      (states) => kSecondaryColor)),
                          child: Text("Mirar en el mapa"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ChatAndAddToCart(
              locales: locales,
              productosdb: productosdb,
              categories: categories,
              categoriesproductos: categoriesproductos,
              localesdb: localesdb,
            )
          ],
        ),
      ),
    );
  }
}
