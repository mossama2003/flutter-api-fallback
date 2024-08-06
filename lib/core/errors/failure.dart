import 'package:dio/dio.dart';

abstract class Failure {
  final String errMessage;

  const Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.error) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with ApiServer');

      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with ApiServer');

      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout with ApiServer');

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          // dioError.response!.statusCode,
          dioError.response!.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure('Request to ApiServer was canceled');

      case DioExceptionType.unknown:
        if (dioError.message!.contains('SocketException')) {
          return ServerFailure('No Internet Connection');
        }
        return ServerFailure('Unexpected Error, Please try again!');
      default:
        return ServerFailure('Ops There was an Error, Please try again');
    }
  }

  factory ServerFailure.fromResponse(Response response) {
    List errors = response.data['errors'] ?? [];
    if (errors.isNotEmpty) {
      return ServerFailure(errors.first['message']);
    } else if (response.statusCode == 500) {
      return ServerFailure('Internal Server error, Please try later');
    } else if (response.statusCode == 403) {
      return ServerFailure(response.data['error']);
    } else {
      return ServerFailure('Ops There was an Error, Please try again');
    }
  }
}
