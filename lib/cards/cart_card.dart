import 'package:almighty/models/items_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

import 'package:almighty/globals.dart' as globals;

class CartCard extends StatefulWidget {
  final Items product;
  final VoidCallback onDelete;
  final VoidCallback onChange;


  CartCard(this.product, {this.onDelete, this.onChange});

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
    return new Card(
      child: Column(children: <Widget>[
        Container(

          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child:
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
                    width: 100,
                         child: new Tooltip(message: product.productName, child:Text(
                              product.productName,
                              overflow: TextOverflow.ellipsis,
                            ),)
            )
                        ),
                        DataCell(
                          Container(
                            width: 120,
                            child:  SpinBox(
                              min: 1,
                              max: 1000,
                              textStyle: TextStyle(fontSize: 13),
                              value: product.qty.toDouble(),
                              showCursor: true,
                              onChanged: (value) {
                                  product.qty = value.toInt();
                                  setState(() {
                                        product.rowTotal = (product.qty * double.parse(product.price)).toInt().toString();
                                  });
                                  widget.onChange();
                              },
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                              "\u20B9"+product.rowTotal,textScaleFactor: 1,
                              overflow: TextOverflow.ellipsis,
                            ),

                        ),
                        DataCell(
                          Container(
                            width: 30,
                            child: new IconButton(
                              icon: Icon(
                                Icons.delete,
                              ),
                              onPressed: (){
                                widget.onDelete();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            )),
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