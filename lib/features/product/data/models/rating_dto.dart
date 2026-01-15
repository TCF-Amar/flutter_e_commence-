import 'package:flutter_commerce/features/product/domain/entities/rating.dart';

/// DTO for Rating
/// Handles JSON serialization/deserialization
class RatingDto {
  final double rate;
  final int count;

  const RatingDto({required this.rate, required this.count});

  factory RatingDto.fromJson(Map<String, dynamic> json) {
    return RatingDto(
      rate: (json['rate'] as num).toDouble(),
      count: (json['count'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'rate': rate, 'count': count};
  }

  /// Convert DTO to domain entity
  Rating toEntity() {
    return Rating(rate: rate, count: count);
  }

  /// Create DTO from domain entity
  factory RatingDto.fromEntity(Rating entity) {
    return RatingDto(rate: entity.rate, count: entity.count);
  }
}
