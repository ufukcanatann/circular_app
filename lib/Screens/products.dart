import 'dart:convert';

import 'package:flutter/material.dart';

import '../Services/get_services.dart';
import 'functions/data.dart';
import 'functions/layouts.dart';
import 'functions/widget copy.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<dynamic> products = [];
  bool isLoading = true;
  var userData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    urunlerigetir();
    getuserdata();
  }

  getuserdata() async {
    var sonuc = await getUserAllData();
    setState(() {
      userData = sonuc;
    });
  }

  Future<dynamic> urunlerigetir() async {
    var response = await GetServices.getProdcuts();
    setState(() {
      var ara = json.decode(response.body);
      products = ara['data'];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return loadingbar();
    } else {
      return WillPopScope(
          child: Scaffold(
            appBar: buildHeader(context, 8),
            // endDrawer: drawer(context,userData),
            body: Container(
              padding: EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductCard(products[index], context);
                },
              ),
            ),
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () {
            //     // Sepeti görüntüleme işlemi veya sayfa yönlendirmesi eklenmelidir.
            //   },
            //   child: Icon(Icons.shopping_cart),
            // ),
          ),
          onWillPop: () async {
            return false;
          });
    }
  }
}

// ignore: non_constant_identifier_names
ProductCard(product, context) {
  return Card(
    elevation: 1,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.2,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              product['image'],
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            product['name'],
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            product['price'] + " Puan",
            style: TextStyle(
              fontSize: 16,
              color: Colors.green,
            ),
          ),
        ),
      ],
    ),
  );
}
