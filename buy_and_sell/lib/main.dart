import 'package:buy_and_sell/UI/screens/landing%20page/home.dart';
import 'package:buy_and_sell/api_manager/dio%20client/dio_client.dart';
import 'package:buy_and_sell/providers/cart_provider.dart';
import 'package:buy_and_sell/providers/checkout_provider.dart';
import 'package:buy_and_sell/providers/featured_products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrderServiceProvider()),

    ],
    child: MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen()
    ),
    );
  }
}
