import 'dart:io';
import 'dart:convert';
import 'package:app_ad/models/ad.dart';
import 'package:path_provider/path_provider.dart';

class FilePersistence {
  Future<File> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    String _localPath = directory.path;
    return File("$_localPath/adList.json");
  }

  Future saveData(List<Ad> ads) async {
    final localFile = await _getLocalFile();
    List adList = [];

    ads.forEach((anuncio) {
      adList.add(anuncio.toMap());
    });

    String data = json.encode(adList);
    return localFile.writeAsStringSync(data);
  }

  Future<List<Ad>> getData() async {
    final localFile = await _getLocalFile();
    String data = await localFile.readAsString();
    List adList = json.decode(data);

    List<Ad> ads = [];

    adList.forEach((mapTask) {
      ads.add(Ad.fromMap(mapTask));
    });

    return ads;
  }
}
