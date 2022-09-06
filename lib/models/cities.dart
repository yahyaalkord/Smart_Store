class Cities {
 late int id;
 late String nameEn;
 late String nameAr;

  Cities();

  Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
  }


}
