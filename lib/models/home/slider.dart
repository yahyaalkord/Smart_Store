class HomeSlider {
  late int id;
  late String objectId;
  late String url;
  late String imageUrl;



  HomeSlider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    objectId = json['object_id'];
    url = json['url'];
    imageUrl = json['image_url'];
  }

}
