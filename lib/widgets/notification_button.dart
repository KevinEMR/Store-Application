import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';

class NotificationButton extends StatefulWidget {
  final Color colorwidget;

  const NotificationButton({Key key, this.colorwidget}) : super(key: key);
  @override
  _NotificationButtonState createState() => _NotificationButtonState();
}

class _NotificationButtonState extends State<NotificationButton> {
  ProductProvider productProvider;
  Future<void> myDialogBox(context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Alerta"),
            actions: [
              TextButton(
                child: Text("Limpiar Notificaciones"),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    productProvider.notificationList.clear();
                  });
                },
              ),
              TextButton(
                child: Text("Listo"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(productProvider.notificationList.isNotEmpty
                      ? "Tu producto esta en camino"
                      : "Sin Notificaciones"),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    return Badge(
      position: BadgePosition(start: 25, top: 8),
      badgeContent: Text(
        productProvider.getNotificationIndex.toString(),
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      badgeColor: Colors.red,
      child: IconButton(
        icon: Icon(
          Icons.notifications,
          color: widget.colorwidget,
        ),
        onPressed: () {
          myDialogBox(context);
        },
      ),
    );
  }
}
