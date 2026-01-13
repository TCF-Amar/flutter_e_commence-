import '../../domain/entities/home.dart';

class HomeModel extends Home {
  const HomeModel();

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel();
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}
