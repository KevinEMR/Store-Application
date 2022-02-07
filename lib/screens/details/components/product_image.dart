import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

import 'package:tienda_app/constantes.dart';

class ProductPoster extends StatefulWidget {
  const ProductPoster({
    Key key,
    @required this.size,
    this.image,
  }) : super(key: key);

  final Size size;
  final String image;

  @override
  State<ProductPoster> createState() => _ProductPosterState();
}

class _ProductPosterState extends State<ProductPoster> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding),
      // the height of this container is 80% of our width
      height: widget.size.width * 0.8,

      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            height: widget.size.width * 0.7,
            width: widget.size.width * 0.7,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          Container(
            child: Carousel(
              dotSpacing: 35.0,
              autoplay: false,
              showIndicator: true,
              images: [
                Image.network(
                  widget.image,
                  height: widget.size.width * 0.75,
                  width: widget.size.width * 0.75,
                  fit: BoxFit.cover,
                ),
                Image.network(
                  widget.image,
                  height: widget.size.width * 0.75,
                  width: widget.size.width * 0.75,
                  fit: BoxFit.cover,
                ),
                Image.network(
                  widget.image,
                  height: widget.size.width * 0.75,
                  width: widget.size.width * 0.75,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
