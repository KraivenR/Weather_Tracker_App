import 'package:weather_tracker/models/weather_model.dart';
import 'package:weather_tracker/services/weather_api_service.dart';

class WeatherRepository {
 
  final WeatherService weatherService;

  WeatherRepository(this.weatherService);

  Future<WeatherModel> getWeather(String cityName) {
    return WeatherService.getWeather(cityName);
  }
}