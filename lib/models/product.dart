class Products {
  late int id;
  late String nameEn;
  late String nameAr;
  late String infoEn;
  late String infoAr;
  late String price;
  late String quantity;
  late String overalRate;
  late String subCategoryId;
  late dynamic productRate;
  String? offerPrice;
  late bool isFavorite;
  late String imageUrl;
  late int? userId;
  List<String> images = [];

  Products();


  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    infoEn = json['info_en'];
    infoAr = json['info_ar'];
    price = json['price'];
    quantity = json['quantity'];
    overalRate = json['overal_rate'];
    subCategoryId = json['sub_category_id'];
    productRate = json['product_rate'];
    offerPrice = json['offer_price'];
    isFavorite = json['is_favorite'];
    imageUrl = json['image_url'];
    userId = json['user_id'];
    if(json.containsKey("images")){
      var data = json["images"] as List;
      images = data.map((e) => e['image_url'].toString()).toList();
    }
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['name']= nameEn;
    map['info']= infoEn;
    map['price']= price;
    map['quantity']= quantity;
    map['user_id']= userId;
    // map['user_id']= userId;
    return map;
  }

}