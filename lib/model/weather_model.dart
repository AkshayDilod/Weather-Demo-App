import 'dart:convert';
import 'dart:core';

class WeatherModel {
  String? cod;
  int? message;
  int? cnt;
  List<NextDaysList>? list;
  City? city;

  WeatherModel({this.cod, this.message, this.cnt, this.list, this.city});

  Map<String, dynamic> toMap() {
    return {
      'cod': cod,
      'message': message,
      'cnt': cnt,
      'list': list?.map((x) => x.toMap()).toList(),
      'city': city?.toMap(),
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    return WeatherModel(
      cod: map['cod'],
      message: map['message'],
      cnt: map['cnt'],
      list: List<NextDaysList>.from(
          map['list']?.map((x) => NextDaysList.fromMap(x))),
      city: City.fromMap(map['city']),
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source) =>
      WeatherModel.fromMap(json.decode(source));
}

class NextDaysList {
  DateTime? dt;
  Main? main;
  List<Weather>? weather;
  Clouds? clouds;
  // Wind? wind;
  int? visibility;
  // int? pop;
  String? dtTxt;

  NextDaysList({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    // this.wind,
    this.visibility,
    this.dtTxt,
  });

  Map<String, dynamic> toMap() {
    return {
      'dt': dt,
      'main': main?.toMap(),
      'weather': weather?.map((x) => x.toMap()).toList(),
      'clouds': clouds?.toMap(),
      // 'wind': wind?.toMap(),
      'visibility': visibility,
      'dt_txt': dtTxt,
    };
  }

  factory NextDaysList.fromMap(Map<String, dynamic> map) {
    print('nextDaysList');
    return NextDaysList(
      dt: DateTime.fromMicrosecondsSinceEpoch(map['dt']),
      main: Main.fromMap(map['main']),
      weather:
          List<Weather>.from(map['weather']?.map((x) => Weather.fromMap(x))),
      clouds: Clouds.fromMap(map['clouds']),
      // wind: Wind.fromMap(map['wind']),
      visibility: map['visibility'] ?? 0,
      dtTxt: map['dt_txt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NextDaysList.fromJson(String source) =>
      NextDaysList.fromMap(json.decode(source));
}

class Main {
  String? temp;
  String? feelsLike;
  String? tempMin;
  String? tempMax;
  String? pressure;
  String? seaLevel;
  String? grndLevel;
  String? humidity;
  String? tempKf;

  Main(
      {this.temp,
      this.feelsLike,
      this.tempMin,
      this.tempMax,
      this.pressure,
      this.seaLevel,
      this.grndLevel,
      this.humidity,
      this.tempKf});

  Map<String, dynamic> toMap() {
    return {
      'temp': temp,
      'feelsLike': feelsLike,
      'tempMin': tempMin,
      'tempMax': tempMax,
      'pressure': pressure,
      'seaLevel': seaLevel,
      'grndLevel': grndLevel,
      'humidity': humidity,
      'tempKf': tempKf,
    };
  }

  factory Main.fromMap(Map<String, dynamic> map) {
    print('Main');
    return Main(
      temp: map['temp'].toString(),
      feelsLike: map['feels_like'].toString(),
      tempMin: map['temp_min'].toString(),
      tempMax: map['temp_max'].toString(),
      pressure: map['pressure'].toString(),
      seaLevel: map['sea_level'].toString(),
      grndLevel: map['grnd_level'].toString(),
      humidity: map['humidity'].toString(),
      tempKf: map['temp_kf'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Main.fromJson(String source) => Main.fromMap(json.decode(source));
}

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({this.id, this.main, this.description, this.icon});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'main': main,
      'description': description,
      'icon': icon,
    };
  }

  factory Weather.fromMap(Map<String, dynamic> map) {
    print('weather');
    return Weather(
      id: map['id'],
      main: map['main'],
      description: map['description'],
      icon: map['icon'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Weather.fromJson(String source) =>
      Weather.fromMap(json.decode(source));
}

class Clouds {
  int? all;

  Clouds({this.all});

  Map<String, dynamic> toMap() {
    return {
      'all': all,
    };
  }

  factory Clouds.fromMap(Map<String, dynamic> map) {
    print('clouds');
    return Clouds(
      all: map['all'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Clouds.fromJson(String source) => Clouds.fromMap(json.decode(source));
}

// class Wind {
//   double? speed;
//   double? gust;
//   int? deg;

//   Wind({this.speed, this.deg, this.gust});

//   Map<String, dynamic> toMap() {
//     return {
//       'speed': speed,
//       'deg': deg,
//       'gust': gust,
//     };
//   }

//   factory Wind.fromMap(Map<String, dynamic> map) {
//     print('Wind');
//     return Wind(
//       speed: map['speed'],
//       deg: map['deg'],
//       gust: map['gust'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Wind.fromJson(String source) => Wind.fromMap(json.decode(source));
// }

// class Sys {
//   String? pod;

//   Sys({this.pod});

//   Map<String, dynamic> toMap() {
//     return {
//       'pod': pod,
//     };
//   }

//   factory Sys.fromMap(Map<String, dynamic> map) {
//     return Sys(
//       pod: map['pod'] ?? '',
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Sys.fromJson(String source) => Sys.fromMap(json.decode(source));
// }

class City {
  int? id;
  String? name;
  String? country;
  int? population;
  int? timezone;
  int? sunrise;
  int? sunset;

  City(
      {this.id,
      this.name,
      this.country,
      this.population,
      this.timezone,
      this.sunrise,
      this.sunset});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'country': country,
      'population': population,
      'timezone': timezone,
      'sunrise': sunrise,
      'sunset': sunset,
    };
  }

  factory City.fromMap(Map<String, dynamic> map) {
    print('city');
    return City(
      id: map['id'],
      name: map['name'] ?? '',
      country: map['country'] ?? '',
      population: map['population'],
      timezone: map['timezone'],
      sunrise: map['sunrise'],
      sunset: map['sunset'],
    );
  }

  String toJson() => json.encode(toMap());

  factory City.fromJson(String source) => City.fromMap(json.decode(source));
}

// class Coord {
//   double? lat;
//   double? lon;

//   Coord({this.lat, this.lon});

//   Map<String, dynamic> toMap() {
//     return {
//       'lat': lat,
//       'lon': lon,
//     };
//   }

//   factory Coord.fromMap(Map<String, dynamic> map) {
//     return Coord(
//       lat: (map['lat'] ?? 0.0),
//       lon: (map['lon'] ?? 0.0),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Coord.fromJson(String source) => Coord.fromMap(json.decode(source));
// }
