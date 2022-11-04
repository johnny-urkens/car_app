import 'package:car_app/models/statistic.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/personalCar.dart';
import '../models/car.dart';
import '../models/rating.dart';

class CarApi {
  static String server = 'apt-edge-service-johnny-urkens.cloud.okteto.net';

  static Future<List<Car>> fetchCars() async {
    var url = Uri.https(server, '/statistics/cars');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((car) => Car.fromJson(car)).toList();
    } else {
      throw Exception('Failed to load cars');
    }
  }

  static Future<List<PersonalCar>> fetchPersonalCars(String name) async {
    var url = Uri.https(server, '/statistics/user/$name');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((personalCar) => PersonalCar.fromJson(personalCar))
          .toList();
    } else {
      throw Exception('Failed to load personalcars');
    }
  }

  static Future<Rating> fetchRating(String carBrand, List userScores) async {
    var name = userScores[0];
    print(name);
    print('api + $carBrand');
    var url = Uri.https(server, '/statistics/$name/car/$carBrand');
    print(url);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return Rating.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Rating');
    }
  }

  // static Future<Car> updateRating(
  //     String userName, String carBrand, int scoreNumber) async {
  //   var url = Uri.https(server, '/statistics');
  //   var update = 

  //   final http.Response response = await http.put(url,
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode());
  //   if (response.statusCode == 200) {
  //     return Statistic.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('Failed to update rating');
  //   }
  // }
}
