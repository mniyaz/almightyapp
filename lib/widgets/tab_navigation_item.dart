import 'package:flutter/material.dart';
import 'package:almighty/pages/cart.dart';
import 'package:almighty/pages/home.dart';
import 'package:almighty/pages/order_history.dart';
import 'package:flutter/widgets.dart';

class TabNavigationItem {
  final Widget page;
  final Icon icon;

  TabNavigationItem({
    @required this.page,
    @required this.icon,
  });

  static List<TabNavigationItem> get items => [
    TabNavigationItem(
      page: HomePage(),
      icon: Icon(Icons.home),
    ),
    TabNavigationItem(
      page: CartPage(),
      icon: Icon(Icons.shopping_cart),
    ),
    TabNavigationItem(
      page: OrderHistoryPage(),
      icon: Icon(Icons.history),
    ),
  ];
}
