import 'package:almighty/models/items_model.dart';
import 'package:flutter/material.dart';

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

    });
  }
  void updateCartTotal(index){
    setState(() {
      updateTotal();
    });
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