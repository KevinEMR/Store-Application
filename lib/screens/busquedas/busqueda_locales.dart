import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tienda_app/constantes.dart';
import 'package:tienda_app/models/productos.dart';
import 'package:tienda_app/screens/details/details_screen_locales.dart';

import 'package:tienda_app/screens/home/components/locales_card_horizontal.dart';

class Busquedalocales extends StatefulWidget {
  final List localesdb;
  final List categories;
  final List productosdb;
  final List categoriesproductos;

  const Busquedalocales({
    Key key,
    this.localesdb,
    this.categories,
    this.productosdb,
    this.categoriesproductos,
  }) : super(key: key);

  @override
  _BusquedalocalesState createState() => _BusquedalocalesState(
      localesdb, categories, categoriesproductos, productosdb);
}

class _BusquedalocalesState extends State<Busquedalocales> {
  _BusquedalocalesState(List localesdb, List categorias, List productodb,
      List categoriesproductos) {
    this.categories = categorias;
    this.localesdb = localesdb;
    this.categoriesproductos = categoriesproductos;
    this.productosdb = productosdb;
  }

  List localesdb;
  List categories;
  List<Productos> productosdb;
  List categoriesproductos;
  List locallista = [];
  int selectedIndex = 0;
  String localoproduct;

  Container localesProductos() {
    setState(() {
      localoproduct = "Locales";
    });
    return Container(
      margin: EdgeInsets.symmetric(vertical: (kDefaultPadding / 2)),
      height: 25,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
              if (selectedIndex != 0) {
                var lista = [];
                for (var i = 0; i < localesdb.length; i++) {
                  if (localesdb[i].categoria == categories[selectedIndex]) {
                    lista.add(i);
                  }
                }
                if (lista.isEmpty) {
                  locallista = null;
                } else {
                  locallista = lista;
                }
              } else {
                locallista = [];
              }
            });
          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              left: kDefaultPadding,
              // At end item it add extra 20 right  padding
              right: index == categories.length - 1 ? kDefaultPadding : 0,
            ),
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            decoration: BoxDecoration(
              color: index == selectedIndex
                  ? Colors.white.withOpacity(0.4)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              categories[index],
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Container boxlocales(List imagenes, String categoria) {
    if (imagenes != null) {
      if (localesdb.isNotEmpty) {
        return localesmostrar(imagenes);
      } else {
        return sinresultados();
      }
    } else {
      return sinresultados();
    }
  }

  Container sinresultados() {
    return Container(
        child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: kDefaultPadding * 2,
                horizontal: kDefaultPadding * 7.2),
            child: Text(
              "No hay resultados",
            )));
  }

  Container localesmostrar(List imagenes) {
    return Container(
        child: (imagenes.isEmpty)
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: localesdb.length,
                itemBuilder: (context, index) => LocalesCardHorizontal(
                    itemIndex: index,
                    locales: localesdb[index],
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                  locales: localesdb[index],
                                  productosdb: productosdb,
                                  categories: categories,
                                  categoriesproductos: categoriesproductos,
                                  localesdb: localesdb)));
                    }))
            : ListView.builder(
                shrinkWrap: true,
                itemCount: imagenes.length,
                itemBuilder: (context, index) => LocalesCardHorizontal(
                    itemIndex: index,
                    locales: localesdb[imagenes[index]],
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                  locales: localesdb[imagenes[index]],
                                  productosdb: productosdb,
                                  categories: categories,
                                  categoriesproductos: categoriesproductos,
                                  localesdb: localesdb)));
                    })));
  }

  Widget _categorias() {
    return localesProductos();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          _categorias(),
          SizedBox(height: (kDefaultPadding / 2)),
          Expanded(
            child: Stack(
              children: <Widget>[
                // Our background
                Container(
                  margin: EdgeInsets.only(top: 70),
                  decoration: BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                ),
                boxlocales(locallista, localoproduct)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
