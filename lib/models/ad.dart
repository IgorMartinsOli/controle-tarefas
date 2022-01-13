import 'dart:io';

class Ad {
  late String title;
  late String subTitle;
  late String price;
  bool done = false;
  File? image;

  Ad(this.title, this.subTitle, this.price, {this.image});

  Ad.fromMap(Map map) {
    this.title = map['title'];
    this.subTitle = map['subTitle'];
    this.price = map['price'];
    this.done = map['done'];
    //this.image = map['imagePath'] != "" ? File(map['imagePath']) : null;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "title": this.title,
      "subTitle": this.subTitle,
      "price": this.price,
      "done": this.done,
      //"imagePath": this.image != null ? this.image!.path : "",
    };
    return map;
  }
}
