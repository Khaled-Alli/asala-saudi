import 'package:asala_saudi/feature/model/auth_response.dart';
import 'package:asala_saudi/feature/model/category/category.dart';
import 'package:asala_saudi/feature/model/club/club.dart';
import 'package:asala_saudi/feature/model/community/community.dart';
import 'package:asala_saudi/feature/model/product/product.dart';
import 'package:asala_saudi/feature/model/user/user.dart';

import '../../feature/model/recommendation/recommendation.dart';


class MyAppData {
  static final MyAppData _instance = MyAppData._internal();

  MyAppData._internal();

  factory MyAppData() {
    return _instance;
  }

  static AuthResponse? userTokens;
  static User? user;
  static List<Category> categories = [];
  static List<Product> products = [

    Product(1,'لوحة ألهام','لوحة ألهام', "assets/images/carosol1.png", '500 SAR'),

    Product(1,'لوحة ألهام','لوحة ألهام', "assets/images/carosol1.png", '500 SAR'),

    Product(1,'لوحة ألهام','لوحة ألهام', "assets/images/carosol1.png", '500 SAR'),

    Product(1,'لوحة ألهام','لوحة ألهام', "assets/images/carosol1.png", '500 SAR'),

  ];
  static List<Club> clubs = [];
  static List<Community> communities = [];
  static Recommendation recommendations = Recommendation([], [], []);
}
