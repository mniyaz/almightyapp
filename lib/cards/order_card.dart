import 'package:almighty/models/items_model.dart';
import 'package:almighty/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:intl/intl.dart';

class OrderCard extends StatefulWidget {
  final Order order;

  const OrderCard({Key key, this.order}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return OrderCardState(order);
  }
}

class OrderCardState extends State<OrderCard> {
  Order order;

  @override
  void initState() {
    super.initState();
  }

  final f = new DateFormat('yyyy-MM-dd');

  OrderCardState(this.order);

  Widget get inventoryCard {
    return new Card(
      child: Column(
        children: <Widget>[
          Container(
              padding: const EdgeInsets.all(8.0),
              color: Color(0xffeceff0),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text("Order No : " + order.orderId.toString(),
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
                      child: Text(order.orderStatus,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        padding: EdgeInsets.only(top: 5.0),
                        alignment: Alignment.centerRight,
                        child: Text(
                            "Placed on :" +
                                " " +
                                f.format(order.orderCreatedTime),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 14,
                            ))),
                    Expanded(
                      child: new Container(),
                    ),
                    Container(
                        alignment: Alignment.centerRight,
                        child: Text("Total : \u20B9" + " " + order.GrandTotal,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 14,
                            ))),
                  ],
                )
              ])),
          Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                child: DataTable(
                    columnSpacing: 15.0,
                    columns: [
                      DataColumn(label: Text("Item")),
                      DataColumn(label: Text("Qty")),
                      DataColumn(label: Text("Price")),
                    ],
                    rows: order.items
                        .map(
                          (item) => DataRow(
                            cells: [
                              DataCell(
                                Container(
                                  width: 100,
                                  child: new Tooltip(
                                    message: item.productName,
                                    child: Text(
                                      item.productName,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(
                                Container(
                                  child: Text(
                                    item.qty.toString(),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ),
                              DataCell(
                                Container(
                                  child: Text(
                                    "\u20B9" + " " + item.rowTotal,
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList()),
              ),
            ],
          ),
        ],
      ),
      margin: const EdgeInsets.all(5.0),
    );
  }

  showURLDialog(windowurl) {
    AwesomeDialog(
      context: this.context,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Info',
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
