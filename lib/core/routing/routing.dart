import 'package:asala_saudi/feature/model/community/community.dart';
import 'package:asala_saudi/feature/presentation/home/community_Details_screen.dart';
import 'package:asala_saudi/feature/presentation/home/layout_screen.dart';
import 'package:asala_saudi/feature/presentation/home/share_screen.dart';
import 'package:asala_saudi/feature/presentation/home/add_product_screen.dart';
import 'package:asala_saudi/feature/presentation/home/widgets/category_products.dart';
import 'package:flutter/material.dart';

import '../../feature/model/category/category.dart';
import '../../feature/model/club/club.dart';
import '../../feature/presentation/auth/login_screen.dart';
import '../../feature/presentation/auth/register_screen.dart';
import '../../feature/presentation/home/club_details_screen.dart';


class Routes {

  static const loginScreen = '/login';
  static const registerScreen = '/register';
  static const layoutScreen = '/layout';
  static const shareScreen = '/share';
  static const communityDetailsScreen = '/communityDetails';
  static const clubDetailsScreen = '/clubDetails';
  static const categoryDetailsScreen = '/categoryDetails';
  static const addProductScreen = '/addProduct';
}


class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = settings.arguments;

    switch (settings.name) {
        case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
        case Routes.registerScreen:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );
        case Routes.layoutScreen:
        return MaterialPageRoute(
          builder: (_) => const MainScreen(),
        );
        case Routes.shareScreen:
        return MaterialPageRoute(
          builder: (_) => const ShareScreen(),
        );
        case Routes.communityDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => CommunityDetailScreen( arguments as Community),
        );
        case Routes.clubDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => ClubDetailScreen(arguments as Club ),
        );
        case Routes.categoryDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => CategoryProductsScreen(arguments as Category ),
        );
        case Routes.addProductScreen:
        return MaterialPageRoute(
          builder: (_) => AddProductScreen(),
        );

      default:
        return null;
    }
  }
}


// class AppRouterr {
//   AppRouterr();
//   static GoRouter router = GoRouter(
//     initialLocation: context.read<AuthCubit>().user != null ? Routes.homeScreen : Routes.loginScreen,
//     routes: [
//       GoRoute(
//       path:  Routes.loginScreen,
//       builder: (context, state) =>  const LoginScreen(),
//     ),
//       GoRoute(
//         path: Routes.homeScreen,
//         builder: (context, state) => const HomeScreen(),
//       ),
//       GoRoute(
//         path: Routes.laptopDetailsScreen,
//         builder: (context, state) =>LaptopDetailsScreen(state.extra as Laptop)
//       ),
//     ],
//   );
// }
