
class Cart{
  static const String tableName = "cart";
  late String productId,info,name;
  late String img;
  late double price;
  late int quantity;

  Map<String,dynamic> toJson(){
    Map<String,dynamic> map = {};
    map["product_id"] = productId;
    map["quantity"] = quantity;
    map["name"] = name;
    map["info"] = info;
    map["img"] = img;
    map["price"] = price;
    return map;
  }

  Cart.fromJson(Map<String,dynamic> map){
    productId = map["product_id"];
    quantity = map["quantity"];
    info = map["info"];
    name = map["name"];
    price = map["price"];
    img = map["img"];
  }

  Cart.fromProductJson(Map<String,dynamic> map){
    productId = map["id"].toString();
    quantity = 1;
    info = map["info_en"];
    name = map["name_en"];
    price = double.parse(map["price"]);
    img = map["image_url"];
  }
}