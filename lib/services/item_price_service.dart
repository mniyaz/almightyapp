import 'package:almighty/models/items_model.dart';
import 'package:almighty/models/product.dart';
import 'package:almighty/globals.dart' as globals;

class ItemPriceService {
  static String getProductPrice(int qtyValue, Product product) {
    String itemPrice;
    if (qtyValue < 10) {
      itemPrice = product.itemPrice;
    } else if (qtyValue >= 10 && qtyValue < 25) {
      itemPrice = product.itemPrice10To25;
    } else if (qtyValue >= 25 && qtyValue <= 50) {
      itemPrice = product.itemPriceAbove25;
    } else if (qtyValue > 50) {
      itemPrice = product.itemPriceBag;
    }
    return itemPrice;
  }

  static String getItemPrice(int qtyValue, Items item) {
    Product product = globals.products
        .where((product) => product.itemName == item.productName)
        .first;
    String itemPrice;
    if (qtyValue < 10) {
      itemPrice = product.itemPrice;
    } else if (qtyValue >= 10 && qtyValue < 25) {
      itemPrice = product.itemPrice10To25;
    } else if (qtyValue >= 25 && qtyValue <= 50) {
      itemPrice = product.itemPriceAbove25;
    } else if (qtyValue > 50) {
      itemPrice = product.itemPriceBag;
    }
    return itemPrice;
  }
}
