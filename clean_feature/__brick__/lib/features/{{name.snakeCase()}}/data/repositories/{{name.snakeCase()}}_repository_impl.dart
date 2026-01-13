import '../../domain/repositories/{{name.snakeCase()}}_repository.dart';
import '../datasources/{{name.snakeCase()}}_remote_datasource.dart';

class {{name.pascalCase()}}RepositoryImpl implements {{name.pascalCase()}}Repository {
  final {{name.pascalCase()}}RemoteDataSource remoteDataSource;

  {{name.pascalCase()}}RepositoryImpl(this.remoteDataSource);
}
