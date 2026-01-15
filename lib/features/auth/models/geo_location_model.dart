class GeoLocationModel {
  final double lat;
  final double long;

  GeoLocationModel({required this.lat, required this.long});

  factory GeoLocationModel.fromJson(Map<String, dynamic> json) {
    return GeoLocationModel(
      lat: _toDouble(json['lat'] ?? json['latitude']),
      long: _toDouble(json['long'] ?? json['longitude']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'lat': lat, 'long': long};
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0.0;
  }
}
