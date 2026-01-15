import 'package:flutter_commerce/features/auth/models/geo_location_model.dart';

class AddressModel {
  final String city;
  final String street;
  final int number;
  final String zipcode;
  final GeoLocationModel geolocation;

  AddressModel({
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
    required this.geolocation,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      city: json['city'] ?? '',
      street: json['street'] ?? '',
      number: _toInt(json['number']),
      zipcode: json['zipcode'] ?? '',
      geolocation: GeoLocationModel.fromJson(json['geolocation'] ?? {}),
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
