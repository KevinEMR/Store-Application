import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tienda_app/screens/carro/checkout.dart';
import '../provider/product_provider.dart';

class CartButton extends StatefulWidget {
  final Color colorwidget;

  const CartButton({this.colorwidget});
  @override
  _CartButtonState createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  ProductProvider productProvider;

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    return Badge(
      position: BadgePosition(start: 25, top: 8),
      badgeContent: Text(
        productProvider.getProductoIndex.toString(),
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      badgeColor: Colors.amber,
      child: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/cart_with_item.svg',
          color: widget.colorwidget,
        ),
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => CheckOut()));
        },
      ),
    );
  }
}
