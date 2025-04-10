import 'package:asala_saudi/core/helpers/colors/colors.dart';
import 'package:asala_saudi/core/networking/data.dart';
import 'package:asala_saudi/core/networking/web_services.dart';
import 'package:asala_saudi/feature/model/community/community.dart';
import 'package:asala_saudi/feature/presentation/home/edit_screen.dart';
import 'package:asala_saudi/feature/presentation/home/search_screen.dart';
import 'package:asala_saudi/feature/presentation/home/shopping_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'community_Details_screen.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 2;
  WebServices webServices=WebServices();
   List<Widget> _pages = [
    // const SearchScreen(),
    // const EditScreen(),
    // const HomeScreen(),
    // const ShoppingScreen(),
    //  CommunityDetailScreen(MyAppData.communities[0]),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  void initState() {

      Future.microtask(() async {

        await webServices.getCategory();
        await webServices.getRecommendations();
        await webServices.getProducts();
        await webServices.getClubs();
        await webServices.getCommunities();
        await webServices.getUser();

        _pages = [
          const SearchScreen(),
          const EditScreen(),
          const HomeScreen(),
          const ShoppingScreen(),
          MyAppData.communities.isNotEmpty
              ? CommunityDetailScreen(MyAppData.communities[0])
              : const Placeholder(),
        ];

        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      MyAppData.categories.isEmpty? Center(child: CircularProgressIndicator(color: AppColors.mainColor,)):
      _pages[_selectedIndex],
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 15.h, left: 40.w, right: 40.w),
        height: 60.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
        decoration: BoxDecoration(
          color: AppColors.mainAccentColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _navItem(Icons.search, 0),
            _navItem(Icons.edit_outlined, 1),
            _navItem(Icons.home, 2),
            _navItem(Icons.shopping_cart, 3),
            _navItem(Icons.groups, 4),
          ],
        ),
      ),
    );
  }
  Widget _navItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Icon(
        icon,
        color: _selectedIndex == index ? Colors.white : Colors.white38,
        size: 30.sp,
      ),
    );
}}

