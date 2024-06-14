// services/weather_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String apiKey = '19c2f620f2752a773d59d10f2545a7ab'; // Replace with your API key
  static const String baseUrl = 'http://api.openweathermap.org/data/2.5/weather';

  Future<double> getTemperatureForRegion(String city) async {
    final url = '$baseUrl?q=$city&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['main']['temp'].toDouble();
    } else {
      throw Exception('Failed to load temperature data');
    }
  }
}
