import 'package:almighty/cards/order_card.dart';
import 'package:almighty/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:almighty/globals.dart' as globals;

import 'dart:convert';

class OrderHistoryPage extends StatefulWidget {

  @override
  OrderHistoryPageState createState() => OrderHistoryPageState();
}

class OrderHistoryPageState extends State<OrderHistoryPage> {

  List<Order> orderListFromApi;
  List<Order> orderList;

  Future<Null> getOrderList() async {
    final response = await http.get("https://almightysnk.com/rest/ordercontroller/orderHistory/12/demo/1689270076");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(response.toString()),
    ));
    final responseJson = json.decode(response.body);
    setState(() {
      orderListFromApi = (responseJson as List)
          .map((i) => Order.fromJson(i))
          .toList();
      orderList = orderListFromApi;
    });

  }

  @override
  void initState(){
    super.initState();
    getOrderList();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          centerTitle: false,

          title: new Text("Almighty e-shop"),
          automaticallyImplyLeading: false,
          actions: <Widget>[
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
        body: RefreshIndicator(
            child :orderList != null && orderList.length != 0 ? Column(
            children:[
              Expanded(
                child:
         ListView.builder(
                  itemCount: orderList.length,
                  itemBuilder: (context, i) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(" Added to Cart."),
                    ));
                    return OrderCard(orderList[i]);
                  },
                ) ),
            ])  : new Container(
              alignment: Alignment.center,
            child: Text("No Orders Found.")
        ),onRefresh: getOrderList,),
    );
  }

  void removeItem(int index) {
    setState(() {
      globals.cartItems = List.from(globals.cartItems)
        ..removeAt(index);
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
}