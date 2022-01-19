import 'package:http/http.dart' as http;
import 'dart:convert';

const String apiKey = '1C349635-A53A-4B2C-9A8A-0CF273FDE49C';

class NetworkHelper {
  final Uri url;

  NetworkHelper(this.url);

  Future getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
