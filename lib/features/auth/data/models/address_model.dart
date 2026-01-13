import 'package:flutter_commerce/features/auth/data/models/geo_location_model.dart';
import 'package:flutter_commerce/features/auth/domain/entities/address.dart';

class AddressModel extends Address {
  AddressModel({
    required super.city,
    required super.street,
    required super.number,
    required super.zipcode,
    required super.geolocation,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    final geoModel = GeoLocationModel.fromJson(json['geolocation'] ?? {});

    return AddressModel(
      city: json['city'] ?? '',
      street: json['street'] ?? '',
      number: _toInt(json['number']),
      zipcode: json['zipcode'] ?? '',
      geolocation: geoModel.toEntity(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'street': street,
      'number': number,
      'zipcode': zipcode,
      'geolocation': {'lat': geolocation.lat, 'long': geolocation.long},
    };
  }

  static int _toInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    return int.tryParse(value.toString()) ?? 0;
  }
}
