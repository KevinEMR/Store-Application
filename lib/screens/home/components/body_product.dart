import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tienda_app/components/search_box.dart';
import 'package:tienda_app/constantes.dart';
import 'package:tienda_app/models/locales.dart';
import 'package:tienda_app/models/productos.dart';
import 'package:tienda_app/screens/details/details_screen_product.dart';
import 'package:tienda_app/screens/busquedas/busqueda.dart';
import 'package:tienda_app/screens/home/components/productos_card_horizontal.dart';
import 'package:tienda_app/screens/home/home_screen.dart';

class BodyProduct extends StatefulWidget {
  final List<Locales> localesdb;
  final List<Productos> productosdb;
  final List categories;
  final List categoriesproductos;

  const BodyProduct(
      {Key key,
      this.localesdb,
      this.productosdb,
      this.categories,
      this.categoriesproductos})
      : super(key: key);

  @override
  _BodyProductState createState() => _BodyProductState();
}

class _BodyProductState extends State<BodyProduct> {
  List locallista = [];
  int selectedIndex = 0;
  String localoproduct = "Productos";
  TextEditingController textcontroller;

  Container localesProductos() {
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

  Container boxlocales(List imagenes, String categoria) {
    if (imagenes != null) {
      return productosmostrar(imagenes);
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

  Container productosmostrar(List imagenes) {
    return Container(
        child: (imagenes.isEmpty)
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: widget.productosdb.length,
                itemBuilder: (context, index) => ProductosCardHorizontal(
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
                itemBuilder: (context, index) => ProductosCardHorizontal(
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
