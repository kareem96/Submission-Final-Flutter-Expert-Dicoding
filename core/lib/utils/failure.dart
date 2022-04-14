


import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  final String message;
  Failure(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  ServerFailure(String message):super(message);
}

class ConnectionFailure extends Failure{
  ConnectionFailure(String message): super(message);
}

class DataBaseFailure extends Failure{
  DataBaseFailure(String message) : super(message);
}

class CacheFailure extends Failure{
  CacheFailure(String message): super(message);
}