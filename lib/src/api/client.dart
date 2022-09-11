import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:tankobon_mobile/src/api/models/models.dart';

abstract class TankobonClient {
  static String baseUrl = "https://tankobon.fly.dev/";

  static Future<Results> getManga({String? query}) async {
    var uri = Uri.parse(baseUrl);
    Map<String, dynamic> queryParams = {};

    if (query != null) {
      queryParams.addAll({'q': query});
    }

    uri = uri.replace(
      path: 'api/manga/',
      queryParameters: queryParams
    );
    
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var map = json.decode(response.body);
      var obj = Results.fromJson(map);
      return obj;
    } else {
      throw Exception("Could not retrieve manga");
    }
  }
}