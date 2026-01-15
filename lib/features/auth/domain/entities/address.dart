import 'package:flutter_commerce/features/auth/domain/entities/geo_location.dart';

/// Domain entity representing a user's address
/// Pure Dart class with no external dependencies
class Address {
  final String city;
  final String street;
  final int number;
  final String zipcode;
  final GeoLocation geolocation;

  const Address({
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
    required this.geolocation,
  });

  Address copyWith({
    String? city,
    String? street,
    int? number,
    String? zipcode,
    GeoLocation? geolocation,
  }) {
    return Address(
      city: city ?? this.city,
      street: street ?? this.street,
      number: number ?? this.number,
      zipcode: zipcode ?? this.zipcode,
      geolocation: geolocation ?? this.geolocation,
    );
  }

  String get fullAddress => '$number $street, $city $zipcode';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Address &&
        other.city == city &&
        other.street == street &&
        other.number == number &&
        other.zipcode == zipcode &&
        other.geolocation == geolocation;
  }

  @override
  int get hashCode {
    return city.hashCode ^
        street.hashCode ^
        number.hashCode ^
        zipcode.hashCode ^
        geolocation.hashCode;
  }
}
