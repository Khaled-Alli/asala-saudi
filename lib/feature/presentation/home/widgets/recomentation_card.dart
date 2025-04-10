import 'package:asala_saudi/core/helpers/colors/colors.dart';
import 'package:asala_saudi/core/helpers/extentions/extentions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecommendationCard extends StatelessWidget {
  final String imageUrl;
  final String name;

  const RecommendationCard({required this.imageUrl, required this.name, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.w,
      height: 185.h,
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide.none,
        ),
        color: AppColors.secondaryAccentColor,
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                   imageUrl:  imageUrl,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    height: 130.h,
                    width: 155.w,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 70.w,
                      height: 35.h,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(16),
                                              ),
                    child: Container(
                      child: Icon(Icons.favorite,color: Colors.red,),
                    ),
                    )),
              ],
            ),
            Expanded(
              child: Center(
                child: Text(
                  name,
                  style:  TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.mainColor,
                  ),textAlign: TextAlign.center,
                ),
              ),
            ),
            // IconButton(
            //   icon: const Icon(Icons.favorite, color: Colors.red),
            //   onPressed: () {},
            // ),
          ],
        ),
      ),
    );
  }
}
