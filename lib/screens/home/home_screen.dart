import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tienda_app/constantes.dart';
import 'package:tienda_app/models/locales.dart';
import 'package:tienda_app/models/productos.dart';
import 'package:tienda_app/models/usermodel.dart';
import 'package:tienda_app/provider/product_provider.dart';
import 'package:tienda_app/screens/about/about.dart';
import 'package:tienda_app/screens/carro/checkout.dart';
import 'package:tienda_app/screens/contacto/contactus.dart';
import 'package:tienda_app/screens/home/components/body_product.dart';
import 'package:tienda_app/screens/perfil/profilescreen.dart';
import 'package:tienda_app/screens/welcome/welcomescreen.dart';
import 'package:tienda_app/widgets/cart_button.dart';
import 'package:tienda_app/widgets/notification_button.dart';

import 'components/body.dart';
import 'components/body_all.dart';
import 'components/body_negocios.dart';

class LocalesScreen extends StatefulWidget {
  @override
  _LocalesScreenState createState() => _LocalesScreenState();
}

ProductProvider productProvider;

class _LocalesScreenState extends State<LocalesScreen> {
  List<Locales> localesdb = [];
  List<Productos> productosdb = [];
  List categories = [];
  List categoriesproductos = [];

  void getLocales() async {
    CollectionReference colletionlocales =
        FirebaseFirestore.instance.collection("locales");
    QuerySnapshot locales = await colletionlocales.get();
    if (locales.docs.length != 0) {
      for (var doc in locales.docs) {
        Locales local = new Locales(
            int.parse(doc.id),
            doc["phone"],
            doc["name"],
            doc["description"],
            doc["image"],
            doc["category"],
            doc["address"]);
        setState(() {
          localesdb.add(local);
        });
      }
    }
    CollectionReference colletioncat =
        FirebaseFirestore.instance.collection("categorias");
    QuerySnapshot categorias = await colletioncat.get();
    if (categorias.docs.length != 0) {
      for (var cat in categorias.docs) {
        setState(() {
          categories.add(cat["name"]);
        });
      }
    }
    CollectionReference colletionproductos =
        FirebaseFirestore.instance.collection("productos");
    QuerySnapshot productos = await colletionproductos.get();
    if (productos.docs.length != 0) {
      for (var pro in productos.docs) {
        Productos producto = new Productos(
            int.parse(pro.id),
            pro["price"],
            pro["name"],
            pro["description"],
            pro["image"],
            pro["category"],
            pro["local"]);
        setState(() {
          productosdb.add(producto);
        });
      }
    }
    CollectionReference colletionproductoscat =
        FirebaseFirestore.instance.collection("categorias_productos");
    QuerySnapshot productoscategoria = await colletionproductoscat.get();
    if (productoscategoria.docs.length != 0) {
      for (var procat in productoscategoria.docs) {
        setState(() {
          categoriesproductos.add(procat["name"]);
        });
      }
    }
  }

  PageController _pageController;
  int _currentIndex = 0;
  double height, width;
  bool homeColor = true;
  bool checkoutColor = false;
  bool aboutColor = false;
  bool contactUsColor = false;
  bool profileColor = false;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    getLocales();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildUserAccountsDrawerHeader() {
    List<UserModel> userModel = productProvider.userModelList;
    return Column(
        children: userModel.map((e) {
      return UserAccountsDrawerHeader(
        accountName: Text(
          e.userName,
          style: TextStyle(color: Colors.black),
        ),
        currentAccountPicture: CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: (e.userImage.startsWith("http"))
              ? NetworkImage(e.userImage)
              : AssetImage("assets/images/User/userImage.png"),
        ),
        decoration: BoxDecoration(color: Color(0xfff2f2f2)),
        accountEmail: Text(e.userEmail, style: TextStyle(color: Colors.black)),
      );
    }).toList());
  }

  Widget _buildMyDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          _buildUserAccountsDrawerHeader(),
          ListTile(
            selected: homeColor,
            onTap: () {
              setState(() {
                homeColor = true;
                contactUsColor = false;
                checkoutColor = false;
                aboutColor = false;
                profileColor = false;
              });
            },
            leading: Icon(Icons.home),
            title: Text("Home"),
          ),
          ListTile(
            selected: checkoutColor,
            onTap: () {
              setState(() {
                checkoutColor = true;
                contactUsColor = false;
                homeColor = false;
                profileColor = false;
                aboutColor = false;
              });
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => CheckOut()));
            },
            leading: Icon(Icons.shopping_cart),
            title: Text("Carrito"),
          ),
          ListTile(
            selected: aboutColor,
            onTap: () {
              setState(() {
                aboutColor = true;
                contactUsColor = false;
                homeColor = false;
                profileColor = false;
                checkoutColor = false;
              });
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => About()));
            },
            leading: Icon(Icons.info),
            title: Text("Sobre nosotros"),
          ),
          ListTile(
            selected: profileColor,
            onTap: () {
              setState(() {
                aboutColor = false;
                contactUsColor = false;
                homeColor = false;
                profileColor = true;
                checkoutColor = false;
              });
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => ProfileScreen(),
                ),
              );
            },
            leading: Icon(Icons.info),
            title: Text("Perfil"),
          ),
          ListTile(
            selected: contactUsColor,
            onTap: () {
              setState(() {
                contactUsColor = true;
                checkoutColor = false;
                profileColor = false;
                homeColor = false;
                aboutColor = false;
              });
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => ContactUs()));
            },
            leading: Icon(Icons.phone),
            title: Text("Contáctanos"),
          ),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => WelcomeScreen()));
            },
            leading: Icon(Icons.exit_to_app),
            title: Text("Cerrar Sesión"),
          ),
        ],
      ),
    );
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  void getCallAllFunction() {
    productProvider.getNewAchiveData();
    productProvider.getFeatureData();
    productProvider.getHomeFeatureData();
    productProvider.getHomeAchiveData();
    productProvider.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    getCallAllFunction();
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _key,
      drawer: _buildMyDrawer(),
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(),
      backgroundColor: kPrimaryColor,
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: [
            SingleChildScrollView(
              child: Body(
                localesdb: localesdb,
                productosdb: productosdb,
                categories: categories,
                categoriesproductos: categoriesproductos,
              ),
            ),
            BodyAll(
              localesdb: localesdb,
              productosdb: productosdb,
              categories: categories,
              categoriesproductos: categoriesproductos,
            ),
            BodyNegocios(
              localesdb: localesdb,
              productosdb: productosdb,
              categories: categories,
              categoriesproductos: categoriesproductos,
            ),
            BodyProduct(
              localesdb: localesdb,
              productosdb: productosdb,
              categories: categories,
              categoriesproductos: categoriesproductos,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text('Home'),
            activeColor: Colors.redAccent,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.all_inbox),
            title: Text('All'),
            activeColor: Colors.pinkAccent,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.store),
            title: Text(
              'Negocios',
            ),
            activeColor: Colors.deepPurpleAccent,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.blender),
            title: Text('Productos'),
            activeColor: Colors.blueAccent,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          _key.currentState.openDrawer();
        },
      ),
      elevation: 0.0,
      centerTitle: true,
      title: Text('El Barrio'),
      actions: <Widget>[
        NotificationButton(),
        CartButton(colorwidget: Colors.white),
      ],
    );
  }

  AppBar buildAppBar2() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Text('El Barrio'),
      actions: <Widget>[
        NotificationButton(),
        CartButton(colorwidget: Colors.white),
      ],
    );
  }
}
