import 'package:dio/dio.dart';
import 'package:weather_tracker/models/weather_model.dart';

class WeatherService {
  static const String apiKey = 'c981e3ba451829260092d58e41291bc2';
   
  static final Dio dio = Dio();

  static Future<WeatherModel> getWeather(String cityName) async {
    final response = await dio.get(
      'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric',
    );

    return WeatherModel.fromJson(response.data);
  }
}