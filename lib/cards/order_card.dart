import 'package:almighty/models/items_model.dart';
import 'package:almighty/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:intl/intl.dart';

class OrderCard extends StatefulWidget {
  final Order order;
  final VoidCallback onDelete;

  OrderCard(this.order, {this.onDelete});

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
      child: Column(children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8.0),
          color: Color(0xffeceff0),
          child: Column (
            children : [Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(10.0),
                child: Text(
                    order.orderId.toString(),
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
                child: Text(
                    order.orderStatus,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ],
          ),
              Row(
                children: [

                  Text(
                    f.format(order.orderCreatedTime),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              )
          ])
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
                        label: Text("Item")
                    ),
                    DataColumn(
                        label: Text("Qty")
                    ),
                    DataColumn(
                        label: Text("Price")
                    ),
                  ],
                  rows: order.items.map((item) =>
                        DataRow(
                      cells: [
                        DataCell(
                          Container(
                            child: Text(
                              item.productName,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            child: Text(
                              item.qty.toString(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            child: Text(
                              item.rowTotal,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                      ).toList()
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