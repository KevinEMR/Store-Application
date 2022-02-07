import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tienda_app/constantes.dart';
import 'package:tienda_app/models/locales.dart';
import 'package:tienda_app/models/productos.dart';
import 'package:tienda_app/screens/details/details_screen_locales.dart';
import 'package:tienda_app/screens/details/details_screen_product.dart';
import 'package:tienda_app/screens/home/components/productos_card_vertical.dart';

import 'package:tienda_app/screens/home/components/locales_card_vertical.dart';

class Busqueda extends StatefulWidget {
  final List<Locales> localesdb;
  final List<Productos> productosdb;
  final List categories;
  final List categoriesproductos;

  const Busqueda(
      {Key key,
      this.localesdb,
      this.productosdb,
      this.categories,
      this.categoriesproductos})
      : super(key: key);

  @override
  _BusquedaState createState() =>
      _BusquedaState(localesdb, productosdb, categories, categoriesproductos);
}

class _BusquedaState extends State<Busqueda> {
  _BusquedaState(List<Locales> localesdb, List<Productos> productosdb,
      List categorias, List categoriasproductos) {
    this.categoriesproductos = categoriasproductos;
    this.categories = categorias;
    this.productosdb = productosdb;
    this.localesdb = localesdb;
  }

  List<Locales> localesdb;
  List<Productos> productosdb;
  List categories;
  List categoriesproductos;
  List proandloc = ["Negocios", "Productos"];
  List locallista = [];
  int selectedIndex = 0;
  int selectedIndex2 = 0;
  String localoproduct;

  Container localesProductos() {
    if (selectedIndex2 == 0) {
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
    } else {
      setState(() {
        localoproduct = "Productos";
      });
      return Container(
        margin: EdgeInsets.symmetric(vertical: (kDefaultPadding / 2)),
        height: 25,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: categoriesproductos.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
                if (selectedIndex != 0) {
                  var lista = [];
                  for (var i = 0; i < productosdb.length; i++) {
                    if (productosdb[i].categoria ==
                        categoriesproductos[selectedIndex]) {
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
                right: index == categoriesproductos.length - 1
                    ? kDefaultPadding
                    : 0,
              ),
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              decoration: BoxDecoration(
                color: index == selectedIndex
                    ? Colors.white.withOpacity(0.4)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                categoriesproductos[index],
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      );
    }
  }

  Container boxlocales(List imagenes, String categoria) {
    if (imagenes != null) {
      if (categoria == "Locales") {
        if (localesdb.isNotEmpty) {
          return localesmostrar(imagenes);
        } else {
          return sinresultados();
        }
      } else {
        if (productosdb.isNotEmpty) {
          return productosmostrar(imagenes);
        } else {
          return sinresultados();
        }
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
                itemBuilder: (context, index) => LocalesCard(
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
                itemBuilder: (context, index) => LocalesCard(
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

  Container productosmostrar(List imagenes) {
    return Container(
        child: (imagenes.isEmpty)
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: productosdb.length,
                itemBuilder: (context, index) => ProductosCard(
                    itemIndex: index,
                    productos: productosdb[index],
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsScreenProductos(
                                  productos: productosdb[index],
                                  productosdb: productosdb)));
                    }))
            : ListView.builder(
                shrinkWrap: true,
                itemCount: imagenes.length,
                itemBuilder: (context, index) => ProductosCard(
                    itemIndex: index,
                    productos: productosdb[imagenes[index]],
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsScreenProductos(
                                  productos: productosdb[imagenes[index]],
                                  productosdb: productosdb)));
                    })));
  }

  Widget _categorias() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: (kDefaultPadding / 2)),
          height: 25,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: proandloc.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex2 = index;
                });
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                  left: kDefaultPadding,
                  // At end item it add extra 20 right  padding
                  right: index == proandloc.length - 1 ? kDefaultPadding : 0,
                ),
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                decoration: BoxDecoration(
                  color: index == selectedIndex2
                      ? Colors.white.withOpacity(0.4)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  proandloc[index],
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        Image.asset(
          "assets/images/Home/linea.png",
          width: double.maxFinite,
          fit: BoxFit.fitWidth,
        ),
        localesProductos(),
      ],
    );
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
