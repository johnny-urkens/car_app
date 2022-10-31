import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/car.dart';

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
}
