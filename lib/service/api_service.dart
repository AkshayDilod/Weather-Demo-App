import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/constant.dart';
import 'package:weather_app/model/weather_model.dart';

class ApiService {
  Future<WeatherModel?> getWeatherData(String place) async {
    WeatherModel _weather = WeatherModel();
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$place&appid=$apiKey&cnt=7');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var map = jsonDecode(response.body);
        _weather.cod = map['cod'];
        _weather.cnt = map['cnt'];
        _weather.message = map['message'];
        _weather.city = City.fromMap(map['city']);
        Iterable list = map['list'];
        _weather.list = list.map((e) => NextDaysList.fromMap(e)).toList();
      }
    } catch (e) {
      print(e.toString()+'\n%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
      return null;
    }
    return _weather;
  }
}
