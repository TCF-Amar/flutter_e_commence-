class Rating {
  final double rate;
  final int count;

  Rating({required this.rate, required this.count});

  Map<String, dynamic> toJson() => {'rate': rate, 'count': count};
  String toStringAsFixed(int i) {
    return rate.toStringAsFixed(i);
  }
}
