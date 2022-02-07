import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tienda_app/models/cartmodel.dart';

import 'package:tienda_app/provider/product_provider.dart';
import 'package:tienda_app/screens/home/home_screen.dart';
import 'package:tienda_app/widgets/checkout_singleproduct.dart';
import 'package:tienda_app/widgets/mybutton.dart';
import 'package:tienda_app/widgets/notification_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatefulWidget {
  @override
  _CheckOutState createState() => _CheckOutState();
}

enum SingingCharacter { domicilio, retirar }

class _CheckOutState extends State<CheckOut> {
  TextStyle myStyle = TextStyle(
    fontSize: 18,
  );
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  SingingCharacter _character = SingingCharacter.domicilio;

  ProductProvider productProvider;

  Widget _buildBottomSingleDetail({String startName, String endName}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          startName,
          style: myStyle,
        ),
        Text(
          endName,
          style: myStyle,
        ),
      ],
    );
  }

  User user;
  double total;
  List<CartModel> myList;

  Widget _buildButton() {
    return Column(
        children: productProvider.userModelList.map((e) {
      return Container(
        height: 50,
        child: MyButton(
          name: "Comprar",
          onPressed: () {
            if (productProvider.getCheckOutModelList.isNotEmpty) {
              FirebaseFirestore.instance.collection("Order").add({
                "Product": productProvider.getCheckOutModelList
                    .map((c) => {
                          "ProductName": c.name,
                          "ProductPrice": c.price,
                          "ProductQuetity": c.quentity,
                          "ProductImage": c.image,
                        })
                    .toList(),
                "TotalPrice": total.toStringAsFixed(2),
                "UserName": e.userName,
                "UserEmail": e.userEmail,
                "UserNumber": e.userPhoneNumber,
                "UserAddress": e.userAddress,
                "UserId": user.uid,
                "UserObtener": _character.toString(),
              });
              setState(() {
                myList.clear();
              });

              productProvider.addNotification("Notification");
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("No hay Items"),
                ),
              );
            }
          },
        ),
      );
    }).toList());
  }

  @override
  void initState() {
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    myList = productProvider.checkOutModelList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = FirebaseAuth.instance.currentUser;
    double subTotal = 0;
    double discount = 3;
    double discountRupees;
    double shipping = 60;

    productProvider = Provider.of<ProductProvider>(context);
    productProvider.getCheckOutModelList.forEach((element) {
      subTotal += element.price * element.quentity;
    });

    discountRupees = discount / 100 * subTotal;
    total = subTotal + shipping - discountRupees;
    if (productProvider.checkOutModelList.isEmpty) {
      total = 0.0;
      discount = 0.0;
      shipping = 0.0;
    }

    return WillPopScope(
      onWillPop: () async {
        return Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => LocalesScreen(),
          ),
        );
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Carrito", style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => LocalesScreen(),
                ),
              );
            },
          ),
          actions: <Widget>[
            NotificationButton(
              colorwidget: Colors.black,
            ),
          ],
        ),
        bottomNavigationBar: Container(
          height: 70,
          width: 100,
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.only(bottom: 15),
          child: _buildButton(),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: ListView.builder(
                    itemCount: myList.length,
                    itemBuilder: (ctx, myIndex) {
                      return CheckOutSingleProduct(
                        index: myIndex,
                        image: myList[myIndex].image,
                        name: myList[myIndex].name,
                        price: myList[myIndex].price,
                        quentity: myList[myIndex].quentity,
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Radio(
                                    value: SingingCharacter.domicilio,
                                    groupValue: _character,
                                    onChanged: (SingingCharacter value) {
                                      setState(() {
                                        _character = value;
                                      });
                                    }),
                                Expanded(
                                  child: Text('A domicilio'),
                                )
                              ],
                            ),
                            flex: 1,
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Radio(
                                    value: SingingCharacter.retirar,
                                    groupValue: _character,
                                    onChanged: (SingingCharacter value) {
                                      setState(() {
                                        _character = value;
                                      });
                                    }),
                                Expanded(child: Text('Retirar en el sitio'))
                              ],
                            ),
                            flex: 1,
                          ),
                        ],
                      ),
                      _buildBottomSingleDetail(
                        startName: "Subtotal",
                        endName: "\$ ${subTotal.toStringAsFixed(2)}",
                      ),
                      _buildBottomSingleDetail(
                        startName: "Descuento",
                        endName: "${discount.toStringAsFixed(2)}%",
                      ),
                      _buildBottomSingleDetail(
                        startName: "Envió",
                        endName: "\$ ${shipping.toStringAsFixed(2)}",
                      ),
                      _buildBottomSingleDetail(
                        startName: "Total",
                        endName: "\$ ${total.toStringAsFixed(2)}",
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
