import 'dart:convert';

import 'package:http/http.dart' as http;

class RequestHelper {
  static Future<dynamic> getRequest(String url) async {
    http.Response response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        String jsData = response.body;
        var decodedData = jsonDecode(jsData);
        return decodedData;
      } else {
        return "failed";
      }
    } catch (exp) {
      return "failed";
    }
  }
}
