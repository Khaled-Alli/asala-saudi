import 'package:asala_saudi/core/helpers/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/helpers/constants/constants.dart';
import 'core/routing/routing.dart';



class AsalaSaudi extends StatelessWidget {
   final AppRouter appRouter;
   final String initialRoute;
  AsalaSaudi({
    super.key,
    required this.appRouter,
    required this.initialRoute,
  });

  // User? user;

  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
        minTextAdapt: true,
        builder: (context, child) {
          return
            // FutureBuilder(
            //   future: getIt<LocalServices>().getUser(ServicesConstants.USER_TEXT,),
            //   builder: (context, AsyncSnapshot<dynamic> snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return const Center(
            //           child: CircularProgressIndicator(
            //         color: AppColors.mainColor,
            //       ));
            //     }
            //     if (snapshot.hasData && snapshot.data != null) {
            //       user = snapshot.data;
            //     }
            //     return
                MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: AppConstants.APP_NAME,
                 theme:  ThemeData(
                    primaryColor: AppColors.mainColor,
                    scaffoldBackgroundColor: AppColors.appWhiteColor,
                  ),
                  initialRoute: initialRoute,//Routes.loginScreen, //user != null ? Routes.homeScreen : Routes.loginScreen,
                  onGenerateRoute: appRouter.generateRoute,
                );

              // });
        });
  }
}
