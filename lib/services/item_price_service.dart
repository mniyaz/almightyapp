import 'package:almighty/models/items_model.dart';
import 'package:almighty/models/product.dart';
import 'package:almighty/globals.dart' as globals;

class ItemPriceService {
  static String getProductPrice(int qtyValue, Product product) {
    String itemPrice;
    print(product.prices);
    product.prices.forEach((price) => {
      
          if (price.greaterThan < qtyValue && qtyValue > price.lessThan)
            {itemPrice = price.price.toString()}
        });
    print(itemPrice);
    return itemPrice;
  }

  static String getItemPrice(int qtyValue, Items item) {
    Product product = globals.products
        .where((product) => product.itemName == item.productName)
        .first;
    String itemPrice;
    product.prices.map((price) => {
          if (price.lessThan < qtyValue && qtyValue > price.greaterThan)
            {itemPrice = price.price.toString()}
        });
    return itemPrice;
  }
}
