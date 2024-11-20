import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sales/di.dart';
import 'package:sales/utils/services/local_storage.dart';
import 'package:sales/utils/services/navigation_service.dart';
import 'package:sales/views/auth/login.dart';

abstract class Failure extends Equatable {
  Failure({required this.message, required this.statusCode})
      : assert(
          statusCode is String || statusCode is int,
          'StatusCode cannot be a ${statusCode.runtimeType}',
        );

  final String message;
  final dynamic statusCode;

  String get errorMessage {
    final isStringStatusCode = statusCode is String;
    return '$statusCode${isStringStatusCode ? ' Error' : ''}: $message';
  }

  @override
  List<dynamic> get props => [message, statusCode];
}

class CacheFailure extends Failure {
  CacheFailure({required super.message, required super.statusCode});
}

class ServerFailure extends Failure {
  ServerFailure({required super.message, required super.statusCode});

  // A factory constructor to create ServerFailure from DioException.
  factory ServerFailure.fromException(DioException dioException) {
    // Handle the 401 status code by logging out the user
    if (dioException.response?.statusCode == 401) {
      _logoutUser();
      return ServerFailure(
        message: 'Your token has expired. You have been logged out.',
        statusCode: dioException.response?.statusCode ?? 0,
      );
    }

    return ServerFailure(
      message:
          dioException.response?.data['message'] ?? 'An unknown error occurred',
      statusCode: dioException.response?.statusCode ?? 0,
    );
  }

  // Logout function to clear user session and redirect to login screen
  static void _logoutUser() {
    final localStorage =
        getIt<MySharedPref>(); // Assuming you're using DI for MySharedPref
    localStorage.logout(); // Clear the user session

    // Navigate to the login screen
    navigatorKey.currentState!.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const Login()),
      (route) => false,
    );
  }
}
