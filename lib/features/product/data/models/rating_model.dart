import 'package:flutter_commerce/features/product/domain/entities/rating.dart';

class RatingModel extends Rating {
  RatingModel({required super.rate, required super.count});

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      rate: (json['rate'] as num).toDouble(),
      count: (json['count'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'rate': rate, 'count': count};
  }

  
}
