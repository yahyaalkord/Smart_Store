class User {
 late int id;
 late String name;
  String? email;
 late String mobile;
 late String gender;
 late bool active;
 late bool verified;
 late String cityId;
 late String storeId;
  String? fcmToken;
 late String token;
 late String tokenType;
 late String refreshToken;
//late City city;
//late Store store;
  late String password;
 User();

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    gender = json['gender'];
    active = json['active'];
    verified = json['verified'];
    cityId = json['city_id'];
    storeId = json['store_id'];
    fcmToken = json['fcm_token'];
    token = json['token'];
    tokenType = json['token_type'];
    refreshToken = json['refresh_token'];
  }


}

class City {
  late int id;
  late String nameEn;
  late String nameAr;


  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
  }


}

class Store {
 late int id;
 late String name;
 late String storeName;
 late String email;
  String? emailVerifiedAt;
 late String mobile;
 late String storeUuid;
 late String cityId;
  String? verificationCode;
 late String active;
 late String verified;
  String? firebaseKey;
  String? image;
 late String address;
  String? facebook;
  String? instagram;
 late String createdAt;
 late String updatedAt;



  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    storeName = json['store_name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    mobile = json['mobile'];
    storeUuid = json['store_uuid'];
    cityId = json['city_id'];
    verificationCode = json['verification_code'];
    active = json['active'];
    verified = json['verified'];
    firebaseKey = json['firebase_key'];
    image = json['image'];
    address = json['address'];
    facebook = json['facebook'];
    instagram = json['instagram'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}