import 'dart:io';
import 'package:dio/dio.dart';
import 'package:sales/core/network/api_endpopints.dart';
import 'package:sales/utils/services/local_storage.dart';

class ApiService {
  late final Dio _dio;
  final MySharedPref _sharedPref;

  String? token;
  String? identifier;
  setHeaderWithOutToken() {
    Map<String, String> q = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    return q;
  }

  setHeaderWithToken() async {
    final tkn = _sharedPref.getAccessToken();
    if (tkn != "") {
      token = tkn;
    }
    Map<String, String> q = {
      HttpHeaders.contentTypeHeader: 'application/json',
      if (token != "") HttpHeaders.authorizationHeader: "$token",
    };
    return q;
  }

  ApiService(this._dio, this._sharedPref);

// get method
  Future<Response> get(
      {required String endPoint,
      dynamic data,
      dynamic params,
      bool useToken = true}) async {
    Map<String, String> headers;
    if (useToken) {
      headers = await setHeaderWithToken();
    } else {
      headers = setHeaderWithOutToken();
    }
    var response = await _dio.get('${APIEndPoints.baseUrl}$endPoint',
        data: data,
        queryParameters: params,
        options: Options(headers: headers));
    return response;
  }

// post method
  Future<Response> post(
      {required String endPoint,
      dynamic data,
      dynamic params,
      bool useToken = true}) async {
    Map<String, String> headers;
    if (useToken) {
      headers = await setHeaderWithToken();
    } else {
      headers = setHeaderWithOutToken();
    }
    var response = await _dio.post('${APIEndPoints.baseUrl}$endPoint',
        data: data,
        queryParameters: params,
        options: Options(headers: headers));
    return response;
  }

// put method
  Future<Response> put(
      {required String endPoint, bool useToken = true, data}) async {
    Map<String, String> headers;
    if (useToken) {
      headers = await setHeaderWithToken();
    } else {
      headers = setHeaderWithOutToken();
    }
    var response = await _dio.put('${APIEndPoints.baseUrl}$endPoint',
        data: data, options: Options(headers: headers));
    return response;
  }

// delete method
  Future<Response> delete(
      {required String endPoint,
      dynamic data,
      dynamic params,
      bool useToken = true}) async {
    Map<String, String> headers;
    if (useToken) {
      headers = await setHeaderWithToken();
    } else {
      headers = setHeaderWithOutToken();
    }
    var response = await _dio.delete('${APIEndPoints.baseUrl}$endPoint',
        data: data,
        queryParameters: params,
        options: Options(headers: headers));
    return response;
  }

// download method
  Future<Response> download(
      {required String endPoint,
      required String filePath,
      required bool useToken}) async {
    Map<String, String> headers;
    if (useToken) {
      headers = await setHeaderWithToken();
    } else {
      headers = setHeaderWithOutToken();
    }
    try {
      var response = await _dio.download(
          '${APIEndPoints.baseUrl}$endPoint', filePath,
          options: Options(headers: headers));
      return response;
    } catch (e) {
      throw Exception("Download failed: $e");
    }
  }
}
