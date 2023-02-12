class Weather {
  final String main;
  final String desc;
  final double temp;
  final double speed;
  final int humidity;
  final String country;

  Weather({
    required this.main,
    required this.desc,
    required this.temp,
    required this.speed,
    required this.humidity,
    required this.country,
  });

  factory Weather.fromMap({required Map data}) {
    return Weather(
        main: data['weather'][0]['main'],
        desc: data['weather'][0]['description'],
        temp: data['main']['temp'],
        speed: data['wind']['speed'],
        humidity: data['main']['humidity'],
        country: data['sys']['country']);
  }
}
