import 'package:asala_saudi/core/helpers/colors/colors.dart';
import 'package:asala_saudi/core/networking/web_services.dart';
import 'package:asala_saudi/feature/model/product/product.dart';
import 'package:asala_saudi/feature/presentation/home/widgets/payment_method_BSH.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/extentions/extentions.dart';

class ProductDetailScreen extends StatefulWidget {
Product product;

   ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: 70.w,
                  margin: EdgeInsets.all(15.w),
                  child: Image.asset("assets/images/asala-main.png")),

              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color:AppColors.mainAccentColor),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              verticalSpace(10),
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: CachedNetworkImage(
               imageUrl:   widget.product.image??"",
                  height: 200.h,
                  width: double.infinity,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
              verticalSpace(10),
              Text(
                widget.product.name??"",
                style: const TextStyle(fontSize: 16, color: Colors.black),
                textDirection: TextDirection.rtl,
              ),
              verticalSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(
                     5,// product.rating,
                          (index) => Icon(
                        Icons.star,
                        color: index < 4//product.rating
                            ? Colors.yellow : Colors.grey,
                        size: 25,
                      ),
                    ),
                  ),
                  const Text(
                    '145 reviews',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              verticalSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.shopping_cart, color: Colors.green),
                      const SizedBox(width: 5),
                      const Icon(Icons.favorite, color: Colors.red),
                    ],
                  ),
                  Text(
                    widget.product.price??"",
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ],
              ),
              verticalSpace(25),
              Center(
                child: ElevatedButton(
                  onPressed: () async{
                     HapticFeedback.lightImpact();
                     showModalBottomSheet(
                         context: context,
                         shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(16)),
                         builder: (context) {
                           return  PaymentMethodsBottomSheet( widget.product) ;
                         });
                    // await WebServices().purchaseProduct(widget.product.id!);
                    // await WebServices().getUser();
                    // setState((){
                    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم الشراء بنجاح!')),);
                    // });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Buy Now',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
