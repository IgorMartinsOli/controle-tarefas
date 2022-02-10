import 'dart:convert';

Ad postFromJson(String str) => Ad.fromJson(json.decode(str));

String postToJson(Ad data) => json.encode(data.toJson());

class Ad {
  Ad({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.preco,
  });

  int id;
  String titulo;
  String descricao;
  double preco;

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
        id: json["id"],
        titulo: json["titulo"],
        descricao: json["descricao"],
        preco: json["preco"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "titulo": titulo,
        "descricao": descricao,
        "preco": preco,
      };
}
