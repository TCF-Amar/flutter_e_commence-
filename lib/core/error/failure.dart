// ignore_for_file: overridden_fields

abstract class Failure {
  final String message;
  final int? statusCode;

  const Failure(this.message, {this.statusCode});
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure() : super('Connection timeout');
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure() : super('Unauthorized access', statusCode: 401);
}

class ServerFailure extends Failure {
  @override
  final int? statusCode;
  ServerFailure(super.message, {this.statusCode});
}

class UnknownFailure extends Failure {
  UnknownFailure(Object e) : super(e.toString());
}
