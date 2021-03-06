import 'package:almighty/models/items_model.dart';
import 'package:almighty/models/order_model.dart';
import 'package:almighty/models/price_model.dart';
import 'package:almighty/services/item_price_service.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../models/product.dart';

import '../globals.dart' as globals;

class ProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback onAdd;

  const ProductCard({Key key, this.product, this.onAdd}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProductCardState(product);
  }
}

class ProductCardState extends State<ProductCard> {
  Product product;
  String renderUrl;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = "0"; // Setting the initial value for the field.
  }

  int _currentValue = 1;

  _openPopup(context, Product product) {
    _controller.text = "0";
    if (product.itemUnitType == null) product.itemUnitType = "UNIT";
    Alert(
        context: context,
        title: product.itemUnitType == "KG"
            ? "Pick your Weight"
            : "Pick your Quantity",
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                product.itemName,
                style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w500),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              child: Text(
                product.itemDescription != null ? product.itemDescription : "",
                style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w900),
                textAlign: TextAlign.left,
              ),
            ),
            SpinBox(
              min: 1,
              max: 10000,
              value: 0,
              showCursor: false,
              onChanged: (value) {
                setState(() {
                  _currentValue = value.toInt();
                  _controller.text = _currentValue.toString();
                });
              },
            ),
            TextField(
              controller: _controller,
              enabled: false,
              decoration: InputDecoration(
                //icon: Icon(Icons.line_weight),
                labelText: product.itemUnitType == "KG" ? "Weight" : "Unit",
              ),
            ),
            product.prices != null && product.prices.length > 0
                ? Container(
                    child: DataTable(
                        columns: [
                          DataColumn(label: Text(product.itemUnitType)),
                          DataColumn(label: Text("Price")),
                        ],
                        rows: product.prices
                            .map(
                              (price) => DataRow(
                                cells: [
                                  DataCell(
                                    Container(
                                      child: Text(
                                        price.lessThan == 0
                                            ? price.greaterThan.toString() +
                                                ' & ' +
                                                "Above"
                                            : price.greaterThan.toString() +
                                                ' - ' +
                                                price.lessThan.toString(),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Container(
                                      child: Text(
                                        "\u20B9" + price.price.toString(),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList()),
                  )
                : Container(
                    width: double.infinity,
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text("Price")),
                        DataColumn(
                            label: Text(product.itemPrice != null
                                ? "\u20B9" + product.itemPrice
                                : "\u20B9" + "0")),
                      ],
                      rows: [],
                    ),
                  ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              if (_controller.text != "0") {
                Navigator.pop(context);

                Items item = new Items();
                item.productName = product.itemName;

                item.qty = int.parse(_controller.text);

                if (product.prices != null &&
                    product.prices.length > 0) {
                  item.price =
                      ItemPriceService.getProductPrice(_currentValue, product);
                } else {
                  item.price = product.itemPrice;
                }
                if (product.itemUnitType == null ||
                    product.itemUnitType == "null" ||
                    product.itemUnitType == "")
                  item.UOM = "UNIT";
                else
                  item.UOM = product.itemUnitType;
                item.rowTotal =
                    (int.parse(_controller.text) * double.parse(item.price))
                        .toInt()
                        .toString();

                if (globals.cartItems == null) {
                  globals.cartItems = new List();
                }
                globals.cartItems.add(item);

                if (globals.order == null) globals.order = new Order();

                globals.order.items = globals.cartItems;

                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(_controller.text +
                      product.itemUnitType +
                      "s of " +
                      product.itemName +
                      " Added to Cart."),
                ));

                widget.onAdd();
              } else {
                Fluttertoast.showToast(
                    msg: "Select Quantity!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            },
            child: Text(
              "Add to Cart",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          )
        ]).show();
  }

  ProductCardState(this.product);

  Widget get inventoryCard {
    return new Card(
      child: Column(children: <Widget>[
        Container(
          padding: const EdgeInsets.all(2.0),
          color: Color(0xffeceff0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    product.itemName,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    product.itemPriceRaised
                        ? Icon(
                            Icons.arrow_drop_up,
                            color: Colors.green,
                            size: 38.0,
                          )
                        : Icon(
                            Icons.arrow_drop_down,
                            color: Colors.red,
                            size: 38.0,
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0, 15, 5, 0),
                child: Text(
                  product.prices != null && product.prices.length > 0
                      ? "\u20B9" +
                          " " +
                          product.prices[product.prices.length - 1].price
                              .toString() +
                          " Onwards"
                      : product.itemPrice != null
                          ? "\u20B9" + product.itemPrice
                          : "\u20B9" + "0",
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(child: Container()),
              Container(
                child: MaterialButton(
                  height: 35.0,
                  minWidth: 45.0,
                  color: Color(0xFF00b447),
                  child: new Text(
                    'Add'.toUpperCase(),
                    style: new TextStyle(
                      fontSize: 12.0,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    _openPopup(context, product);
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
      margin: const EdgeInsets.all(5.0),
    );
  }

  showURLDialog(windowurl) {
    AwesomeDialog(
      context: this.context,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Window URL',
      desc: windowurl,
      btnOkOnPress: () {},
    )..show();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: inventoryCard,
    );
  }
}
