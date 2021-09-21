import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/service/api_service.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    fetchWeather('Noida');
  }
  final api = ApiService();
  bool loading = false;
  String city = '';
  String todayDate = '';
  String temp = '';
  String des = '';
  bool searchBtn = true;
  List<NextDaysList> nextDays = [];

  WeatherModel weatherData = WeatherModel();

  updateSearchBtn(bool val) {
    searchBtn = val;
    notifyListeners();
  }

  fetchWeather(String place) async {
    loading = true;
    var data = await api.getWeatherData(place);
    if (data!.list!.isNotEmpty) {
      todayDate = dateFormat(DateTime.parse(data.list![0].dtTxt!.toString()));
      notifyListeners();
      city = data.city!.name!;
      temp = fahrenheitToCelsius(double.parse(data.list![0].main!.temp!));
      des = data.list![0].weather![0].main!;
      nextDays = data.list!;
      weatherData.city = data.city;
      loading = false;
      notifyListeners();
    }
  }

  String fahrenheitToCelsius(double val) {
    return (val - 273.15).toInt().toString();
  }

  String dateWithDayFormat(DateTime date) {
    print(date);
    String dateFormate = DateFormat('EEE, MMM d, ' 'yyyy').format(date);
    print(dateFormate);
    return dateFormate;
  }

  String dateFormat(DateTime date) {
    String dateFormate = DateFormat('MMM d, ' 'yyyy').format(date);
    return dateFormate;
  }

  String dayFormat(DateTime date) {
    String dayFormate = DateFormat('EEEE').format(date);
    print(dayFormate);
    return dayFormate;
  }

  String timeFormat(DateTime date) {
    String dayFormate = DateFormat('h:mm a').format(date);
    print(dayFormate);
    return dayFormate;
  }
}
