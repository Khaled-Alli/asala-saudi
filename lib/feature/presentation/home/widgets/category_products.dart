import 'package:asala_saudi/core/helpers/colors/colors.dart';
import 'package:asala_saudi/feature/model/category/category.dart';
import 'package:asala_saudi/feature/presentation/home/product_details_screen.dart';
import 'package:asala_saudi/feature/presentation/home/widgets/cart_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/extentions/extentions.dart';
import '../../../../core/networking/data.dart';
import '../../../model/product/product.dart';


class CategoryProductsScreen extends StatefulWidget {
  final Category category;
  const CategoryProductsScreen(this.category);

  @override
  _CategoryProductsScreenState createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {

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
                  child:
                      SizedBox(
                    height: 220.h,
                    child: Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.category.name??"",
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
                                      product:   widget.category.products[i]!
                                  ),
                                ),
                              );

                            },
                            child: ProductCard(
                                product: widget.category.products[i]!
                            ),
                          ),
                          separatorBuilder:(context,index)=> horizontalSpace(10),
                          itemCount: widget.category.products.length,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    ],
                    ),)
                   ,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
