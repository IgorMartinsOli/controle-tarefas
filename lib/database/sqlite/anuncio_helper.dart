import 'dart:developer';

import 'package:app_ad/models/ad.dart';
import 'package:app_ad/service/ad_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdHelper {
  Future<List<Ad>> getAdsByUser() async {
    AdService _service = AdService();
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("logged") != null) {
      return _service.fetchAds();
    }
    return List<Ad>.empty();
  }

  Future<Ad?> newAd(
      int id, String titulo, String descricao, double preco) async {
    AdService _service = AdService();
    Ad newAd = Ad(id: id, titulo: titulo, descricao: descricao, preco: preco);
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("logged") != null) {
      Ad? adR = await _service.newAd(newAd);
      if (adR != null) {
        return adR;
      } else {
        return null;
      }
    }
  }

  Future<bool?> removeAd(int id) async {
    AdService _service = AdService();
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("logged") != null) {
      bool? retur = (await _service.removeAd(id));
      log('retornou $retur');
      return retur;
    }
  }
}
