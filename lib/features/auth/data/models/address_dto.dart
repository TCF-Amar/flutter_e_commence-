import 'package:flutter_commerce/features/auth/data/models/geo_location_dto.dart';
import 'package:flutter_commerce/features/auth/domain/entities/address.dart';
import 'package:flutter_commerce/features/auth/domain/entities/geo_location.dart';

/// Data Transfer Object for Address
/// Handles JSON serialization/deserialization and conversion to/from domain entity
class AddressDto {
  final String city;
  final String street;
  final int number;
  final String zipcode;
  final GeoLocationDto geolocation;

  const AddressDto({
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
    required this.geolocation,
  });

  factory AddressDto.fromJson(Map<String, dynamic> json) {
    return AddressDto(
      city: json['city'] ?? '',
      street: json['street'] ?? '',
      number: _toInt(json['number']),
      zipcode: json['zipcode'] ?? '',
      geolocation: GeoLocationDto.fromJson(json['geolocation'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'street': street,
      'number': number,
      'zipcode': zipcode,
      'geolocation': geolocation.toJson(),
    };
  }

  /// Convert DTO to domain entity
  Address toEntity() {
    return Address(
      city: city,
      street: street,
      number: number,
      zipcode: zipcode,
      geolocation: GeoLocation(
        latitude: geolocation.lat,
        longitude: geolocation.long,
      ),
    );
  }

  /// Create DTO from domain entity
  factory AddressDto.fromEntity(Address entity) {
    return AddressDto(
      city: entity.city,
      street: entity.street,
      number: entity.number,
      zipcode: entity.zipcode,
      geolocation: GeoLocationDto(
        lat: entity.geolocation.latitude,
        long: entity.geolocation.longitude,
      ),
    );
  }

  static int _toInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    return int.tryParse(value.toString()) ?? 0;
  }
}
