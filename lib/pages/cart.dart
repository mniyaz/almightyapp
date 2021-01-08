import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:almighty/models/contact_model.dart';
import 'package:almighty/models/items_model.dart';
import 'package:almighty/services/local_data_service.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;

import 'package:almighty/globals.dart' as globals;
import '../cards/cart_card.dart';

class CartPage extends StatefulWidget {
  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          centerTitle: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/AlmightyLogo.png',
                fit: BoxFit.contain,
                height: 25,
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Text('Almighty e-shop'),
              ),
            ],
          ),
          automaticallyImplyLeading: false,
        ),
        body: _loading
            ? bodyProgress
            : InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child:
                    globals.cartItems != null && globals.cartItems.length != 0
                        ? Column(children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: globals.cartItems.length,
                                itemBuilder: (context, i) {
                                  final item = globals.cartItems[i];
                                  return CartCard(
                                    key: ObjectKey(item),
                                    product: globals.cartItems[i],
                                    onDelete: () => deleteItem(item),
                                    onChange: () => updateCartTotal(i),
                                  );
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    "Total : \u20B9" +
                                        " " +
                                        globals.order.GrandTotal,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Expanded(child: Container()),
                                Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: RaisedButton(
                                    onPressed: () {
                                      showCheckoutDialog();
                                    },
                                    textColor: Colors.white,
                                    color: Color(0xFF00b447),
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Text(
                                      "Checkout",
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ])
                        : new Container(
                            alignment: Alignment.center,
                            child: Text("No items in Cart."))));
  }

  void deleteItem(Items item) {
    globals.cartItems.remove(item);
    setState(() {
      updateTotal();
    });
  }

  void updateCartTotal(index) {
    setState(() {
      updateTotal();
    });
  }

  Future<Null> checkIfOrderCreated(String tmpOrderId) async {
    final mobile = await LocalService.getMobile(globals.CONTACT_KEY);
    final authKey = await LocalService.getAuthKey(globals.AUTH_KEY);
    final response = await http.get(
        "https://almightysnk.com/rest/ordercontroller/checkIfOrderCreated/" +
            tmpOrderId +
            "/" +
            mobile +
            "/" +
            authKey);
    final responseJson = json.decode(response.body);
    isStopped = responseJson["ordersuccess"] as bool;
  }

  showCheckoutDialog() {
    AwesomeDialog(
      context: this.context,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Confirm Order',
      desc: "",
      btnOkOnPress: () {
        setState(() {
          _loading = true;
        });
        callCheckout();
        sec5Timer();
      },
    )..show();
  }

  callCheckout() async {
    String url = 'https://almightysnk.com/rest/ordercontroller/createOrder';
    globals.order.orderStatus = "Order Placed";

    final Contact contact = await LocalService.getContact(globals.CONTACT_KEY);
    final authKey = await LocalService.getAuthKey(globals.AUTH_KEY);
    globals.order.tmpOrderId = contact.contactMobile +
        DateTime.now().millisecondsSinceEpoch.toString();
    contact.authKey = authKey;
    globals.order.contact = contact;

    Map orderJson = globals.order.toJson();
    orderJson.remove("orderId");
    orderJson.remove("CGST");
    orderJson.remove("SGST");
    orderJson.remove("IGST");
    orderJson.remove("CGSTPercentage");
    orderJson.remove("SGSTPercentage");
    orderJson.remove("IGSTPercentage");
    orderJson.remove("paid");
    orderJson.remove("paidDate");
    orderJson.remove("orderCreatedTime");
    orderJson.forEach((key, value) {
      if (value is Map) {
        value.removeWhere((key, value) => key == "cartId");
        value.removeWhere((key, value) => key == "CGSTPercentage");
        value.removeWhere((key, value) => key == "SGSTPercentage");
        value.removeWhere((key, value) => key == "IGSTPercentage");
      }
    });
    apiRequest(url, orderJson);
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
    return reply;
  }

  void updateTotal() {
    int total = globals.cartItems
        .fold(0, (sum, item) => sum + int.parse(item.rowTotal));
    globals.order.totalPriceBeforeTax = total.toString();
    globals.order.GrandTotal = total.toString();
  }

  bool isStopped = false; //global

  int checkCount = 0;
  sec5Timer() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      if (isStopped) {
        timer.cancel();
        setState(() {
          _loading = false;
          globals.order.items.clear();
        });
        isStopped = false;
        checkCount = 0;
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Order created successfully!"),
        ));
      } else if (checkCount == 4) {
        timer.cancel();
        setState(() {
          _loading = false;
        });
        checkCount = 0;
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Unable to place new order. Try again later!"),
        ));
      }
      checkCount++;
      checkIfOrderCreated(globals.order.tmpOrderId);
    });
  }

  var bodyProgress = new Container(
    child: new Stack(
      children: <Widget>[
        new Container(
          alignment: AlignmentDirectional.center,
          decoration: new BoxDecoration(
            color: Colors.white70,
          ),
          child: new Container(
            decoration: new BoxDecoration(
                color: Colors.blue[200],
                borderRadius: new BorderRadius.circular(10.0)),
            width: 300.0,
            height: 200.0,
            alignment: AlignmentDirectional.center,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Center(
                  child: new SizedBox(
                    height: 50.0,
                    width: 50.0,
                    child: new CircularProgressIndicator(
                      value: null,
                      strokeWidth: 7.0,
                    ),
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.only(top: 25.0),
                  child: new Center(
                    child: new Text(
                      "trying to place your order...",
                      style: new TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
