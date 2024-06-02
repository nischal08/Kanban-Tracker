import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:kanban/core/values/enums.dart';
import 'package:kanban/core/values/exception/app_exceptions.dart';
import 'package:kanban/core/values/exception/request_type_exception.dart';

class ApiManager {
  late final Dio _client;
  dynamic responseJson;
  static String token = '';
  final timeoutDuration = const Duration(seconds: 60);
  ApiManager() {
    _client = Dio();
    _client.interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestHeader: true,
        responseHeader: false,
        requestBody: true,
      ),
    );
  }
  Future request({
    required RequestType requestType,
    // dynamic heading = Nothing,
    required String url,
    dynamic body,
    dynamic headers,
    ResponseType? responseType,
  }) async {
    Map<String, String> heading = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
    };
    Map<String, String> headingWithToken = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'Accept': '*/*',
    };

    Response? resp;
    // if (!UtilityProvider.canCallApi()) {
    //   throw "Inactive for too long, Please login";
    // }

    try {
      switch (requestType) {
        case RequestType.get:
          resp = await _client
              .get(
                url,
                options: Options(
                  headers: heading,
                  responseType: responseType,
                ),
              )
              .timeout(timeoutDuration);
          break;
        case RequestType.getWithToken:
          resp = await _client
              .get(
                url,
                options: Options(
                  headers: headingWithToken,
                  responseType: responseType,
                ),
              )
              .timeout(timeoutDuration);
          break;
        case RequestType.post:
          resp = await _client
              .post(
                url,
                data: body,
                options: Options(
                  headers: heading,
                  responseType: responseType,
                ),
              )
              .timeout(timeoutDuration);
          break;
        case RequestType.postWithHeaders:
          resp = await _client
              .post(
                url,
                data: body,
                options: Options(
                  headers: {...heading, ...headers},
                  responseType: responseType,
                ),
              )
              .timeout(timeoutDuration);
          break;
        case RequestType.postWithOnlyHeaders:
          resp = await _client
              .post(
                url,
                data: body,
                options: Options(
                  headers: headers,
                  responseType: responseType,
                ),
              )
              .timeout(timeoutDuration);

          break;
        case RequestType.postWithToken:
          resp = await _client
              .post(
                url,
                data: body,
                options: Options(
                  headers: headingWithToken,
                  responseType: responseType,
                ),
              )
              .timeout(timeoutDuration);
          break;
        case RequestType.putWithHeaders:
          resp = await _client
              .put(
                url,
                data: body,
                options: Options(
                  headers: headingWithToken,
                  responseType: responseType,
                ),
              )
              .timeout(timeoutDuration);
          break;
        case RequestType.delete:
          resp = await _client
              .delete(
                url,
                options: Options(
                  headers: heading,
                  responseType: responseType,
                ),
              )
              .timeout(timeoutDuration);
          break;
        default:
          return throw RequestTypeNotFoundException(
            "The HTTP request method is not found",
          );
      }
      return returnResponse(resp);
    } on DioException catch (ex) {
      throw ex.response?.data?["message"] ??
          "Dear customer, we are unable to complete the process. Please try again later.";
    } on TimeoutException catch (_) {
      throw "Dear customer, Timeout error occured. Please try again later";
    } catch (ex) {
      rethrow;
    }
  }

  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = response.data;
        return responseJson;

      case 201:
        dynamic responseJson = response.data;
        return responseJson;

      case 400:
        dynamic responseJson = response.data;
        throw BadRequestException(responseJson
            .toString()
            .split('[')
            .last
            .trim()
            .replaceAll(']}', ""));

      case 403:
        throw ForbidenIp(response.data.toString());

      case 404:
        dynamic responseJson = jsonDecode(response.data);
        throw UnauthorizedException(responseJson['email'][0].toString());

      default:
        throw FetchDataException(
            'Error occurred while communicating with server '
            'with status code {response.statusCode.toString()}');
    }
  }
}
