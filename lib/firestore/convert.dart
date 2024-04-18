class Sensor {
  Sensor({required this.humidity, required this.temperature,});

  Sensor.fromJson(Map<String, Object?> json)
    : this(
        humidity: json['Temperature']! as String,
        temperature: json['Humidity']! as String,
      );

  final String humidity;
  final String temperature;

  Map<String, Object?> toJson() {
    return {
      'Temperature': temperature,
      'Humidity': humidity,
    };
  }
}