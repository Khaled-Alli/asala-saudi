import 'dart:io';

import 'package:asala_saudi/core/networking/data.dart';
import 'package:asala_saudi/feature/model/club/club.dart';
import 'package:asala_saudi/feature/model/community/community.dart';
import 'package:asala_saudi/feature/model/product/product.dart';
import 'package:asala_saudi/feature/model/recommendation/recommendation.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../feature/model/category/category.dart';
import '../../feature/model/user/user.dart';
import 'auth_services.dart';

class ApiService {
  final Dio _dio = Dio();
  final AuthService _authService = AuthService();

  ApiService() {
    _dio.options.baseUrl = 'https://asala.onrender.com/api/';
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final accessToken = await _authService.getAccessToken();
        if (accessToken != null) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        if (e.response?.statusCode == 401) {
          bool refreshed = await _authService.refreshAccessToken();
          if (refreshed) {
            final newToken = await _authService.getAccessToken();
            e.requestOptions.headers['Authorization'] = 'Bearer $newToken';
            final clonedRequest = await _dio.fetch(e.requestOptions);
            return handler.resolve(clonedRequest);
          } else {
            await _authService.logout();
            _navigateToLogin();
          }
        }
        return handler.next(e);
      },
    ));
  }

  void _navigateToLogin() {
    final navigatorKey = GlobalKey<NavigatorState>();
    navigatorKey.currentState?.pushNamedAndRemoveUntil('/login', (route) => false);
  }

  Future<void> join(String endpoint) async {
    try {
      await _dio.post(endpoint);
    } catch (e) {
      print('API Error: $e  ********************');

    }
  }

  Future<void> purchaseProduct(String endpoint) async {
    try {
      await _dio.post(endpoint);
    } catch (e) {
      print('API Error: $e  ********************');

    }
  }

  Future<void> editUser(String endpoint, Map<String,dynamic> json) async {
    try {
      await _dio.patch(endpoint,data: json);
    } catch (e) {
      print('API Error: $e  ********************');

    }
  }

  Future<void> getCategories() async {
    try {
      Response response = await _dio.get(
        "categories/");

      if (response.statusCode == 200 || response.statusCode == 201) {
        MyAppData.categories = (response.data as List)
            .map((item) => Category.fromJson(item))
            .toList();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getCommunities() async {
    try {
      Response response = await _dio.get(
        "communities/");
      if (response.statusCode == 200 || response.statusCode == 201) {
        MyAppData.communities = (response.data as List)
            .map((item) => Community.fromJson(item))
            .toList();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getClubs() async {
    try {
      Response response = await _dio.get(
        "clubs/");
      if (response.statusCode == 200 || response.statusCode == 201) {
        MyAppData.clubs = (response.data as List)
            .map((item) => Club.fromJson(item))
            .toList();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getProducts() async {
    try {
      Response response = await _dio.get(
        "products/");
      if (response.statusCode == 200 || response.statusCode == 201) {
        MyAppData.products = (response.data as List)
            .map((item) => Product.fromJson(item))
            .toList() ;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getRecommendations() async {
    // try {
      Response response = await _dio.get(
        "recommendations/");
      if (response.statusCode == 200 || response.statusCode == 201) {
        MyAppData.recommendations =  Recommendation.fromJson(response.data) ;
      }
    // } catch (e) {
    //   print(e);
    // }
  }

  Future<void> getUser() async {
    try {
      Response response = await _dio.get(
        "users/me/");
      if (response.statusCode == 200 || response.statusCode == 201) {
        MyAppData.user =  User.fromJson(response.data ) ;
        print("${MyAppData.user?.id} ****************** ");
      }
    } catch (e) {
      print(e);
    }
  }

  // Future<void> addProduct(Map<String,dynamic> json) async {
  //   try {
  //     Response response = await _dio.post(
  //       "products/",data: json);
  //       MyAppData.user =  User.fromJson(response.data ) ;
  //
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  Future<void> addProduct({
    required String productName,
    required String productDescription,
    required double productPrice,
    required int categoryId,
    required File imageFile,
  }) async {
    // Create a FormData object
    FormData formData = FormData.fromMap({
      "name": productName,
      "description": productDescription,
      "price": productPrice.toStringAsFixed(2),
      "category": categoryId,
      "image": await MultipartFile.fromFile(imageFile.path, filename: imageFile.path.split('/').last),
    });

    try {
      // Make the request
      Response response = await _dio.post("products/",data: formData);
      print('Product added: ${response.data}');
      print('Error: ${response.data}');

    } catch (e) {
      print('Error adding product: $e');
      if (e is DioException) {
        print('Status Code: ${e.response?.statusCode}');
        print('Error Data: ${e.response?.data}');
      } else {
        print('Unknown Error: $e');
      }

  }
  }


}
