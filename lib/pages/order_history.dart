import 'package:almighty/cards/order_card.dart';
import 'package:almighty/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:almighty/globals.dart' as globals;

import 'dart:convert';

class OrderHistoryPage extends StatefulWidget {
  final DateTime initialDate = DateTime.now();
  @override
  OrderHistoryPageState createState() => OrderHistoryPageState();
}

class OrderHistoryPageState extends State<OrderHistoryPage> {
  List<Order> orderListFromApi;
  List<Order> orderList;
  DateTime selectedDate;

  Future<Null> getOrderList(String month,String year) async {
    final response = await http.get(
        "https://almightysnk.com/rest/ordercontroller/orderHistory/"+month+"/demo/1689321212");

    final responseJson = json.decode(response.body);
    setState(() {
      orderListFromApi =
          (responseJson as List).map((i) => Order.fromJson(i)).toList();
      print(responseJson);
      orderList = orderListFromApi;
    });
  }

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
    getOrderList("${selectedDate?.month}","${selectedDate?.year}");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: false,
        title: new Text("Almighty e-shop"),
        automaticallyImplyLeading: false,
      ),
      body: Column(
    children: <Widget>[
        Row(
    children: [
      Text(
        'Year: ${selectedDate?.year} Month: ' + new DateFormat("MMM").format(selectedDate).toString(),
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
      ),
    ],
    ),
        new Expanded(
            child:RefreshIndicator(
        child: orderList != null && orderList.length != 0
            ? Column(children: [
                Expanded(
                    child: ListView.builder(
                  itemCount: orderList.length,
                  itemBuilder: (context, i) {
                    final item = orderList[i];
                    return OrderCard(key: ObjectKey(item),order:orderList[i]);
                  },
                )),
              ])
            : new Container(
                alignment: Alignment.center, child: Text("No Orders Found.")),
        onRefresh: refreshList,
      ),)]),floatingActionButton: Builder(
      builder: (context) => FloatingActionButton(
        onPressed: () {
          showMonthPicker(
            context: context,
            firstDate: DateTime(DateTime.now().year - 1, 5),
            lastDate: DateTime(DateTime.now().year + 1, 9),
            initialDate: selectedDate ?? widget.initialDate,
            locale: Locale("en"),
          ).then((date) {
            if (date != null) {
              setState(() {
                selectedDate = date;
                getOrderList("${selectedDate?.month}","${selectedDate?.year}");
              });
            }
          });
        },
        child: Icon(Icons.calendar_today),
      ),
    ),
    );
  }

   Future<Null> refreshList() async{
    getOrderList("${selectedDate?.month}","${selectedDate?.year}");
  }

  void removeItem(int index) {
    setState(() {
      globals.cartItems = List.from(globals.cartItems)..removeAt(index);
    });
  }

}
