 import 'package:flutter/material.dart';

import 'fetch_products.dart';

 class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 247, 247),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 239, 247, 247),
        centerTitle: true,
        elevation: 0,
        title: Text('Food express Admin', style: TextStyle(color: Colors.black, fontSize: 24),)),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: fetchData("buy-products")),
          ],
        ),
      ),
    );
  }
}