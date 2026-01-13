import '../repositories/home_repository.dart';

class GetHomeUseCase {
  final HomeRepository repository;

  GetHomeUseCase(this.repository);

  // Future<void> call() {
  //   return repository.getHome();
  // }
}
