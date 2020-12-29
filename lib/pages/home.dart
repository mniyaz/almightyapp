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
  List<Product> productList;
  List<Product> productListFromApi = List<Product>();
  List<Product> searchResult;
  Future<Null> getProductList() async {
    final response = await http.get("https://almightysnk.com/rest/productcontroller/getlist/9952515251");
    final responseJson = json.decode(response.body);
    productListFromApi = (responseJson as List)
        .map((i) => Product.fromJson(i))
        .toList();
    setState(() {
      if(productList == null)
        productList = List<Product>();
      productList.addAll(productListFromApi);
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                filterSearchResults(value);
              },
              controller: controller,
              decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
          ),
          new Expanded(
            child:
                 productList != null && productList.length > 0
                ?  RefreshIndicator(
              child:new ListView.builder(
                  shrinkWrap: true,
                itemCount: productList.length,
              itemBuilder: (context, index) {
                final item = productList[index];
                return ProductCard(key: ObjectKey(item), product: productList[index], onAdd: () => updateCart(index));

              }
    ),


              onRefresh: getProductList,)
                : Center(child: Text("No data found for selected Filter")),
          ),
        ],
      ),
      ),
    );
  }

  void filterSearchResults(String query) {
    List<Product> dummySearchList = List<Product>();
    dummySearchList.addAll(productListFromApi);
    if(query.isNotEmpty) {
      List<Product> dummyListData = List<Product>();
      dummySearchList.forEach((item) {
        if(item.itemName.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      productList.clear();
      setState(() {
        productList.addAll(dummyListData);
      });
      return;
    } else {
      productList.clear();
      setState(() {
        productList.addAll(productListFromApi);
      });
    }
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
    if(searchResult != null)
    searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    productList.forEach((product) {
      if (product.itemName.toLowerCase().contains(text)) {
        if(searchResult == null)
        searchResult = List();
        searchResult.add(product);
      }

      setState(() {

      });
    });

    setState(() {});
  }
}

