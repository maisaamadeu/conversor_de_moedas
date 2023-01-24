import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = 'https://api.hgbrasil.com/finance?key=60892ac4';

class API {
  Future<Map> getData() async {
    http.Response response = await http.get(request);
    return json.decode(response.body);
  }
}
