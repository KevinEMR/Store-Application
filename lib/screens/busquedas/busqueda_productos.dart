import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tienda_app/constantes.dart';
import 'package:tienda_app/models/productos.dart';
import 'package:tienda_app/screens/details/details_screen_product.dart';
import 'package:tienda_app/screens/home/components/productos_card_horizontal.dart';

class BusquedaProductos extends StatefulWidget {
  final List<Productos> productosdb;
  final List categoriesproductos;
  const BusquedaProductos({Key key, this.productosdb, this.categoriesproductos})
      : super(key: key);

  @override
  _BusquedaProductosState createState() => _BusquedaProductosState(
      productosdb: productosdb, categoriesproductos: categoriesproductos);
}

class _BusquedaProductosState extends State<BusquedaProductos> {
  _BusquedaProductosState({this.productosdb, this.categoriesproductos});

  final List<Productos> productosdb;
  final List categoriesproductos;
  List proandloc = ["Servicios", "Productos"];
  List locallista = [];
  int selectedIndex = 0;
  String localoproduct;

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
              right:
                  index == categoriesproductos.length - 1 ? kDefaultPadding : 0,
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
                itemCount: productosdb.length,
                itemBuilder: (context, index) => ProductosCardHorizontal(
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
                itemBuilder: (context, index) => ProductosCardHorizontal(
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
