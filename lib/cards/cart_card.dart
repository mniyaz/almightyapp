import 'package:almighty/models/items_model.dart';
import 'package:almighty/services/item_price_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

import 'package:almighty/globals.dart' as globals;

class CartCard extends StatefulWidget {
  final Items product;
  final VoidCallback onDelete;
  final VoidCallback onChange;

  const CartCard({Key key, this.product, this.onDelete, this.onChange})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CartCardState(product);
  }
}

class CartCardState extends State<CartCard> {
  Items product;

  @override
  void initState() {
    super.initState();
  }

  CartCardState(this.product);

  Widget get inventoryCard {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
                padding: EdgeInsets.all(5.0),
                alignment: Alignment.centerLeft,
                child: new Tooltip(
                  message: product.productName,
                  child: Text(
                    product.productName,
                    style: TextStyle(fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                width: double.infinity,
                child: DataTable(
                  columnSpacing: 15.0,
                  headingRowHeight: 0.0,
                  dividerThickness: 0.0,
                  showBottomBorder: false,
                  columns: [
                    DataColumn(label: Text("")),
                    DataColumn(label: Text("")),
                    DataColumn(label: Text("")),
                  ],
                  rows: [
                    DataRow(
                      cells: [
                        DataCell(
                          Container(
                            width: 140.0,
                            padding: EdgeInsets.all(0.0),
                            child: SpinBox(
                              min: 1,
                              max: 1000,
                              value: product.qty.toDouble(),
                              showCursor: true,
                              onChanged: (value) {
                                product.qty = value.toInt();
                                setState(() {
                                  product.rowTotal = (product.qty *
                                          double.parse(
                                              ItemPriceService.getItemPrice(
                                                  product.qty, product)))
                                      .toInt()
                                      .toString();
                                });
                                widget.onChange();
                              },
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            width: 100.0,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.all(0.0),
                            child: Text(
                              "\u20B9" + " " + product.rowTotal,
                              textScaleFactor: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            width: 40.0,
                            padding: EdgeInsets.all(0.0),
                            alignment: Alignment.centerRight,
                            child: new IconButton(
                              icon: Icon(
                                Icons.delete,
                              ),
                              onPressed: () {
                                widget.onDelete();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
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
