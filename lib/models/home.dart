import 'package:smart_store/models/categories.dart';
import 'package:smart_store/models/product.dart';

class Home{
  List<Slider> slider = [];
  List<Categories> categories = [];
  List<Products> latestProducts = [];
  List<Products> famousProducts = [];

  Home();

  Home.fromJson(Map<String,dynamic> json){
    var sliderJson = json['slider'] as List;
    slider = sliderJson.map((e) => Slider.fromJson(e)).toList();
    var categoriesJson = json['categories'] as List;
    categories = categoriesJson.map((e) => Categories.fromHomeJson(e)).toList();
    var latestProductsJson = json['latest_products'] as List;
    latestProducts = latestProductsJson.map((e) => Products.fromJson(e)).toList();
    var famousProductsJson = json['famous_products'] as List;
    famousProducts = famousProductsJson.map((e) => Products.fromJson(e)).toList();

    print("slider list ${slider.length}");
  }


}

class Slider {
  late int id;
  late String objectId;
  late String url;
  late String imageUrl;

  Slider();

  Slider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    objectId = json['object_id'];
    url = json['url'];
    imageUrl = json['image_url'];
  }

}