import 'package:asala_saudi/core/helpers/colors/colors.dart';
import 'package:asala_saudi/feature/model/product/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCard extends StatefulWidget {
 Product product;
   ProductCard({
    super.key,
    required this.product
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isLiked=false;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      //height: 155.h,
      width: 130.w,
      child: Card(
        color: AppColors.whiteColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
               imageUrl:  widget.product.image??"",
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 80.h,
              ),
            ),
            Expanded(
                child: Container(
                   margin: EdgeInsets.all(5.w),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                widget.product.name??"",
                                style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Colors.black87),
                                textDirection: TextDirection.rtl,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                overflow: TextOverflow.ellipsis,
                                widget.product.price??"",
                                style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Colors.black87),
                              ),

                            ],
                          ),
                      ),
                      Align(
                    alignment: Alignment.bottomLeft,
                    child: IconButton(
                      icon: Icon(
                        isLiked ? Icons.favorite:Icons.favorite_border,
                        color:  Colors.red ,
                        size: 24,
                      ),
                      onPressed:()=> setState(() {
                        isLiked=!isLiked;
                      }),
                    ),
                  ),
                    ],
                  ),
                ),

            ),
          ],
        ),
      ),
    );
  }
}
