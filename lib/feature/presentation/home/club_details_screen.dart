import 'package:asala_saudi/core/helpers/extentions/extentions.dart';
import 'package:asala_saudi/feature/model/club/club.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/colors/colors.dart';
import '../../../core/networking/data.dart';
import '../../model/club/club.dart';

class ClubDetailScreen extends StatelessWidget {
  final Club club ;

  const ClubDetailScreen(this.club);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 70.w,
                    margin: EdgeInsets.all(15.w),
                    child: Image.asset("assets/images/asala-main.png")),
                verticalSpace(10),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'my club',
                    style: TextStyle(
                      color: AppColors.mainAccentColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                verticalSpace(15),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
                    color: AppColors.appGrayColor,
                  ),
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl:  club.image??"",
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      verticalSpace(5),
                      Container(
                        height: 35.h,
                        margin: EdgeInsets.all(5.w),
                        child: Row(
                          children: [
                            Text(
                              '3.3K Members',
                              style:TextStyle(
                                color: AppColors.mainAccentColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            horizontalSpace(20),
                            SizedBox(
                              width:130.w ,
                              child: Text(
                                club.name??"",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: AppColors.mainAccentColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.notifications, color: Colors.green, size: 31),
                            horizontalSpace(10),
                            Icon(Icons.person_add, color: Colors.green, size: 30),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpace(20)   ,
                Container(
                  height: 60.h,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryAccentColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.black,
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:  [
                                Text(
                                  'I have a talent for sculpting that I want to share with you',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 14.sp, color: Colors.black,fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          '9:20 PM',
                          style: TextStyle(fontSize: 12, color: AppColors.blackColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
