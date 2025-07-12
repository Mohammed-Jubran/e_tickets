import 'package:dio/dio.dart';

abstract class Failures {
  final String errorMessage;

  Failures(this.errorMessage);
}

class ServerFailures extends Failures {
  ServerFailures(super.errorMessage);

  factory ServerFailures.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailures('connection Timeout');
      case DioExceptionType.sendTimeout:
        return ServerFailures('send Timeout');
      case DioExceptionType.receiveTimeout:
        return ServerFailures('receive Timeout');
      case DioExceptionType.badCertificate:
        return ServerFailures('bad Certificate');
      case DioExceptionType.badResponse:
        return ServerFailures.fromResponse(
            dioException.response?.statusCode ?? 0, dioException.response?.data);
      case DioExceptionType.cancel:
        return ServerFailures('cancel');
      case DioExceptionType.connectionError:
        return ServerFailures('connection Error');
      case DioExceptionType.unknown:
        return ServerFailures('unknown');
    }
  }

  factory ServerFailures.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailures(response['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailures('Your Request Not Found , Try again later !!?');
    } else if (statusCode == 500) {
      return ServerFailures('Internal Server Error , Try again later !!?');
    } else {
      return ServerFailures('Ops There are an Error , Try again later !!?');
    }
  }
}
