class Items {
  int cartId;
  DateTime cartCreatedTime;
  String productName;
  int qty;
  String price;
  int cGSTPercentage;
  int sGSTPercentage;
  int iGSTPercentage;
  String rowTotal;

  Items(
      {this.cartId,
        this.cartCreatedTime,
        this.productName,
        this.qty,
        this.price,
        this.cGSTPercentage,
        this.sGSTPercentage,
        this.iGSTPercentage,
        this.rowTotal});

  Items.fromJson(Map<String, dynamic> json) {
    cartId = json['cartId'];
    cartCreatedTime = json['cartCreatedTime']  == null
        ? null
        : DateTime.parse(json['cartCreatedTime'] as String);
    productName = json['productName'];
    qty = json['qty'];
    price = json['price'];
    cGSTPercentage = json['CGSTPercentage'];
    sGSTPercentage = json['SGSTPercentage'];
    iGSTPercentage = json['IGSTPercentage'];
    rowTotal = json['rowTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cartId'] = this.cartId;
    data['cartCreatedTime'] = this.cartCreatedTime?.toIso8601String();
    data['productName'] = this.productName;
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['CGSTPercentage'] = this.cGSTPercentage;
    data['SGSTPercentage'] = this.sGSTPercentage;
    data['IGSTPercentage'] = this.iGSTPercentage;
    data['rowTotal'] = this.rowTotal;
    return data;
  }
}
