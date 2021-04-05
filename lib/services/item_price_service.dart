import 'package:almighty/models/items_model.dart';
import 'package:almighty/models/product.dart';
import 'package:almighty/globals.dart' as globals;

import 'dart:convert';

import 'package:flutter/material.dart';

class ItemPriceService {
  static String getProductPrice(int qtyValue, Product product) {
    String itemPrice = "0";
    if (qtyValue == 1) {
      itemPrice = product.prices[0].price.toString();
    } else {
      product.prices.forEach((price) {
        if ((price.lessThan >= qtyValue || price.lessThan == 0) &&
            qtyValue > price.greaterThan) {
          itemPrice = price.price.toString();
        }
      });
    }
    return itemPrice;
  }

  static String getItemPrice(int qtyValue, Items item) {
    Product product = globals.products
        .where((product) => product.itemName == item.productName)
        .first;
    String itemPrice;
    if (qtyValue == 1) {
      itemPrice = product.prices[0].price.toString();
    } else {
      product.prices.forEach((price) {
        if ((price.lessThan >= qtyValue || price.lessThan == 0) &&
            qtyValue > price.greaterThan) {
          itemPrice = price.price.toString();
        }
      });
    }
    return itemPrice;
  }
}
