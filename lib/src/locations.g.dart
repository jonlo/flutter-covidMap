// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Geometry _$GeometryFromJson(Map<String, dynamic> json) {
  return Geometry(
      type: json['type'] as String,
      coordinates: (json['coordinates'] as List)
          ?.map((e) => (e as num)?.toDouble())
          ?.toList());
}

Map<String, dynamic> _$GeometryToJson(Geometry instance) => <String, dynamic>{
      'type': instance.type,
      'coordinates': instance.coordinates
    };

Property _$PropertyFromJson(Map<String, dynamic> json) {
  return Property(
      name: json['name'] as String,
      pop_est: json['pop_est'] as int,
      gdp_md_est: json['gdp_md_est'] as int,
      economy: json['economy'] as String,
      income_grp: json['income_grp'] as String,
      iso_a2: json['iso_a2'] as String,
      iso_a3: json['iso_a3'] as String,
      continent: json['continent'] as String,
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
      confirmed: json['confirmed'],
      deaths: json['deaths'],
      active: json['active'],
      recovered: json['recovered']);
}

Map<String, dynamic> _$PropertyToJson(Property instance) => <String, dynamic>{
      'name': instance.name,
      'pop_est': instance.pop_est,
      'gdp_md_est': instance.gdp_md_est,
      'economy': instance.economy,
      'income_grp': instance.income_grp,
      'iso_a2': instance.iso_a2,
      'iso_a3': instance.iso_a3,
      'continent': instance.continent,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'confirmed': instance.confirmed,
      'deaths': instance.deaths,
      'active': instance.active,
      'recovered': instance.recovered
    };

Feature _$FeatureFromJson(Map<String, dynamic> json) {
  return Feature(
      type: json['type'] as String,
      properties: json['properties'] == null
          ? null
          : Property.fromJson(json['properties'] as Map<String, dynamic>));
}

Map<String, dynamic> _$FeatureToJson(Feature instance) =>
    <String, dynamic>{'type': instance.type, 'properties': instance.properties};

Locations _$LocationsFromJson(Map<String, dynamic> json) {
  return Locations(
      type: json['type'] as String,
      features: (json['features'] as List)
          ?.map((e) =>
              e == null ? null : Feature.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$LocationsToJson(Locations instance) =>
    <String, dynamic>{'type': instance.type, 'features': instance.features};
