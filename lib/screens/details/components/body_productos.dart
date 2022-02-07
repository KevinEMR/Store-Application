import 'package:flutter/material.dart';
import 'package:tienda_app/constantes.dart';
import 'package:tienda_app/models/productos.dart';

import 'chat_and_buy.dart';
import 'product_image.dart';

class BodyProductos extends StatefulWidget {
  final Productos productos;
  final List<Productos> productosdb;

  const BodyProductos({Key key, this.productos, this.productosdb})
      : super(key: key);

  @override
  State<BodyProductos> createState() => _BodyProductosState();
}

class _BodyProductosState extends State<BodyProductos> {
  final TextStyle myStyle = TextStyle(
    fontSize: 18,
  );
  int count = 1;

  Widget _buildQuentityPart() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Text(
          "Cantidad",
          style: myStyle,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 40,
          width: 130,
          decoration: BoxDecoration(
              color: kSecondaryColor, borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                child: Icon(
                  Icons.remove,
                  color: Colors.black,
                ),
                onTap: () {
                  setState(() {
                    if (count > 1) {
                      count--;
                    }
                  });
                },
              ),
              Text(
                count.toString(),
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              GestureDetector(
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                onTap: () {
                  setState(() {
                    count++;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // it provide us total height and width
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small devices
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              decoration: BoxDecoration(
                color: kBackgroundColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Hero(
                      tag: '${widget.productos.id}',
                      child: ProductPoster(
                        size: size,
                        image: widget.productos.image,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: kDefaultPadding / 2),
                    child: Text(
                      widget.productos.name,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Text(
                    '\$${widget.productos.price}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: kSecondaryColor,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                    child: Text(
                      "\n${widget.productos.description}",
                      style: TextStyle(color: kTextLightColor),
                    ),
                  ),
                  SizedBox(height: kDefaultPadding),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _buildQuentityPart(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ChatAndProducto(
              productos: widget.productos,
              productosdb: widget.productosdb,
              price: widget.productos.price.toDouble(),
              image: widget.productos.image,
              name: widget.productos.name,
              quentity: count,
            ),
          ],
        ),
      ),
    );
  }
}
