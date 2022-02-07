import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tienda_app/constantes.dart';
import 'package:tienda_app/models/productos.dart';
import 'package:tienda_app/widgets/cart_button.dart';

import 'components/body_productos.dart';

class DetailsScreenProductos extends StatelessWidget {
  final Productos productos;
  final List<Productos> productosdb;

  const DetailsScreenProductos({Key key, this.productos, this.productosdb})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: buildAppBar(context),
      body: BodyProductos(
        productos: productos,
        productosdb: productosdb,
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kBackgroundColor,
      elevation: 0,
      leading: IconButton(
        padding: EdgeInsets.only(left: kDefaultPadding),
        icon: SvgPicture.asset("assets/icons/back.svg"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: false,
      title: Text(
        'Back'.toUpperCase(),
        style: Theme.of(context).textTheme.bodyText2,
      ),
      actions: <Widget>[
        CartButton(colorwidget: Colors.black),
      ],
    );
  }
}
