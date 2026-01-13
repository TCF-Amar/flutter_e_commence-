FEATURE=$1

mkdir -p features/$FEATURE/{data/{models,datasources,repositories},domain/{entities,repositories,usecases},presentation/{controllers,pages,widgets}}

touch features/$FEATURE/data/models/${FEATURE}_model.dart
touch features/$FEATURE/data/datasources/${FEATURE}_remote_datasource.dart
touch features/$FEATURE/data/repositories/${FEATURE}_repository_impl.dart

touch features/$FEATURE/domain/entities/$FEATURE.dart
touch features/$FEATURE/domain/repositories/${FEATURE}_repository.dart
touch features/$FEATURE/domain/usecases/get_${FEATURE}_usecase.dart

touch features/$FEATURE/presentation/controllers/${FEATURE}_controller.dart
touch features/$FEATURE/presentation/pages/${FEATURE}_page.dart
