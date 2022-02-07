import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tienda_app/components/search_box.dart';
import 'package:tienda_app/constantes.dart';
import 'package:tienda_app/models/locales.dart';
import 'package:tienda_app/models/productos.dart';
import 'package:tienda_app/screens/busquedas/busqueda_locales.dart';
import 'package:tienda_app/screens/busquedas/busqueda_productos.dart';
import 'package:tienda_app/screens/details/details_screen_locales.dart';
import 'package:tienda_app/screens/details/details_screen_product.dart';
import 'package:tienda_app/screens/busquedas/busqueda.dart';
import 'package:tienda_app/screens/home/components/productos_card_vertical.dart';
import 'package:tienda_app/screens/home/home_screen.dart';

import 'locales_card_vertical.dart';

class Body extends StatefulWidget {
  final List<Locales> localesdb;
  final List<Productos> productosdb;
  final List categories;
  final List categoriesproductos;

  const Body(
      {Key key,
      this.localesdb,
      this.productosdb,
      this.categories,
      this.categoriesproductos})
      : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List proandloc = ["Negocios", "Productos"];
  List locallista = [];
  int selectedIndex = 0;
  int selectedIndex2 = 0;
  String localoproduct;
  TextEditingController textcontroller;

  Column localesproductos() {
    if (selectedIndex2 == 0) {
      setState(() {
        localoproduct = "Locales";
      });
      return Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: (kDefaultPadding / 2) - 5.0),
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
                    right: index == widget.categories.length - 1
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
                    widget.categories[index],
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Image.asset(
            "assets/images/Home/linea.png",
            width: double.infinity,
          ),
        ],
      );
    } else {
      setState(() {
        localoproduct = "Productos";
      });
      return Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: (kDefaultPadding / 2) - 5.0),
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
          ),
          Image.asset(
            "assets/images/Home/linea.png",
            width: double.infinity,
          ),
        ],
      );
    }
  }

  Container boxlocales(List imagenes, String categoria) {
    if (imagenes != null) {
      if (categoria == "Locales") {
        return localesmostrar(imagenes);
      } else {
        return productosmostrar(imagenes);
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
    List<Locales> listaQuizas = [];
    if (widget.localesdb.length > 3) {
      for (var i = 0; i < 3; i++) {
        listaQuizas.add(widget.localesdb[i]);
      }
    }
    List listaQuizas2 = [0, 0, 0];
    if (imagenes.length > 3) {
      listaQuizas.clear();
      for (var i = 0; i < 3; i++) {
        listaQuizas.add(imagenes[i]);
      }
    } else {
      setState(() {
        listaQuizas2 = imagenes;
      });
    }
    return Container(
        height: 225.0,
        width: 700.0,
        child: (imagenes.isEmpty)
            ? ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: listaQuizas.length,
                itemBuilder: (context, index) => Container(
                      child: Row(
                        children: [
                          LocalesCard(
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
                                              localesdb: widget.localesdb,
                                            )));
                              }),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  child: (listaQuizas.length - 1 == index)
                                      ? _vermas("Locales")
                                      : Container()),
                            ],
                          ),
                        ],
                      ),
                    ))
            : ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: listaQuizas2.length,
                itemBuilder: (context, index) => Container(
                      child: Row(
                        children: [
                          LocalesCard(
                              itemIndex: index,
                              locales: widget.localesdb[imagenes[index]],
                              press: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailsScreen(
                                              locales: widget
                                                  .localesdb[imagenes[index]],
                                              productosdb: widget.productosdb,
                                              categories: widget.categories,
                                              categoriesproductos:
                                                  widget.categoriesproductos,
                                              localesdb: widget.localesdb,
                                            )));
                              }),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  child: (listaQuizas2.length - 1 == index)
                                      ? _vermas("Locales")
                                      : Container()),
                            ],
                          ),
                        ],
                      ),
                    )));
  }

  Container productosmostrar(List imagenes) {
    List<Productos> listaQuizas = [];
    if (widget.localesdb.length > 3) {
      for (var i = 0; i < 3; i++) {
        listaQuizas.add(widget.productosdb[i]);
      }
    }
    List listaQuizas2 = [0, 0, 0];
    if (imagenes.length > 3) {
      listaQuizas.clear();
      for (var i = 0; i < 3; i++) {
        listaQuizas.add(imagenes[i]);
      }
    } else {
      setState(() {
        listaQuizas2 = imagenes;
      });
    }
    return Container(
        height: 200.0,
        width: 700.0,
        child: (imagenes.isEmpty)
            ? ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: listaQuizas.length,
                itemBuilder: (context, index) => Container(
                      child: Row(
                        children: [
                          ProductosCard(
                              itemIndex: index,
                              productos: widget.productosdb[index],
                              press: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailsScreenProductos(
                                              productos:
                                                  widget.productosdb[index],
                                              productosdb: widget.productosdb,
                                            )));
                              }),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  child: (listaQuizas.length - 1 == index)
                                      ? _vermas("Productos")
                                      : Container()),
                            ],
                          ),
                        ],
                      ),
                    ))
            : ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: listaQuizas2.length,
                itemBuilder: (context, index) => Container(
                      child: Row(
                        children: [
                          ProductosCard(
                              itemIndex: index,
                              productos: widget.productosdb[imagenes[index]],
                              press: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailsScreenProductos(
                                                productos: widget.productosdb[
                                                    imagenes[index]],
                                                productosdb:
                                                    widget.productosdb)));
                              }),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  child: (listaQuizas2.length - 1 == index)
                                      ? _vermas("Productos")
                                      : Container()),
                            ],
                          ),
                        ],
                      ),
                    )));
  }

  Widget _vermas(String quebuscar) {
    List<Productos> lispro = [];
    if (quebuscar == "Productos") {
      if (selectedIndex != 0) {
        for (var li in widget.productosdb) {
          if (li.categoria == widget.categoriesproductos[selectedIndex]) {
            lispro.add(li);
          }
        }
      } else {
        lispro = widget.productosdb;
      }
      return Container(
        height: 50,
        margin: EdgeInsets.symmetric(horizontal: 30),
        alignment: Alignment.bottomRight,
        child: Container(
          height: 50,
          width: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Scaffold(
                              appBar:
                                  LocalesScreen().createState().buildAppBar2(),
                              backgroundColor: kPrimaryColor,
                              body: BusquedaProductos(
                                  productosdb: lispro,
                                  categoriesproductos:
                                      widget.categoriesproductos))));
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => kSecondaryColor)),
                child: Text("Ver más"),
              ),
            ],
          ),
        ),
      );
    } else {
      List lis = [];
      if (selectedIndex != 0) {
        for (var li in widget.localesdb) {
          if (li.categoria == widget.categories[selectedIndex]) {
            lis.add(li);
          }
        }
      } else {
        lis = widget.localesdb;
      }
      return Container(
        height: 50,
        margin: EdgeInsets.symmetric(horizontal: 30),
        alignment: Alignment.bottomRight,
        child: Container(
          height: 50,
          width: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Scaffold(
                              appBar:
                                  LocalesScreen().createState().buildAppBar2(),
                              backgroundColor: kPrimaryColor,
                              body: Busquedalocales(
                                  localesdb: lis,
                                  categories: widget.categories))));
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => kSecondaryColor)),
                child: Text("Ver más"),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget _logo() {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: CircleAvatar(
        radius: 70,
        backgroundColor: Colors.white,
        child: Image.asset(
          "assets/images/Home/logov2.png",
          color: kPrimaryColor,
        ),
      ),
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

  Widget _categorias() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: (kDefaultPadding / 2) - 5.0),
          height: 25,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: proandloc.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex2 = index;
                  selectedIndex = 0;
                  locallista = [];
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
          scale: 3.5,
          width: double.infinity,
        ),
        localesproductos(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _logo(),
          _searchBox(),
          _categorias(),
          Flexible(
            fit: FlexFit.loose,
            child: Container(
              child: Stack(
                children: <Widget>[
                  // Our background
                  Container(
                    margin: EdgeInsets.only(top: 60),
                    decoration: BoxDecoration(
                      color: kBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Container(
                      height: 100,
                      margin: EdgeInsets.only(top: 130),
                      decoration: BoxDecoration(
                        color: kBackgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                    ),
                  ),
                  boxlocales(locallista, localoproduct),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
