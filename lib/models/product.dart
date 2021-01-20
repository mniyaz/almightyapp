class Product {
  int itemId;
  String itemCode;
  String itemName;
  String itemPrice;
  String itemUnitType;
  String itemDescription;
  String category;
  bool itemActive;
  bool itemPriceRaised;
  String itemPreviousPrice;
  String itemPriceBag;
  String itemPriceAbove25;
  String itemPrice10To25;
  String itemPrice2P5To9P99;
  bool itemPriceRaisedBag;
  String itemPreviousPriceBag;
  bool itemPriceRaisedAbove25;
  String itemPreviousPriceAbove25;
  bool itemPriceRaised10To25;
  String itemPreviousPrice10To25;
  bool itemPriceRaised2P5To9P99;
  String itemPreviousPrice2P5To9P99;

  Product(
      {this.itemId,
        this.itemCode,
        this.itemName,
        this.itemPrice,
        this.itemUnitType,
        this.itemDescription,
        this.category,
        this.itemActive,
        this.itemPriceRaised,
        this.itemPreviousPrice,
        this.itemPriceBag,
        this.itemPriceAbove25,
        this.itemPrice10To25,
        this.itemPrice2P5To9P99,
        this.itemPriceRaisedBag,
        this.itemPreviousPriceBag,
        this.itemPriceRaisedAbove25,
        this.itemPreviousPriceAbove25,
        this.itemPriceRaised10To25,
        this.itemPreviousPrice10To25,
        this.itemPriceRaised2P5To9P99,
        this.itemPreviousPrice2P5To9P99});

  Product.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'];
    itemCode = json['itemCode'];
    itemName = json['itemName'];
    itemPrice = json['itemPrice'];
    itemUnitType = json['itemUnitType'];
    itemDescription = json['itemDescription'];
    category = json['category'];
    itemActive = json['itemActive'];
    itemPriceRaised = json['itemPriceRaised'];
    itemPreviousPrice = json['itemPreviousPrice'];
    itemPriceBag = json['itemPriceBag'];
    itemPriceAbove25 = json['itemPriceAbove25'];
    itemPrice10To25 = json['itemPrice10To25'];
    itemPrice2P5To9P99 = json['itemPrice2P5To9P99'];
    itemPriceRaisedBag = json['itemPriceRaisedBag'];
    itemPreviousPriceBag = json['itemPreviousPriceBag'];
    itemPriceRaisedAbove25 = json['itemPriceRaisedAbove25'];
    itemPreviousPriceAbove25 = json['itemPreviousPriceAbove25'];
    itemPriceRaised10To25 = json['itemPriceRaised10To25'];
    itemPreviousPrice10To25 = json['itemPreviousPrice10To25'];
    itemPriceRaised2P5To9P99 = json['itemPriceRaised2P5To9P99'];
    itemPreviousPrice2P5To9P99 = json['itemPreviousPrice2P5To9P99'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemId'] = this.itemId;
    data['itemCode'] = this.itemCode;
    data['itemName'] = this.itemName;
    data['itemPrice'] = this.itemPrice;
    data['UOM'] = this.itemUnitType;
    data['itemDescription'] = this.itemDescription;
    data['category'] = this.category;
    data['itemActive'] = this.itemActive;
    data['itemPriceRaised'] = this.itemPriceRaised;
    data['itemPreviousPrice'] = this.itemPreviousPrice;
    data['itemPriceBag'] = this.itemPriceBag;
    data['itemPriceAbove25'] = this.itemPriceAbove25;
    data['itemPrice10To25'] = this.itemPrice10To25;
    data['itemPrice2P5To9P99'] = this.itemPrice2P5To9P99;
    data['itemPriceRaisedBag'] = this.itemPriceRaisedBag;
    data['itemPreviousPriceBag'] = this.itemPreviousPriceBag;
    data['itemPriceRaisedAbove25'] = this.itemPriceRaisedAbove25;
    data['itemPreviousPriceAbove25'] = this.itemPreviousPriceAbove25;
    data['itemPriceRaised10To25'] = this.itemPriceRaised10To25;
    data['itemPreviousPrice10To25'] = this.itemPreviousPrice10To25;
    data['itemPriceRaised2P5To9P99'] = this.itemPriceRaised2P5To9P99;
    data['itemPreviousPrice2P5To9P99'] = this.itemPreviousPrice2P5To9P99;
    return data;
  }
}

