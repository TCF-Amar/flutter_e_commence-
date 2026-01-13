import '../repositories/{{name.snakeCase()}}_repository.dart';

class Get{{name.pascalCase()}}UseCase {
  final {{name.pascalCase()}}Repository repository;

  Get{{name.pascalCase()}}UseCase(this.repository);

  // Future<void> call() {
  //   return repository.get{{name.pascalCase()}}();
  // }
}
