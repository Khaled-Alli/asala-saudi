import 'dart:io';

import 'package:asala_saudi/core/networking/api_services.dart';
import 'package:asala_saudi/core/networking/auth_services.dart';
import 'package:asala_saudi/core/networking/data.dart';

import '../../feature/model/user/user.dart';

class WebServices {
  AuthService authService =AuthService();
  ApiService apiService =ApiService();

Future<String> register(User userInfo,String password) async{
  return await authService.register(userInfo, password);

}

Future<bool> login(String userName,String password) async{
  return await authService.login(userName, password);
}

Future<void> getCategory() async{
  return await apiService.getCategories();
}
Future<void> getRecommendations() async{
  return await apiService.getRecommendations();
}
Future<void> getProducts() async{
  return await apiService.getProducts();
}
Future<void> getClubs() async{
  return await apiService.getClubs();
}
Future<void> getCommunities() async{
  return await apiService.getCommunities();
}
Future<void> getUser() async{
  return await apiService.getUser();
}

Future<void> joinCommunity (int communityID)async{
 await apiService.join("communities/$communityID/join/");
}

Future<void> joinClub (int clubID)async{
 await apiService.join("clubs/$clubID/join/");
}

Future<void> purchaseProduct (int productID)async{
 await apiService.purchaseProduct("products/$productID/purchase/");
}

Future<void> editUser (String userName)async{
 await apiService.editUser("users/me/",{"username":userName});
}

Future<void> addProduct ({
  required String productName,
  required String productDescription,
  required double productPrice,
  required int categoryId,
 required File imageFile,
})async{
  if (imageFile == null) {
    print('*********** Image file is null. Please select an image.');
    return;
  }
 await apiService.addProduct(
   productName: productName,
     productDescription :productDescription,
     productPrice :productPrice,
     categoryId: categoryId,
     imageFile:imageFile,
); }
}


