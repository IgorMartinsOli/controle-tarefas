import 'dart:io';

class Ad {
  String title;
  String subTitle;
  String price;
  bool done = false;
  File? image;

  Ad(this.title, this.subTitle, this.price, {this.image});
}
