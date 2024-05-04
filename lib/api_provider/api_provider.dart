import 'dart:convert';

import 'package:cowlar_design_task/models/get_movie_trailer_model.dart';
import 'package:cowlar_design_task/models/movie_detail_model.dart';
import 'package:cowlar_design_task/models/upcoming_movie_model.dart';
import 'package:dio/dio.dart';

import '../config/const_url.dart';

class ApiProvider {
  late Response response;
  String apiKey = "5e0fbb7ee2fae495cf56bc8b78f3cb44";

  Future<Response> dioConnect(
    String url,
    dynamic data,
    String apiType,
    String contentType,
    String apiKey,
  ) async {
    Dio dio = Dio();
    print('url : $url');
    print('postData : ${jsonEncode(data.toString())}');
    print('apiType : $apiType');
    print('contentType : $contentType');
    print('apiKey : $apiKey'); // Print the API key

    try {
      dio.options.connectTimeout = const Duration(milliseconds: 15000);
      dio.options.receiveTimeout = const Duration(milliseconds: 15000);

      if (contentType == 'form') {
        dio.options.headers['content-Type'] =
            'application/x-www-form-urlencoded';
      } else {
        dio.options.headers['content-Type'] = 'application/json';
      }

      // Add API key to headers
      dio.options.queryParameters['api_key'] = apiKey;

      if (apiType == 'get') {
        return await dio.get(url);
      } else if (apiType == 'post') {
        return await dio.post(url, data: data);
      } else if (apiType == 'put') {
        return await dio.put(url, data: data);
      } else {
        return await dio.delete(url, data: data);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        int? statusCode = e.response?.statusCode;
        if (statusCode == 401) {
          // Re-attempt the API call
          return await dioConnect(url, data, apiType, contentType, apiKey);
        } else if (statusCode == 404) {
          throw Exception("Api not found");
        } else if (statusCode == 400) {
          throw Exception("Internal Server Error");
        } else {
          throw Exception(e.error.toString());
        }
      } else if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception(e.message.toString());
      } else if (e.type == DioExceptionType.connectionError) {
        // Handle connection error (e.g., host lookup failures)
        throw DioException(
          requestOptions: e.requestOptions,
          response: Response(
            requestOptions: e.requestOptions,
            statusCode:
                -1, // You can use a custom status code for connection errors
          ),
          type: DioExceptionType.connectionError,
          // Use a custom error type for connection errors
          error:
              "Connection error. Please ensure you have a network connection.",
        );
      } else if (e.type == DioExceptionType.cancel) {
        throw Exception('Cancel Request');
      }
      throw Exception("Connection Error");
    } finally {
      dio.close();
    }
  }

  Future<UpcomingMovieModel> fetchUpcomingMovie() async {
    try {
      response =
          await dioConnect(upcomingMovieApi, null, 'get', 'json', apiKey);

      print(jsonEncode(response.toString()));

      if (response.statusCode == 200) {
        // Status code 200 means success
        UpcomingMovieModel listData =
            UpcomingMovieModel.fromJson(response.data);
        return listData;
      } else {
        // Handle non-200 status codes
        throw Exception(
            "API request failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      // Handle DioError or other exceptions
      throw Exception("Failed to fetch upcoming movies: $e");
    }
  }

  Future<MovieDetailModel> fetchMovieDetailById(String iD) async {
    try {
      response =
          await dioConnect(movieDetailApi + iD, null, 'get', 'json', apiKey);

      print(jsonEncode(response.toString()));

      if (response.statusCode == 200) {
        // Status code 200 means success
        MovieDetailModel listData = MovieDetailModel.fromJson(response.data);
        return listData;
      } else {
        // Handle non-200 status codes
        throw Exception(
            "API request failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      // Handle DioError or other exceptions
      throw Exception("Failed to fetch upcoming movies: $e");
    }
  }

  Future<MovieTrailerModel> fetchMovieTrailerById(String iD) async {
    try {
      response = await dioConnect(
          "https://api.themoviedb.org/3/movie/$iD/videos",
          null,
          'get',
          'json',
          apiKey);

      print(jsonEncode(response.toString()));

      if (response.statusCode == 200) {
        // Status code 200 means success
        MovieTrailerModel listData = MovieTrailerModel.fromJson(response.data);
        return listData;
      } else {
        // Handle non-200 status codes
        throw Exception(
            "API request failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      // Handle DioError or other exceptions
      throw Exception("Failed to fetch upcoming movies: $e");
    }
  }
}
