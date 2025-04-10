import 'package:asala_saudi/core/helpers/colors/colors.dart';
import 'package:asala_saudi/feature/presentation/home/product_details_screen.dart';
import 'package:asala_saudi/feature/presentation/home/widgets/cart_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/extentions/extentions.dart';
import '../../../core/networking/data.dart';
import '../../model/product/product.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  @override
  _ShoppingScreenState createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  List<bool> isLikedList = List<bool>.filled(6, false);


  @override
  Widget build(BuildContext context) {
print(MyAppData.user!.purchasedProduct!.length);
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
                SizedBox(
                  height: 490.h,
                  child: SizedBox(
                    height: 220.h,
                    child: Column(children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "purchased products",
                        style: TextStyle(
                          color: AppColors.mainAccentColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    SizedBox(
                      height: 158.h,
                      child: ListView.separated(
                        itemBuilder:
                            (context,i)=>   GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailScreen(
                                    product:   MyAppData.user!.purchasedProduct![i]
                                ),
                              ),
                            );

                          },
                          child: ProductCard(
                              product:MyAppData.user!.purchasedProduct![i]
                          ),
                        ),
                        separatorBuilder:(context,i)=> horizontalSpace(10),
                        itemCount: MyAppData.user!.purchasedProduct!.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ],
                  ),),

                ),
                // Align(
                //   alignment: Alignment.topLeft,
                //   child: Text(
                //     'Drawings',
                //     style: TextStyle(
                //       color: AppColors.mainAccentColor,
                //       fontSize: 18.sp,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
                // SizedBox(height: 10.h),
                // SizedBox(
                //   height: 158.h,
                //   child: ListView.separated(
                //     itemBuilder:
                //         (context,index)=>   GestureDetector(
                //           onTap: (){
                //             Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                 builder: (context) => ProductDetailScreen(
                //                    product:  MyAppData.products[index]
                //                 ),
                //               ),
                //             );
                //
                //           },
                //           child: ProductCard(
                //               product:  MyAppData.products[index]
                //           ),
                //         ),
                //     separatorBuilder:(context,index)=> horizontalSpace(10),
                //     itemCount: MyAppData.products.length,
                //     scrollDirection: Axis.horizontal,
                //   ),
                // ),
                // SizedBox(height: 20.h),
                // Align(
                //   alignment: Alignment.topLeft,
                //   child: Text(
                //     'Sculpture',
                //     style: TextStyle(
                //       color: AppColors.mainAccentColor,
                //       fontSize: 18.sp,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 10),
                // SizedBox(
                //   height: 158.h,
                //   child: ListView.separated(
                //     itemBuilder:
                //         (context,index)=>   GestureDetector(
                //       onTap: (){
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) => ProductDetailScreen(
                //                 product:  MyAppData.products[index]
                //             ),
                //           ),
                //         );
                //
                //       },
                //       child: ProductCard(
                //           product:  MyAppData.products[index]
                //       ),
                //     ),
                //     separatorBuilder:(context,index)=> horizontalSpace(10),
                //     itemCount: MyAppData.products.length,
                //     scrollDirection: Axis.horizontal,
                //   ),
                // ),
                // GridView.count(
                //   crossAxisCount: 3,
                //   shrinkWrap: true,
                //   physics: const NeverScrollableScrollPhysics(),
                //   mainAxisSpacing: 10,
                //   crossAxisSpacing: 10,
                //   children: [
                //     ProductCard(
                //       imagePath: "assets/images/carosol1.png",
                //       title: 'نحت أبداعي',
                //       price: '300 SAR',
                //       isLiked: isLikedList[3],
                //       onLikeToggle: () {
                //         setState(() {
                //           isLikedList[3] = !isLikedList[3];
                //         });
                //       },
                //       onTap: () {
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) => ProductDetailScreen(
                //               imagePath: "assets/images/carosol1.png",
                //               title: 'نحت أبداعي',
                //               price: '300 SAR',
                //               rating: 4,
                //             ),
                //           ),
                //         );
                //       },
                //     ),
                //     ProductCard(
                //       imagePath: "assets/images/carosol1.png",
                //       title: 'نحت صحن',
                //       price: '250 SAR',
                //       isLiked: isLikedList[4],
                //       onLikeToggle: () {
                //         setState(() {
                //           isLikedList[4] = !isLikedList[4];
                //         });
                //       },
                //       onTap: () {
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) => ProductDetailScreen(
                //               imagePath: "assets/images/carosol1.png",
                //               title: 'نحت صحن',
                //               price: '250 SAR',
                //               rating: 4,
                //             ),
                //           ),
                //         );
                //       },
                //     ),
                //     ProductCard(
                //       imagePath: "assets/images/carosol1.png",
                //       title: 'نحت فانوس',
                //       price: '250 SAR',
                //       isLiked: isLikedList[5],
                //       onLikeToggle: () {
                //         setState(() {
                //           isLikedList[5] = !isLikedList[5];
                //         });
                //       },
                //       onTap: () {
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) => ProductDetailScreen(
                //               imagePath: "assets/images/carosol1.png",
                //               title: 'نحت فانوس',
                //               price: '250 SAR',
                //               rating: 4,
                //             ),
                //           ),
                //         );
                //       },
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
