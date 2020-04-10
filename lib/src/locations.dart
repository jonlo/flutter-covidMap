import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'locations.g.dart';

@JsonSerializable()
class Geometry {
  Geometry({this.type, this.coordinates});

  factory Geometry.fromJson(Map<String, dynamic> json) =>
      _$GeometryFromJson(json);
  Map<String, dynamic> toJson() => _$GeometryToJson(this);
  final String type;
  final List<double> coordinates;
}

@JsonSerializable()
class Property {
  Property({
    this.name,
    this.pop_est,
    this.gdp_md_est,
    this.economy,
    this.income_grp,
    this.iso_a2,
    this.iso_a3,
    this.continent,
    this.latitude,
    this.longitude,
    this.confirmed,
    this.deaths,
    this.active,
    this.recovered,
  });

  factory Property.fromJson(Map<String, dynamic> json) =>
      _$PropertyFromJson(json);
  Map<String, dynamic> toJson() => _$PropertyToJson(this);
  final String name;
  final double pop_est;
  final double gdp_md_est;
  final String economy;
  final String income_grp;
  final String iso_a2;
  final String iso_a3;
  final String continent;
  final String latitude;
  final String longitude;
  final Object confirmed;
  final Object deaths;
  final Object active;
  final Object recovered;
}

@JsonSerializable()
class Feature {
  Feature({
    this.type,
    this.properties,
  });

  factory Feature.fromJson(Map<String, dynamic> json) =>
      _$FeatureFromJson(json);
  Map<String, dynamic> toJson() => _$FeatureToJson(this);
  final String type;
  final Property properties;
}

@JsonSerializable()
class Locations {
  Locations({
    this.type,
    this.features,
  });

  factory Locations.fromJson(Map<String, dynamic> json) =>
      _$LocationsFromJson(json);
  Map<String, dynamic> toJson() => _$LocationsToJson(this);
  final String type;
  final List<Feature> features;
}

Future<Locations> getCovidData(String continentKey) async {
  String covidDataEu = "https://covid19-data.p.rapidapi.com/geojson-$continentKey";

  // Retrieve the locations of Google offices
  final response = await http.get(
    covidDataEu,
    headers: {
      "X-RapidAPI-Key": "ad688f4a3emsh18840915beb0c45p171f7bjsna7f36da970df"
    },
  );
  if (response.statusCode == 200) {
    return Locations.fromJson(json.decode(response.body));
  } else {
    throw HttpException(
        'Unexpected status code ${response.statusCode}:'
        ' ${response.reasonPhrase}',
        uri: Uri.parse(covidDataEu));
  }
}
