import 'dart:async';

import 'package:asala_saudi/core/helpers/colors/colors.dart';
import 'package:asala_saudi/core/helpers/extentions/extentions.dart';
import 'package:asala_saudi/feature/model/category/category.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/networking/data.dart';
import '../../../core/routing/routing.dart';
import 'widgets/recomentation_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {

  int _currentImageIndex = 0;
  final List<String> _imageUrls = [
    "assets/images/carosol1.png",
    "assets/images/1.jpg",
    "assets/images/2.jpg",
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: 70.w,
                  margin: EdgeInsets.all(15.w),
                  child: Image.asset("assets/images/asala-main.png")),
              verticalSpace(10),
               Text(
                'let find your best talent',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.mainAccentColor,
                ),
              ),
              verticalSpace(8),
              CarouselSlider(
                options: CarouselOptions(
                  height: 120.h,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentImageIndex = index;
                    });
                  },
                ),
                items: _imageUrls.map((imageUrl) {
                  return Container(
                    margin: EdgeInsets.all(5.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.sp),
                      image: DecorationImage(
                        image: AssetImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
              ),
              verticalSpace(8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _imageUrls.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => setState(() => _currentImageIndex = entry.key),
                    child: Container(
                      width: 10.w,
                      height: 10.w,
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentImageIndex == entry.key ? Colors.green : Colors.grey,
                      ),
                    ),
                  );
                }).toList(),
              ),
              verticalSpace(15),
              //////
              SizedBox(
                height: 45.h,
                child: ListView.separated(
                  itemBuilder:
                    (context,index)=> ElevatedButton(
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        context.pushNamed(Routes.categoryDetailsScreen,arguments:  MyAppData.categories[index]);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainAccentColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                       children: [
                         CachedNetworkImage(
                          imageUrl:   MyAppData.categories[index].image??"",
                      placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                            width: index==0?25.w :30.w,),
                          horizontalSpace(7),
                          Text(MyAppData.categories[index].name??"", style: TextStyle(color: Colors.white,fontSize: 14.sp)),
                        ],
                      ),
                    ),
                    separatorBuilder:(context,index)=> horizontalSpace(10),
                    itemCount: MyAppData.categories.length,
                    scrollDirection: Axis.horizontal,
                ),
              ),

              verticalSpace(8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                    'Talents',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: AppColors.mainAccentColor,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child:  Text(
                      'see all',
                      style:TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.secondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpace(2.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(MyAppData.recommendations.products.length , (index) =>
                    RecommendationCard(
                      imageUrl: "https://asala.onrender.com${MyAppData.recommendations.products[index]?.image}",
                      name: MyAppData.recommendations.products[index]?.name ?? 'Maram the designer',
                    ),
                ),
              ),
            ),

          // [

                //   RecommendationCard(
                //     imageUrl: "assets/images/s.jpeg",
                //     name: 'Maram the designer',
                //   ),
                // ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
