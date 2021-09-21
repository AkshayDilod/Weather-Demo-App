import 'dart:convert';

class HomeModel {
  String? day;
  DateTime? dateTime;
  String? temp;
  HomeModel({
    this.day,
    this.dateTime,
    this.temp,
  });
  

  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'dateTime': dateTime,
      'temp': temp,
    };
  }

  factory HomeModel.fromMap(Map<String, dynamic> map) {
    return HomeModel(
      day: map['day'],
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
      temp: map['temp'],
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeModel.fromJson(String source) => HomeModel.fromMap(json.decode(source));
}
