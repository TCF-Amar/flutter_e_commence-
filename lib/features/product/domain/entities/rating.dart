/// Domain entity representing a product rating
/// Pure Dart class with no external dependencies
class Rating {
  final double rate;
  final int count;

  const Rating({required this.rate, required this.count});

  Rating copyWith({double? rate, int? count}) {
    return Rating(rate: rate ?? this.rate, count: count ?? this.count);
  }

  /// Get rating percentage (0-100)
  double get percentage => (rate / 5.0) * 100;

  /// Check if rating is good (>= 4.0)
  bool get isGoodRating => rate >= 4.0;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Rating && other.rate == rate && other.count == count;
  }

  @override
  int get hashCode => rate.hashCode ^ count.hashCode;

  /// Format rate with fixed decimal places
  String toStringAsFixed(int fractionDigits) {
    return rate.toStringAsFixed(fractionDigits);
  }
}
