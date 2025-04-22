import 'dart:io';

import 'package:asala_saudi/core/networking/data.dart';
import 'package:asala_saudi/feature/model/category/category.dart';
import 'package:asala_saudi/feature/presentation/auth/widgets/app_text_form_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import '../../../core/helpers/colors/colors.dart';
import '../../../core/helpers/extentions/extentions.dart';
import '../../../core/networking/web_services.dart';
import '../../../core/routing/routing.dart';
import '../../model/user/user.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
 // final TextEditingController productTitleController = TextEditingController();
  final TextEditingController productDescriptionController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  final TextEditingController productSpecializationController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final WebServices webServices = WebServices();
  final ImagePicker _picker = ImagePicker();
  File? _imgFile;
  Future<void> takeSnapshot() async {
    final XFile? img = await _picker.pickImage(
      source: ImageSource.gallery, // alternatively, use ImageSource.gallery
      maxWidth: 400,
    );
    if (img == null) return;
    setState(() {
      _imgFile = File(img.path); // convert it to a Dart:io file
    });
  }

  int getCategoryId(String category) {
    try {
      return MyAppData.categories.firstWhere((item) => item.name == category).id!;
    } catch (e) {
      return 0; // Return 0 if the category is not found
    }
  }
  Future<String> convertFile(File imageFile) async {
    List<int> imageBytes = await imageFile.readAsBytes(); // Read the file as bytes
    String base64String = base64Encode(imageBytes); // Convert bytes to base64 string
    return base64String;
  }
  Category selected = MyAppData.categories[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(25.w),
            child: Form(
              key: formKey,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //  verticalSpace(5),
                  // Container(
                  //     width: 150.w,
                  //     margin: EdgeInsets.all(10.w),
                  //     child: Image.asset("assets/images/asala-main.png")),
                  SizedBox(height: 25.h),
                  Text(
                    'add product',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainColor,
                    ),
                  ),
                  SizedBox(height: 10.h),

                  AppTextFormField(
                    textFormController: productNameController,
                    hintText: 'product name',
                    validator: (String) => genericValidator(String),
                  ),
                  const SizedBox(height: 10),
                  // AppTextFormField(
                  //   textFormController: productTitleController,
                  //   hintText: 'product title',
                  //   validator: (String) => genericValidator(String),
                  // ),
                  // const SizedBox(height: 10),
                  AppTextFormField(
                    textFormController: productDescriptionController,
                    hintText: 'product description',
                    validator: (String) => genericValidator(String),
                  ),
                  const SizedBox(height: 10),
                  AppTextFormField(
                    textFormController: productPriceController,
                    hintText: 'product price',
                    validator: (String) {},
                  ),
                  const SizedBox(height: 10),

                  // AppTextFormField(
                  //   textFormController: productSpecializationController,
                  //   hintText: 'product category',
                  //   validator: (String) => genericValidator(String),
                  // ),

                  DropdownButtonFormField<Category>(
                    menuMaxHeight: 300.h,
                    value: selected,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
                      filled: true,
                      fillColor: AppColors.whiteColor,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: AppColors.mainColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: AppColors.mainColor),
                      ),
                    ),
                    dropdownColor: AppColors.appGrayColor,
                    icon: const Icon(Icons.arrow_drop_down, color: AppColors.mainColor),
                    style: TextStyle(color: AppColors.mainColor, fontSize: 14.sp),
                    items: MyAppData.categories.map((category) {
                      return DropdownMenuItem<Category>(
                        value: category,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: SizedBox(
                           // width: 110.w,
                            child: Text(category.name??"",  maxLines: 1, overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (category) {
                      if (category != null) {
                        setState(() {});
                        selected= category;
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    child: SizedBox(width: 120.w,
                      height: 80.h,
                      child: (_imgFile == null) ?Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add,size: 40,),
                          horizontalSpace(10),
                          Text("add image", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        ],
                      ):CircleAvatar(
                        radius: 32,
                        backgroundImage: FileImage(_imgFile!) as ImageProvider,
                      ),
                    ),
                    onTap: ()async{
                      HapticFeedback.lightImpact();
                      await takeSnapshot();
                    },
                  ),
                  const SizedBox(height: 10),
                  SizedBox(height: 30.h),
                  ElevatedButton(
                    onPressed: () async {
                      HapticFeedback.lightImpact();
                      if (formKey.currentState!.validate()) {
                       await   webServices.addProduct(
                            productName:productNameController.text ,
                            productDescription:productDescriptionController.text ,
                            productPrice: double.parse(productPriceController.text),
                            categoryId:selected.id!,
                            imageFile: _imgFile!,
                            );
                       await webServices.getCategory();
                       context.pop();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("product added successfully")),);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mainColor,
                      padding: EdgeInsets.symmetric(
                          vertical: 15.h, horizontal: 55.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'add product',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  genericValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "this field is required";
    }
    if (value.length < 4) {
      return "it must be at least 4 characters";
    }
  }
  paswwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "this field is required";
    }
    if (value.length < 8) {
      return "it must be at least 8 characters";
    }
  }
  emailValidator(value) {
    if (value == null || value.isEmpty) {
      return "Email is required"; // ✅ Empty email validation
    }
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return "Enter a valid email"; // ✅ Invalid email format validation
    }
    return null; // ✅ Email is valid

  }
}