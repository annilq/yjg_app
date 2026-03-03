abstract class Failure {
  final String message;
  final int? code;

  Failure(this.message, [this.code]);

  @override
  String toString() => 'Failure: $message';
}

class ServerFailure extends Failure {
  ServerFailure(super.message, [super.code]);
}

class NetworkFailure extends Failure {
  NetworkFailure(super.message);
}

class CacheFailure extends Failure {
  CacheFailure(super.message);
}

class AuthenticationFailure extends Failure {
  AuthenticationFailure(super.message);
}

class ValidationFailure extends Failure {
  ValidationFailure(super.message);
}

class UnknownFailure extends Failure {
  UnknownFailure(super.message);
}
