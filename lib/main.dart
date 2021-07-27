import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app2/module/categories/categories.dart';
import 'package:flutter_app2/module/categories/sub_categories.dart';
import 'module/blank_view.dart';
import 'file:///E:/androidProjects/myProojects/flutter_app2/lib/module/home/home.dart';
import 'package:flutter_app2/module/products/products_screen.dart';
import 'package:flutter_app2/network/MyBlocObserver.dart';
import 'package:flutter_app2/network/cach_helper/cacheHelper.dart';
import 'package:flutter_app2/network/dio_helper/dioHelper.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    DioHelper.init();
    CacheHelper.init();
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: navigatorKey,
      routes: {
        '/second': (context) => ProductsScreen(),
        '/sub': (context) => SubCategoriesLayout(),
      },
      theme: ThemeData(
        backgroundColor: Colors.white,
        primarySwatch: Colors.grey,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
        ),
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  List<Widget> layouts = [
    HomeScreen(),
    CategoriesLayout(),
    BlankView(),
    BlankView(),
    BlankView()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backwardsCompatibility: false,
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Colors.white),
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Image(
            image: AssetImage(
              'assets/images/logo.png',
            ),
            width: 40,
            height: 40,
          ),
          leading: IconButton(
            icon: Icon(
              Icons.notifications_none,
              color: Colors.black54,
            ),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.favorite_border,
                color: Colors.black54,
              ),
              onPressed: () {},
            )
          ],
        ),
        body: layouts[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.red,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.menu), label: 'Categories'),
            BottomNavigationBarItem(
                icon: Icon(Icons.local_offer_outlined), label: 'Offers'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (_currentIndex != 0) {
      setState(() {
        _currentIndex = 0;
      });
      return await false;
    } else
     { return await true;}
  }
}
