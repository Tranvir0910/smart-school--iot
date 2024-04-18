import 'package:flutter/foundation.dart';

@immutable
class Sensor {
  final double humidity;
  final double temperature;
  final double airQuality;
  final double soundQulity;

  const Sensor({
    required this.airQuality, 
    required this.soundQulity,
    required this.humidity,
    required this.temperature,
  });

  Sensor.fromJson(Map<String, dynamic> json)
      : humidity = json['Humidity'] as double,
        temperature = json['Temperature'] as double,
        soundQulity = json['Sound Quality'] as double,
        airQuality = json['Air Quality'] as double;

  Map<String, dynamic> toJson() {
    return {
      'Humidity': humidity,
      'Temperature': temperature,
      'Air Quality': airQuality,
      'Sound Quality': soundQulity,
    };
  }
}
