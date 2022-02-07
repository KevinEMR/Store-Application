import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tienda_app/models/locales.dart';

import '../../../constantes.dart';

class LocalesCardHorizontal extends StatelessWidget {
  const LocalesCardHorizontal({
    Key key,
    this.itemIndex,
    this.locales,
    this.press,
  }) : super(key: key);

  final int itemIndex;
  final Locales locales;
  final Function press;

  @override
  Widget build(BuildContext context) {
    // It  will provide us total height and width of our screen
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      // color: Colors.blueAccent,
      height: 160,
      child: InkWell(
        onTap: press,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // Those are our background
            Container(
              height: 136,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: itemIndex.isEven ? kBlueColor : kSecondaryColor,
                boxShadow: [kDefaultShadow],
              ),
              child: Container(
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
            // our product image
            Positioned(
              top: 11.7,
              right: 9.8,
              child: Hero(
                tag: '${locales.id}',
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
                  height: 136,
                  // image is square but we add extra 20 + 20 padding thats why width is 200
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(63),
                      bottomLeft: Radius.circular(63),
                      topRight: Radius.circular(22),
                      bottomRight: Radius.circular(22),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 60,
                        color: kPrimaryColor.withOpacity(0.29),
                      ),
                    ],
                    image: DecorationImage(
                      alignment: Alignment(-0.3, 0.6),
                      fit: BoxFit.cover,
                      image: NetworkImage(locales.image),
                    ),
                  ),
                ),
              ),
            ),
            // Product title and price
            Positioned(
              bottom: 11.7,
              left: 0,
              child: SizedBox(
                height: 136,
                // our image take 200 width, thats why we set out total width - 200
                width: size.width - 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                      ),
                      child: Text(
                        locales.title,
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Text(
                        "${locales.categoria}".toUpperCase(),
                        style: TextStyle(
                          color: kPrimaryColor.withOpacity(0.5),
                        ),
                      ),
                    ),
                    // it use the available space
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 1.5, // 30 padding
                        vertical: kDefaultPadding / 4, // 5 top and bottom
                      ),
                      decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(22),
                          topRight: Radius.circular(22),
                        ),
                      ),
                      child: Text(
                        "${locales.telefono}",
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
