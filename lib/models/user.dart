import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.id,
    required this.nome,
    required this.telefone,
    required this.senha,
  });

  int id;
  String nome;
  String telefone;
  String senha;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        nome: json["name"],
        telefone: json["phone"],
        senha: json["senha"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "telefone": telefone,
        "senha": senha,
      };
}
