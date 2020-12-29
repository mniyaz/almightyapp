import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';
import '../cards/product_card.dart';
import 'package:almighty/globals.dart' as globals;

import 'dart:convert';

class HomePage extends StatefulWidget {

  @override
  HomePageState createState() => HomePageState();
}


class HomePageState extends State<HomePage> {
  TextEditingController controller = new TextEditingController();
  Future<Null> getProductList() async {
    final response = await http.get("https://almightysnk.com/rest/productcontroller/getlist/9952515251");
    final responseJson = json.decode(response.body);

    setState(() {
      productListFromApi = (responseJson as List)
          .map((i) => Product.fromJson(i))
          .toList();
      productList = productListFromApi;
    });

  }

  @override
  void initState(){
    super.initState();
    getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          centerTitle: false,

          title: new Text("Almighty e-shop"),
          automaticallyImplyLeading: false,
        actions: <Widget>[
           new Container(
              height: 150.0,
              width: 30.0,
              child: new Stack(

                  children: <Widget>[
                    new IconButton(icon: new Icon(Icons.shopping_cart,
                      color: Colors.white,),
                      onPressed: null,
                    ),
                    globals.cartItems == null || globals.cartItems.length ==0 ? new Container() :
                    new Positioned(

                        child: new Stack(
                          children: <Widget>[
                            new Icon(
                                Icons.brightness_1,
                                size: 20.0, color: Colors.green[800]),
                            new Positioned(
                                top: 4.0,
                                right: 6.0,
                                child: new Center(
                                  child: new Text(
                                    globals.cartItems.length.toString(),
                                    style: new TextStyle(
                                        color: Colors.white,
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                )),


                          ],
                        )),

                  ],
                ),

          ),
      PopupMenuButton<String>(
        onSelected: handleClick,
        itemBuilder: (BuildContext context) {
          return {'Logout', 'profile'}.map((String choice) {
            return PopupMenuItem<String>(
              value: choice,
              child: Text(choice),
            );
          }).toList();
        },
      ),
      ],
      ),
      body: SafeArea(
          child: new Column(
        children: <Widget>[
          new Container(
            //color: Theme.of(context).primaryColor,
            child: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Card(
                child: new ListTile(
                  leading: new Icon(Icons.search),
                  title: new TextField(
                    controller: controller,
                    decoration: new InputDecoration(
                      hintText: 'Search Product',
                      border: InputBorder.none,
                    ),
                    onChanged: onSearchTextChanged,
                  ),
                  trailing: new IconButton(
                    icon: new Icon(Icons.cancel),
                    onPressed: () {
                      controller.clear();
                      onSearchTextChanged('');
                    },
                  ),
                ),
              ),
            ),
          ),
          new Expanded(
            child: searchResult.length != 0 || controller.text.isNotEmpty
                ? new ListView.builder(
              itemCount: searchResult.length,
              itemBuilder: (context, i) {
                return ProductCard(searchResult[i], onAdd: () => updateCart(i));
              },
            )
                : productList != null && productList.length > 0
                ?  RefreshIndicator(
              child:new ListView.builder(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                return ProductCard(productList[index], onAdd: () => updateCart(index));
              },
            ),
              onRefresh: getProductList,)
                : Center(child: Text("No data found for selected Filter")),
          ),
        ],
      ),
      ),
    );
  }
  void updateCart(index){
    setState(() {
      int total = globals.cartItems.fold(0, (sum, item) => sum + int.parse(item.rowTotal));
      globals.order.totalPriceBeforeTax = total.toString();
      globals.order.grandTotal = total.toString();
    });
  }
  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        break;
      case 'Settings':
        break;
    }
  }
  onSearchTextChanged(String text) async {
    text = text.toLowerCase();
    print(text);
    searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    productList.forEach((product) {
      if (product.itemName.toLowerCase().contains(text))
        searchResult.add(product);
    });

    setState(() {});
  }
}

List<Product> productList;
List<Product> productListFromApi;
List<Product> searchResult = [];

