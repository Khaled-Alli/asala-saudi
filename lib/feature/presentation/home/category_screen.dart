import 'package:asala_saudi/core/helpers/colors/colors.dart';
import 'package:asala_saudi/feature/presentation/home/product_details_screen.dart';
import 'package:asala_saudi/feature/presentation/home/widgets/cart_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/extentions/extentions.dart';
import '../../../core/networking/data.dart';
import '../../model/product/product.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<bool> isLikedList = List<bool>.filled(6, false);
  //List<Product> products = [];

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
                SizedBox(
                  height: 490.h,
                  child: ListView.builder(itemBuilder: (contect,index)=> SizedBox(
                    height: 220.h,
                    child: Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          MyAppData.categories[index].name??"",
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
                                      product:   MyAppData.categories[index].products[i]!
                                  ),
                                ),
                              );

                            },
                            child: ProductCard(
                                product: MyAppData.categories[index].products[i]!
                            ),
                          ),
                          separatorBuilder:(context,index)=> horizontalSpace(10),
                          itemCount: MyAppData.categories[index].products.length,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    ],
                    ),),itemCount: MyAppData.categories.length , ),
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
