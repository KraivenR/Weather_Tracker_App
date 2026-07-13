class WeatherModel {
  final String city;
  final double temperature;
  final String description;
  final double maxTemperature;
  final double minTemperature;
  final double windSpeed;
  final int sunSet;
  final int sunRise;
  final String condition;

  WeatherModel({
    required this.city,
    required this.temperature,
    required this.description,
    required this.maxTemperature,
    required this.minTemperature,
    required this.windSpeed,
    required this.sunSet,
    required this.sunRise,
    required this.condition,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['name'],
      temperature: (json['main']['temp'] as num).toDouble(),
      maxTemperature: (json['main']['temp_max'] as num).toDouble(),
      minTemperature: (json['main']['temp_min'] as num).toDouble(),
      description: json['weather'][0]['description'],
      condition: json['weather'][0]['main'],
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      sunRise: json['sys']['sunrise'],
      sunSet: json['sys']['sunset'],
    );
  }
}