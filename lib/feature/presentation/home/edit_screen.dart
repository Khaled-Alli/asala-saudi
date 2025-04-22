import 'package:asala_saudi/core/helpers/extentions/extentions.dart';
import 'package:asala_saudi/core/networking/data.dart';
import 'package:asala_saudi/core/networking/web_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/colors/colors.dart';
import '../../../core/routing/routing.dart';

class EditScreen extends StatefulWidget {


  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  @override
  Widget build(BuildContext context) {
     TextEditingController controller = TextEditingController();
    controller.text= MyAppData.user?.userName??"";
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: 360.w,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 70.w,
                    margin: EdgeInsets.all(15.w),
                    child: Image.asset("assets/images/asala-main.png")),
                verticalSpace(10),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.black,
                      child: Icon(Icons.person, color: Colors.white, size: 40),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.add, color: Colors.white, size: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "@${MyAppData.user?.userName}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
               verticalSpace(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildProfileButton("Edit profile",(){
                      HapticFeedback.lightImpact();
          
                      showDialog(
                        context: context,
                        builder: (dialogContext) =>
                            AlertDialog(
                              backgroundColor: Colors.white,
                              scrollable: true,
                              title: Text("edit user name ",),
                              content: SizedBox(
                                height: 100.h,
                                width: 300.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    verticalSpace(10),
          
                                  TextField(
                                    controller: controller,
                                    decoration: InputDecoration(
                                      hintText:"edit user name",
                                      //prefixIcon: const Icon(Icons.search, color: Colors.grey),
                                      filled: true,
                                      fillColor: Colors.grey.shade200,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                 verticalSpace(30),
          
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    HapticFeedback.lightImpact();
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "cancel",
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    HapticFeedback.lightImpact();
                                   await WebServices().editUser(controller.text);
                                   await WebServices().getUser();
                                    setState(() {
          
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Text("save",),
                                ),
                              ],
                            ),
                      );
          
          
          
          
          
                    }),
                    _buildProfileButton("add product",(){HapticFeedback.lightImpact();
                    context.pushNamed(Routes.addProductScreen);
                    }),
                  ],
                ),
                // GestureDetector(
                //   child: SizedBox(width: 300.w,
                //   height: 300.h,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Icon(Icons.add,size: 40,),
                //       horizontalSpace(10),
                //       Text("add product", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                //     ],
                //   ),),
                //   onTap: (){
                //     context.pushNamed(Routes.addProductScreen);
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildProfileButton(String text ,Function onPress) {
    return SizedBox(
      width: 130.w,
      child: ElevatedButton(
        onPressed: () =>onPress(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey.shade200,
          foregroundColor: Colors.black,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        child: Text(text, style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500)),
      ),
    );
  }
}
