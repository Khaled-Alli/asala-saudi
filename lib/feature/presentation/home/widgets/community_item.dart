import 'package:asala_saudi/core/helpers/colors/colors.dart';
import 'package:asala_saudi/core/networking/data.dart';
import 'package:asala_saudi/core/networking/web_services.dart';
import 'package:asala_saudi/feature/model/category/category.dart';
import 'package:asala_saudi/feature/model/user/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommunityItem extends StatefulWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;
  final Future<void> Function() onJoin;
   bool isJoined;

   CommunityItem({
    required this.title,
    required this.imageUrl,
    required this.onTap,
    required this.onJoin,
    required this.isJoined,
    super.key,
  });

  @override
  _CommunityItemState createState() => _CommunityItemState();
}

class _CommunityItemState extends State<CommunityItem> {
  // late bool isJoined;

  // @override
  // void initState() {
  //   super.initState();
  //   isJoined = widget.isJoined.any((item) {
  //       return item?.id == MyAppData.user?.id;
  //   });
  //   print("isJoined.toString()");
  //   print(isJoined.toString());
  // }

  @override
  Widget build(BuildContext context) {
    print(widget.isJoined.toString());
    return SizedBox(
      height: 60.h,
      child: Card(
        color: AppColors.appWhiteColor,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: InkWell(
          onTap: widget.onTap,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Community Image
              CircleAvatar(
                radius: 30,
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: widget.imageUrl,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Community Name
              Expanded(
                child: Center(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      color: Colors.green[800],
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Joining Button
              // ElevatedButton.icon(
              //   onPressed: () async{
              //     setState(() async {
              //      await widget.onJoin.then((text){
              //        if (isJoined) {
              //          ScaffoldMessenger.of(context).showSnackBar(
              //            const SnackBar(content: Text('تم الانضمام بنجاح!')),
              //          );
              //        }else{
              //          ScaffoldMessenger.of(context).showSnackBar(
              //            const SnackBar(content: Text('تم الخروج بنجاح!')),
              //          );
              //        }
              //      });
              //       isJoined = !isJoined;
              //     });
              //     // if (isJoined) {
              //     //   ScaffoldMessenger.of(context).showSnackBar(
              //     //     const SnackBar(content: Text('تم الانضمام بنجاح!')),
              //     //   );
              //     // }
              //   },
              //   icon: Icon(isJoined ? Icons.check : Icons.add,
              //       color: Colors.black, size: 16),
              //   label: Text(isJoined ? 'Joined' : 'Joining',
              //       style: TextStyle(color: Colors.black)),
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: isJoined
              //         ? AppColors.appGrayColor
              //         : AppColors.secondaryAccentColor,
              //     elevation: 0,
              //     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //   ),
              // ),
              ElevatedButton.icon(
                onPressed: () async {
                  try {
                    setState(() {
                    widget.isJoined = !widget.isJoined;
                  });
                    widget.isJoined?
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم الانضمام بنجاح!')),
                    ): ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم الخروج بنجاح!')),
                    );
                  await widget.onJoin() ;
                  await  WebServices().getCommunities();
                  await  WebServices().getClubs();


                  } catch (e) {
                        print(e);
                  }
                },
                icon: Icon(widget.isJoined ? Icons.check : Icons.add,
                    color: Colors.black, size: 16),
                label: Text(widget.isJoined ? 'Joined' : 'Join',
                    style: TextStyle(color: Colors.black)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.isJoined
                      ? AppColors.appGrayColor
                      : AppColors.secondaryAccentColor,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              const SizedBox(width: 8),
              // Bookmark Icon
              Icon(
                Icons.bookmark,
                color: AppColors.secondaryColor,
                size: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
