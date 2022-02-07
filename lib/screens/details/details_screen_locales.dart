import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tienda_app/constantes.dart';
import 'package:tienda_app/models/locales.dart';
import 'package:tienda_app/models/productos.dart';
import 'package:tienda_app/widgets/cart_button.dart';

import 'components/body_locales.dart';

class DetailsScreen extends StatelessWidget {
  final Locales locales;
  final List<Productos> productosdb;
  final List<Locales> localesdb;
  final List categories;
  final List categoriesproductos;

  const DetailsScreen(
      {Key key,
      this.locales,
      this.productosdb,
      this.categories,
      this.categoriesproductos,
      this.localesdb})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: buildAppBar(context),
      body: Body(
          locales: locales,
          productosdb: productosdb,
          categories: categories,
          categoriesproductos: categoriesproductos,
          localesdb: localesdb),
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
