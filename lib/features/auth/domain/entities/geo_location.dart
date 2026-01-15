/// Domain entity representing a geographic location
/// Pure Dart class with no external dependencies
class GeoLocation {
  final double latitude;
  final double longitude;

  const GeoLocation({required this.latitude, required this.longitude});

  GeoLocation copyWith({double? latitude, double? longitude}) {
    return GeoLocation(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GeoLocation &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;
}
