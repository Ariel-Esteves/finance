import 'package:finance/cfg/security.dart';

import 'package:finance/screens/Interprise.dart';
import 'package:finance/screens/home.dart';
import 'package:finance/screens/interprise_view.dart';
import 'package:finance/screens/login.dart';
import 'package:finance/screens/person.dart';
import 'package:finance/screens/product_list.dart';
import 'package:finance/screens/sale.dart';
import 'package:finance/screens/sale_detail.dart';
import 'package:finance/screens/sale_view.dart';
import 'package:finance/screens/signup.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool token = await TokenStorage().isTokenValid();

  runApp(
    MaterialApp(
      initialRoute: token ? '/home' : '/login',
      home: LoginScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => Home(),
        '/sale': (context) => SaleScreen(),
        '/person': (context) => PersonFormScreen(),
        '/product': (context) => ProductListScreen(),
        '/interprise': (context) => InterpriseView(),
        '/new_interprise': (context) => InterpriseForm(),
        '/signup': (context) => Signup(),
        '/sale_view': (context) => SaleView(),
        '/new_sale': (context) => SaleScreen(),
        '/sale_detail': (context) => SaleDetail(),
      },
    ),
  );
}
