



import 'package:asala_saudi/core/networking/data.dart';
import 'package:asala_saudi/feature/model/auth_response.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../feature/model/user/user.dart';

class AuthService {


  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://asala.onrender.com/api/', // Replace with actual API URL
      // connectTimeout: const Duration(seconds: 10),
      // receiveTimeout: const Duration(seconds: 10),
    ),
  );

  /// **Register User**
  Future<String> register(User userInfo,String password) async {
    try {
      Response response = await _dio.post(
        'auth/register/',
        data: {
          "username": userInfo.userName,
          "email": userInfo.email,
          "password": password,
          "full_name": userInfo.fullName,
          "specialization": userInfo.specialization
        },
      );
      if(response.statusCode == 201){
        print(response.data["user"]);
        return response.data["message"];
      }else if (response.statusCode == 400){ return response.data["message"];}
      else{
        return 'Registration Error';
      }
       // Success
    } catch (e) {
      print('Registration Error: $e');
      return 'Registration Error: $e';
    }
  }

  /// **Login User & Store Tokens**
  Future<bool> login(String userName, String password) async {
    try {
      Response response = await _dio.post(
        'auth/login/',
        data: {'username': userName, 'password': password},
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      );
      print("*********************** ${response.toString()} ****************************");

      if (response.statusCode == 200) {
        final data = response.data;
        await _saveTokens(data['access'], data['refresh']);
        await _saveUserLocal(User.fromJson(data["user"]));
        MyAppData.user = User.fromJson(data["user"]);
        print("*********************** ${MyAppData.user.toString()} ****************************");
        MyAppData.userTokens = AuthResponse.fromJson(data);
        print("*********************** ${MyAppData.userTokens.toString()} ****************************");
        return true;
      } else if (response.statusCode == 400) {
        print("*********************** Bad Request (400) ****************************");
        print("Response Data: ${response.data}");
        return false;
      } else if (response.statusCode == 401) {
        print("*********************** Unauthorized (401) ****************************");
        print("Response Data: ${response.data}");
        return false;
      } else if (response.statusCode == 500) {
        print("*********************** Server Error (500) ****************************");
        print("Response Data: ${response.data}");
        return false;
      } else {
        print("*********************** Other Error: ${response.statusCode} ****************************");
        print("Response Data: ${response.data}");
        return false;
      }

    } catch (e) {
      print('Login Error: $e');
      return false;
    }
    return false; // This should ideally not be reached if all status codes are handled
  }

  /// **Save Tokens Locally**
  Future<void> _saveTokens(String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', accessToken);
    await prefs.setString('refresh_token', refreshToken);
  }

  Future<void> _saveUserLocal(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userID', user.id??0);
    await prefs.setString('userNane', user.userName??"");
    await prefs.setString('fullNane', user.fullName??"");
    await prefs.setString('email', user.email??"");
    await prefs.setString('specialization', user.specialization??"");
    // await prefs.set('joined_communities', user.communities??[]);
    // await prefs.setString('joined_clubs', user.specialization??"");
    // await prefs.setString('purchased_products', user.specialization??"");
  //  await prefs.setString('refresh_token', refreshToken);
  }

  Future<User> getLocalUser() async {
    final prefs = await SharedPreferences.getInstance();
   return User(
     prefs.getInt('userID')??0,
     prefs.getString('userNane')??"",
     prefs.getString('fullNane')??"",
     prefs.getString('email')??"",
     prefs.getString('specialization')??"",[],[],[]);
  }

  /// **Get Access Token**
  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  /// **Get Refresh Token**
  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('refresh_token');
  }

  /// **Logout**
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
  }

  /// **Refresh Token**
  Future<bool> refreshAccessToken() async {
    final refreshToken = await getRefreshToken();
    if (refreshToken == null) return false;

    try {
      Response response = await _dio.post(
        '/refresh/',
        data: {'refresh': refreshToken},
      );

      if (response.statusCode == 200) {
        await _saveTokens(response.data['access'], response.data['refresh']);
        // MyAppData.userTokens = AuthResponse(accessToken: response.data['access_token'], refreshToken: response.data['refresh_token']) ;
        return true;
      }
      return false;
    } catch (e) {
      print('Token Refresh Error: $e');
      return false;
    }
  }
}
//
// {
// "username": "john_doe209",
// "password": "yourStrongPassword"
// }