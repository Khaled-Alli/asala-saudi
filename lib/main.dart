import 'package:asala_saudi/asala_saudi.dart';
import 'package:asala_saudi/core/networking/data.dart';
import 'package:asala_saudi/core/routing/routing.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'core/networking/auth_services.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await openDatabase('my_db.db');
  String initialRoute = await getInitialRoute();

  runApp( AsalaSaudi(appRouter: AppRouter(),initialRoute: initialRoute));
}
Future<String> getInitialRoute() async {
  final AuthService authService = AuthService();
  final String? accessToken = await authService.getAccessToken();
  MyAppData.user= await authService.getLocalUser();
  return (accessToken != null) ? Routes.layoutScreen : Routes.loginScreen;

}