import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tienda_app/components/search_box.dart';
import 'package:tienda_app/constantes.dart';
import 'package:tienda_app/models/locales.dart';
import 'package:tienda_app/models/productos.dart';
import 'package:tienda_app/screens/busquedas/busqueda.dart';
import 'package:tienda_app/screens/details/details_screen_locales.dart';

import 'package:tienda_app/screens/home/components/locales_card_horizontal.dart';

import '../home_screen.dart';

class BodyNegocios extends StatefulWidget {
  final List localesdb;
  final List categories;
  final List productosdb;
  final List categoriesproductos;

  const BodyNegocios({
    Key key,
    this.localesdb,
    this.categories,
    this.productosdb,
    this.categoriesproductos,
  }) : super(key: key);

  @override
  _BodyNegociosState createState() => _BodyNegociosState();
}

class _BodyNegociosState extends State<BodyNegocios> {
  List locallista = [];
  int selectedIndex = 0;
  String localoproduct;
  TextEditingController textcontroller;

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
  }

  Container boxlocales(List imagenes, String categoria) {
    if (imagenes != null) {
      if (widget.localesdb.isNotEmpty) {
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
                itemCount: widget.localesdb.length,
                itemBuilder: (context, index) => LocalesCardHorizontal(
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
                itemBuilder: (context, index) => LocalesCardHorizontal(
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

  Widget _categorias() {
    return localesProductos();
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
