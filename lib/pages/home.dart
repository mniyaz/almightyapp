import 'package:almighty/pages/cart.dart';
import 'package:almighty/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';
import '../cards/product_card.dart';
import 'package:almighty/globals.dart' as globals;
import 'package:almighty/services/local_data_service.dart';

import 'dart:convert';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  TextEditingController controller = new TextEditingController();
  List<Product> productList;
  List<Product> productListFromApi = List<Product>();
  List<Product> searchResult;
  Future<Null> getProductList() async {
    final String mobileNumber =
        await LocalService.getMobile(globals.CONTACT_KEY);
    final response = await http.get(
        "https://almightysnk.com/rest/productcontroller/getlist/" +
            mobileNumber);
    final responseJson = json.decode(response.body);
    productListFromApi =
        (responseJson as List).map((i) => Product.fromJson(i)).toList();
    if (productList == null)
      productList = List<Product>();
    else
      productList.clear();
    setState(() {});
  }

  bool _showProgress = false;
  @override
  void initState() {
    super.initState();
    _showProgress = false;
    getProductList();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //showDialog(context: context);
      showDialog(
          context: context,
          child: new MyDialogDemo(
            onValueChange: _onValueChange,
            initialValue: _selectedId,
          ));
    });
  }

  List<String> categoryList = [
    globals.CATEGORY_FLOUR,
    globals.CATEGORY_GRAINS,
    globals.CATEGORY_MASALA_POWDER,
    globals.CATEGORY_NUTS_SEEDS,
    globals.CATEGORY_OIL,
    globals.CATEGORY_PULSES,
    globals.CATEGORY_RICE,
    globals.CATEGORY_SPICES,
    globals.CATEGORY_OTHERS,
  ];
  List<String> selectedCategoryList = [];
  String _selectedId = "";
  selectCategory(String category) {
    print("Category : " + category);
    productList.clear();
    productListFromApi.sort((a, b) => a.itemName.compareTo(b.itemName));
    setState(() {
      productList.addAll(productListFromApi
          .where((product) => product.category == category)
          .toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                'assets/images/AlmightyLogo.png',
                fit: BoxFit.contain,
                height: 25,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Text('Almighty e-shop'),
            ),
          ],
        ),
        brightness: Brightness.dark,
        actions: <Widget>[
          new Container(
            // padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: new Stack(
              children: <Widget>[
                Container(
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => CartPage()));
                    },
                  ),
                ),
                globals.cartItems == null || globals.cartItems.length == 0
                    ? new Container()
                    : new Positioned(
                        child: new Stack(
                        children: <Widget>[
                          new Icon(
                            Icons.brightness_1,
                            size: 20.0,
                            color: Color(0xFFfa881c),
                          ),
                          new Positioned(
                              top: 4.0,
                              right: 6.0,
                              child: new Center(
                                child: new Text(
                                  globals.cartItems.length.toString(),
                                  style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              )),
                        ],
                      )),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: new Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(1.0),
              margin: EdgeInsets.all(4.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: controller,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color(0xFFfa881c),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)))),
              ),
            ),
            Container(
              height: 20,
              child:
                  ListView(scrollDirection: Axis.horizontal, children: <Widget>[
                Row(children: <Widget>[
                  new RichText(
                    text: new TextSpan(
                      // Note: Styles for TextSpans must be explicitly defined.
                      // Child text spans will inherit styles from parent
                      style: new TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        new TextSpan(
                            text: 'Filter:',
                            style: new TextStyle(fontWeight: FontWeight.bold)),
                        new TextSpan(text: " " + _selectedId),
                      ],
                    ),
                  ),
                ]),
              ]),
            ),
            new Expanded(
              child: productList != null && productList.length > 0
                  ? RefreshIndicator(
                      child: new ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.only(bottom: 56),
                          itemCount: productList.length,
                          itemBuilder: (context, index) {
                            final item = productList[index];
                            return ProductCard(
                                key: ObjectKey(item),
                                product: productList[index],
                                onAdd: () => updateCart(index));
                          }),
                      onRefresh: getProductList,
                    )
                  : Center(
                      child: Column(children: <Widget>[
                      Text("No data found for selected Filter"),
                      RaisedButton(
                          child: Text(
                            "Refresh",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _showProgress = true;
                            });
                            getProductList();
                            setState(() {
                              _showProgress = false;
                            });
                          }),
                      _showProgress
                          ? CircularProgressIndicator()
                          : new Container(),
                    ])),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "tag1",
        onPressed: () {
          showDialog(
              context: context,
              child: new MyDialogDemo(
                onValueChange: _onValueChange,
                initialValue: _selectedId,
              ));
        },
        tooltip: 'Category',
        child: Icon(
          Icons.category,
          color: Colors.white,
        ),
      ),
      drawer: navigationDrawer(),
    );
  }

  void filterSearchResults(String query) {
    List<Product> dummySearchList = List<Product>();
    dummySearchList.addAll(productListFromApi);
    if (query.isNotEmpty) {
      List<Product> dummyListData = List<Product>();
      dummySearchList.forEach((item) {
        if (item.itemName.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      productList.clear();
      setState(() {
        productList.addAll(dummyListData);
      });
      return;
    } else {
      productList.clear();
      setState(() {
        productList.addAll(productListFromApi);
      });
    }
  }

  void updateCart(index) {
    setState(() {
      int total = globals.cartItems
          .fold(0, (sum, item) => sum + int.parse(item.rowTotal));
      globals.order.totalPriceBeforeTax = total.toString();
      globals.order.GrandTotal = total.toString();
    });
  }

  onSearchTextChanged(String text) async {
    text = text.toLowerCase();
    if (searchResult != null) searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    productList.forEach((product) {
      if (product.itemName.toLowerCase().contains(text)) {
        if (searchResult == null) searchResult = List();
        searchResult.add(product);
      }

      setState(() {});
    });

    setState(() {});
  }

  void _onValueChange(String value) {
    productList.clear();
    if (value != globals.CATEGORY_ALL)
      productList.addAll(productListFromApi
          .where((product) => product.category == value)
          .toList());
    else
      productList.addAll(productListFromApi);
    setState(() {
      _selectedId = value;
      productList
          .sort((a, b) => a.itemName.trim().compareTo(b.itemName.trim()));
    });
  }
}

class MyDialogDemo extends StatefulWidget {
  const MyDialogDemo({this.onValueChange, this.initialValue});
  final String initialValue;
  final void Function(String) onValueChange;

  @override
  _MyDialogDemoState createState() => new _MyDialogDemoState();
}

class _MyDialogDemoState extends State<MyDialogDemo> {
  String _selectedId;
  @override
  void initState() {
    super.initState();
    _selectedId = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return new SimpleDialog(
      title: new Text("Select Category"),
      children: <Widget>[
        new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/flour.png",
                    fit: BoxFit.contain,
                    height: 35.0,
                  ),
                ),
                Container(
                  child: Radio(
                    value: 0,
                    groupValue: "_radioValue1",
                    onChanged: (void nothing) {
                      Navigator.pop(context);
                      widget.onValueChange(globals.CATEGORY_FLOUR);
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    globals.CATEGORY_FLOUR,
                    style: new TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/grains.png',
                    fit: BoxFit.contain,
                    height: 35.0,
                  ),
                ),
                Container(
                  child: Radio(
                    value: 0,
                    groupValue: "_radioValue1",
                    onChanged: (void nothing) {
                      Navigator.pop(context);
                      widget.onValueChange(globals.CATEGORY_GRAINS);
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    globals.CATEGORY_GRAINS,
                    style: new TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    'assets/images/masala.png',
                    fit: BoxFit.contain,
                    height: 35.0,
                  ),
                ),
                Container(
                  child: Radio(
                    value: 0,
                    groupValue: "_radioValue1",
                    onChanged: (void nothing) {
                      Navigator.pop(context);
                      widget.onValueChange(globals.CATEGORY_MASALA_POWDER);
                    },
                  ),
                ),
                Container(
                  child: Text(
                    globals.CATEGORY_MASALA_POWDER,
                    style: new TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ],
        ),
        new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Row(children: [
              Container(
                padding: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  'assets/images/nuts.png',
                  fit: BoxFit.contain,
                  height: 35.0,
                ),
              ),
              new Radio(
                value: 0,
                groupValue: "_radioValue1",
                onChanged: (void nothing) {
                  Navigator.pop(context);
                  widget.onValueChange(globals.CATEGORY_NUTS_SEEDS);
                },
              ),
              new Text(
                globals.CATEGORY_NUTS_SEEDS,
                style: new TextStyle(fontSize: 16.0),
              ),
            ]),
            new Row(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    'assets/images/oil.png',
                    fit: BoxFit.contain,
                    height: 35.0,
                  ),
                ),
                new Radio(
                  value: 0,
                  groupValue: "_radioValue1",
                  onChanged: (void nothing) {
                    Navigator.pop(context);
                    widget.onValueChange(globals.CATEGORY_OIL);
                  },
                ),
                new Text(
                  globals.CATEGORY_OIL,
                  style: new TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            new Row(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    'assets/images/pulses.png',
                    fit: BoxFit.contain,
                    height: 35.0,
                  ),
                ),
                new Radio(
                  value: 0,
                  groupValue: "_radioValue1",
                  onChanged: (void nothing) {
                    Navigator.pop(context);
                    widget.onValueChange(globals.CATEGORY_PULSES);
                  },
                ),
                new Text(
                  globals.CATEGORY_PULSES,
                  style: new TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ],
        ),
        new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Row(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    'assets/images/rice.png',
                    fit: BoxFit.contain,
                    height: 35.0,
                  ),
                ),
                new Radio(
                  value: 0,
                  groupValue: "_radioValue1",
                  onChanged: (void nothing) {
                    Navigator.pop(context);
                    widget.onValueChange(globals.CATEGORY_RICE);
                  },
                ),
                new Text(
                  globals.CATEGORY_RICE,
                  style: new TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            new Row(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    'assets/images/spices.png',
                    fit: BoxFit.contain,
                    height: 35.0,
                  ),
                ),
                new Radio(
                  value: 0,
                  groupValue: "_radioValue1",
                  onChanged: (void nothing) {
                    Navigator.pop(context);
                    widget.onValueChange(globals.CATEGORY_SPICES);
                  },
                ),
                new Text(
                  globals.CATEGORY_SPICES,
                  style: new TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            new Row(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    'assets/images/others.png',
                    fit: BoxFit.contain,
                    height: 35.0,
                  ),
                ),
                new Radio(
                  value: 0,
                  groupValue: "_radioValue1",
                  onChanged: (void nothing) {
                    Navigator.pop(context);
                    widget.onValueChange(globals.CATEGORY_OTHERS);
                  },
                ),
                new Text(
                  globals.CATEGORY_OTHERS,
                  style: new TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ],
        ),
        new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Row(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'assets/images/all.png',
                    fit: BoxFit.contain,
                    height: 35.0,
                  ),
                ),
                new Radio(
                  value: 0,
                  groupValue: "_radioValue1",
                  onChanged: (void nothing) {
                    Navigator.pop(context);
                    widget.onValueChange(globals.CATEGORY_ALL);
                  },
                ),
                new Text(
                  globals.CATEGORY_ALL,
                  style: new TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
