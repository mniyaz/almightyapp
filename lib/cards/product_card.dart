import 'package:almighty/models/items_model.dart';
import 'package:almighty/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../models/product.dart';

import '../globals.dart' as globals;


class ProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback onAdd;

  ProductCard(this.product, {this.onAdd});

  @override
  State<StatefulWidget> createState() {
    return ProductCardState(product);
  }
}

class ProductCardState extends State<ProductCard> {
  Product product;
  String renderUrl;
  TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller.text = "1"; // Setting the initial value for the field.
  }

  int _currentValue = 1;

  _openPopup(context,Product product) {
    Alert(
        context: context,
        title: "Pick your Weight",
        content: Column(
          children: <Widget>[
            Text(product.itemName
            ),
            SpinBox(
              min: 1,
              max: 1000,
              value: 1,
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
              decoration: InputDecoration(
                icon: Icon(Icons.line_weight),
                labelText: 'Weight',
              ),
            ),

            product.itemPriceBag != null && product.itemPriceBag != "0" ? DataTable(columns: [
                  DataColumn(label: Text("Weight(KGs)")),
                DataColumn(label: Text("Price")),
                    ], rows: [
                  DataRow(
                    cells: [
                      DataCell(
                        Container(
                          child: Text(
                            "2.5 To 9.99",
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      DataCell(
                        Container(
                          child: Text(
                            product.itemPrice,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
              DataRow(
                cells: [
                  DataCell(
                    Container(
                      child: Text(
                        "10 To 25",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  DataCell(
                    Container(
                      child: Text(
                        product.itemPrice10To25,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(
                    Container(
                      child: Text(
                        "Above 25",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  DataCell(
                    Container(
                      child: Text(
                        product.itemPriceAbove25,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(
                    Container(
                      child: Text(
                        "Above 50",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  DataCell(
                    Container(
                      child: Text(
                        product.itemPriceBag,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
                ]) : DataTable(columns: [
              DataColumn(label: Text("Price")),
              DataColumn(label: Text(product.itemPrice)),
            ],rows :[],),
              ],
            ),

        buttons: [
          DialogButton(
            onPressed: () {
              Navigator.pop(context);

              Items item = new Items();
              item.productName = product.itemName;

              item.qty = int.parse(_controller.text);

              if(product.itemPriceBag != null && product.itemPriceBag != "0") {
                if (_currentValue < 10) {
                  item.price = product.itemPrice;
                } else if (_currentValue >=10 && _currentValue < 25) {
                  item.price = product.itemPrice10To25;
                }else if (_currentValue >=25 && _currentValue < 50) {
                  item.price = product.itemPriceAbove25;
                }else if (_currentValue >50) {
                  item.price = product.itemPriceBag;
                }
              }else{item.price = product.itemPrice;}


              item.rowTotal = (int.parse(_controller.text) * double.parse(item.price)).toInt().toString();

              if(globals.cartItems == null) {
                globals.cartItems = new List();
              }
              globals.cartItems.add(item);

              if(globals.order == null)
                globals.order = new Order();

              globals.order.items = globals.cartItems;

              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(_controller.text + "KGs of " +product.itemName + " Added to Cart."),
              ));

                widget.onAdd();

            } ,
            child: Text(
              "Add to Cart",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  ProductCardState(this.product);

  Widget get inventoryCard {
    return new Card(
      child: Column(children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8.0),
          color: Color(0xffeceff0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(10.0),
                child: Text(
                     product.itemName,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Expanded(
                child: new Container(),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  product.itemPriceRaised ? Icons.arrow_upward : Icons.arrow_downward,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                DataTable(
                  headingRowHeight : 0.0,
                  dividerThickness: 0.0,
                  columns: [
                    DataColumn(
                      label: Text("")
                    ),
                    DataColumn(
                      label: Text("")
                    ),
                  ],
                  rows: [
                    DataRow(
                      cells: [
                        DataCell(
                          Container(
                            child: Text(
                              product.itemPriceBag != null ? product.itemPriceBag  + " To " + product.itemPrice : product.itemPrice,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        DataCell(
                          MaterialButton(
                            height: 35,
                            color: Color(0xFF1e7e34),
                            child: new Text(
                              'Add',
                              style: new TextStyle(
                                fontSize: 12.0,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              _openPopup(context,product);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ]),
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