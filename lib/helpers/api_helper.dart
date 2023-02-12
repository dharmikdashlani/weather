import 'dart:convert';
import 'package:weather/model/weather.dart';
import 'package:http/http.dart' as http;

class APIHelper {
  APIHelper._();

  static final APIHelper apiHelper = APIHelper._();

  Future<Weather?> fechWeather({String city = 'surat'}) async {
    String apikey = "c925f560253fa751d032585b809207ff";
    String api =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apikey";

    http.Response res = await http.get(Uri.parse(api));

    if (res.statusCode == 200) {
      Map decodeData = jsonDecode(res.body);

      Weather weather = Weather.fromMap(data: decodeData);
      return weather;
    }
    return null;
  }
}
