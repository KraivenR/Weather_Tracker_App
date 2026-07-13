import 'package:dio/dio.dart';
import 'package:weather_tracker/models/weather_model.dart';

class WeatherService {
  // Replace the value below with your own OpenWeatherMap API key.
  // Get one at: https://openweathermap.org/api
  static const String apiKey = 'api_key';

  static final Dio dio = Dio();

  static Future<WeatherModel> getWeather(String cityName) async {
    final response = await dio.get(
      'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric',
    );

    return WeatherModel.fromJson(response.data);
  }
}