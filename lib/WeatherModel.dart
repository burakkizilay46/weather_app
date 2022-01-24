class WeatherModel {
  String? name;
  String? weather;
  String? temperature;

  WeatherModel({this.name, this.weather, this.temperature});

  WeatherModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    weather = json['weather'];
    temperature = json['temperature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['weather'] = this.weather;
    data['temperature'] = this.temperature;
    return data;
  }
}