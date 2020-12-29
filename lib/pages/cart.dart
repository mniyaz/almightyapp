import 'dart:convert';
import 'dart:io';

import 'package:almighty/models/contact_model.dart';
import 'package:almighty/models/items_model.dart';
import 'package:almighty/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:almighty/globals.dart' as globals;
import '../cards/cart_card.dart';

class CartPage extends StatefulWidget {

  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
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
      body: InkWell(
    onTap: () {


      FocusScope.of(context).unfocus();
    },
    child: globals.cartItems != null && globals.cartItems.length != 0 ? Column(
        children:[
          Expanded(
        child:  ListView.builder(
        itemCount: globals.cartItems.length,
        itemBuilder: (context, i) {
          final item = globals.cartItems[i];
          return CartCard(key: ObjectKey(item) ,product: globals.cartItems[i],onDelete: () => deleteItem(item), onChange: () => updateCartTotal(i),);
        },
      ) ,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              new Text("Total : \u20B9"+globals.order.grandTotal),

              new RaisedButton(
                onPressed: (){
                  showCheckoutDialog();
                },
                textColor: Colors.white,
                color: Colors.green,
                padding: const EdgeInsets.all(8.0),
                child: new Text(
                  "Checkout",
                ),
              ),
            ],
          )
  ])  : new Container(
        alignment: Alignment.center,
    child: Text("No items in Cart.")
    )
    ));
  }
  void deleteItem(Items item){
    globals.cartItems.remove(item);
    setState(() {
      updateTotal();
    });
  }
  void updateCartTotal(index){
    setState(() {
      updateTotal();
    });
  }

  showCheckoutDialog() {
    AwesomeDialog(
      context: this.context,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Confirm Order',
      desc: "",
      btnOkOnPress: () {
        callCheckout();
      },
    )..show();
  }

  callCheckout() async{
    String url =
        'https://almightysnk.com/rest/ordercontroller/createOrder';
      globals.order.orderStatus = "Order Placed";
      globals.order.tmpOrderId = "9952515251202012291917";
      Contact contact = Contact();
      contact.authKey = "-1689287759";
      contact.contactId = 48;
      globals.order.contact = contact;
      Map orderJson = globals.order.toJson();

  }

  Future<String> apiRequest(String url, Map orderJson) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(orderJson)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    print(reply);
    return reply;
  }

  void updateTotal(){
    int total = globals.cartItems.fold(0, (sum, item) => sum + int.parse(item.rowTotal));
    globals.order.totalPriceBeforeTax = total.toString();
    globals.order.grandTotal = total.toString();
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