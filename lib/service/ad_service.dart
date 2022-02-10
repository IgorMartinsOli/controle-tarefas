import 'dart:convert';
import 'dart:developer';
import 'package:app_ad/models/ad.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class AdService {
  Future<List<Ad>> fetchAds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final url = await 'http://149.28.39.130:8080/anuncios/';
    final response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token!,
      },
    );
    List<Ad> ads = List<Ad>.empty(growable: true);

    if (response.statusCode == 200) {
      List resList = jsonDecode(response.body);

      resList.forEach((mPost) {
        ads.add(Ad.fromJson(mPost));
      });
    }
    return ads;
  }

  Future<Ad?> newAd(Ad ad) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String url = 'http://149.28.39.130:8080/anuncios/';
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token!,
      },
      body: json.encode(ad.toJson()),
    );
    log('${response.statusCode}');
    if (response.statusCode == 201) {
      return ad;
    }
    if (response.statusCode == 401) {
      log('O envio do token é obrigatório!');
    }
    if (response.statusCode == 500) {
      log('Erro ao executar a operação');
    }
  }

/*
  Future<Ad?> editAd(Ad ad) async {
    String url = await 'https://jsonplaceholder.typicode.com/posts/${ad.id}';
    final response = await http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(ad.toJson()),
    );
    if (response.statusCode == 200) {
      Ad rPost = Ad.fromJson(jsonDecode(response.body));
      return rPost;
    } else {
      Exception("Falha na conexão com o servidor!");
    }
  }*/

  Future<bool?> removeAd(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String url = 'http://149.28.39.130:8080/anuncios/$id';
    final response = await http.delete(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token!,
      },
    );
    log('${response.statusCode}');
    if (response.statusCode == 200) {
      return true;
    } else {
      Exception("Falha na conexão com o servidor!");
    }
  }
}
