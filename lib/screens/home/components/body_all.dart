import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tienda_app/components/search_box.dart';
import 'package:tienda_app/constantes.dart';
import 'package:tienda_app/models/locales.dart';
import 'package:tienda_app/models/productos.dart';
import 'package:tienda_app/screens/details/details_screen_locales.dart';
import 'package:tienda_app/screens/details/details_screen_product.dart';
import 'package:tienda_app/screens/busquedas/busqueda.dart';
import 'package:tienda_app/screens/home/components/productos_card_vertical.dart';
import 'package:tienda_app/screens/home/home_screen.dart';

import 'locales_card_vertical.dart';

class BodyAll extends StatefulWidget {
  final List<Locales> localesdb;
  final List<Productos> productosdb;
  final List categories;
  final List categoriesproductos;

  const BodyAll(
      {Key key,
      this.localesdb,
      this.productosdb,
      this.categories,
      this.categoriesproductos})
      : super(key: key);

  @override
  _BodyAllState createState() => _BodyAllState();
}

class _BodyAllState extends State<BodyAll> {
  List proandloc = ["Negocios", "Productos"];
  List locallista = [];
  int selectedIndex = 0;
  int selectedIndex2 = 0;
  String localoproduct;
  TextEditingController textcontroller;

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
          itemCount: widget.categories.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
                if (selectedIndex != 0) {
                  var lista = [];
                  for (var i = 0; i < widget.localesdb.length; i++) {
                    if (widget.localesdb[i].categoria ==
                        widget.categories[selectedIndex]) {
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
                right:
                    index == widget.categories.length - 1 ? kDefaultPadding : 0,
              ),
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              decoration: BoxDecoration(
                color: index == selectedIndex
                    ? Colors.white.withOpacity(0.4)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                widget.categories[index],
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
          itemCount: widget.categoriesproductos.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
                if (selectedIndex != 0) {
                  var lista = [];
                  for (var i = 0; i < widget.productosdb.length; i++) {
                    if (widget.productosdb[i].categoria ==
                        widget.categoriesproductos[selectedIndex]) {
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
                right: index == widget.categoriesproductos.length - 1
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
                widget.categoriesproductos[index],
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
        if (widget.localesdb.isNotEmpty) {
          return localesmostrar(imagenes);
        } else {
          return sinresultados();
        }
      } else {
        if (widget.productosdb.isNotEmpty) {
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
                itemCount: widget.localesdb.length,
                itemBuilder: (context, index) => LocalesCard(
                    itemIndex: index,
                    locales: widget.localesdb[index],
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                  locales: widget.localesdb[index],
                                  productosdb: widget.productosdb,
                                  categories: widget.categories,
                                  categoriesproductos:
                                      widget.categoriesproductos,
                                  localesdb: widget.localesdb)));
                    }))
            : ListView.builder(
                shrinkWrap: true,
                itemCount: imagenes.length,
                itemBuilder: (context, index) => LocalesCard(
                    itemIndex: index,
                    locales: widget.localesdb[imagenes[index]],
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                  locales: widget.localesdb[imagenes[index]],
                                  productosdb: widget.productosdb,
                                  categories: widget.categories,
                                  categoriesproductos:
                                      widget.categoriesproductos,
                                  localesdb: widget.localesdb)));
                    })));
  }

  Container productosmostrar(List imagenes) {
    return Container(
        child: (imagenes.isEmpty)
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: widget.productosdb.length,
                itemBuilder: (context, index) => ProductosCard(
                    itemIndex: index,
                    productos: widget.productosdb[index],
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsScreenProductos(
                                  productos: widget.productosdb[index],
                                  productosdb: widget.productosdb)));
                    }))
            : ListView.builder(
                shrinkWrap: true,
                itemCount: imagenes.length,
                itemBuilder: (context, index) => ProductosCard(
                    itemIndex: index,
                    productos: widget.productosdb[imagenes[index]],
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsScreenProductos(
                                  productos:
                                      widget.productosdb[imagenes[index]],
                                  productosdb: widget.productosdb)));
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

  Widget _searchBox() {
    return SearchBox(
      onSubmitted: (value) {
        List<Locales> lista = [];
        List<Productos> listaproductos = [];
        for (var i = 0; i < widget.localesdb.length; i++) {
          if (widget.localesdb[i].title
              .toUpperCase()
              .contains(value.toUpperCase())) {
            lista.add(widget.localesdb[i]);
          }
        }
        for (var i = 0; i < widget.productosdb.length; i++) {
          if (widget.productosdb[i].name
              .toUpperCase()
              .contains(value.toUpperCase())) {
            listaproductos.add(widget.productosdb[i]);
          }
        }
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Scaffold(
                    appBar: LocalesScreen().createState().buildAppBar2(),
                    backgroundColor: kPrimaryColor,
                    body: Busqueda(
                        localesdb: lista,
                        productosdb: listaproductos,
                        categories: widget.categories,
                        categoriesproductos: widget.categoriesproductos))));
        setState(() {
          textcontroller = TextEditingController();
        });
      },
      text: textcontroller,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          _searchBox(),
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
