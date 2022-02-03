import 'package:app_ad/database/sqlite/anuncio_helper.dart';

class Ad {
  late int? id;
  late String title;
  late String subTitle;
  late double price;
  String? image;

  Ad({
    this.id,
    required this.title,
    required this.subTitle,
    required this.price,
    this.image,
  });

  Ad.fromMap(Map map) {
    this.id = map[AnuncioHelper.idColumn];
    this.title = map[AnuncioHelper.tituloColumn];
    this.subTitle = map[AnuncioHelper.descricaoColumn];
    this.price = map[AnuncioHelper.precoColumn];
    this.image = map[AnuncioHelper.imagePathColumn];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': this.id,
      'titulo': this.title,
      'descricao': this.subTitle,
      'preco': this.price,
      'imagePath': this.image
    };
    return map;
  }

  @override
  String toString() {
    return "Anuncio(id: $id, titulo: $title, descricao: $subTitle, preco: $price)";
  }
}
