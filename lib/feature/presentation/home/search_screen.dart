import 'package:asala_saudi/core/helpers/colors/colors.dart';
import 'package:asala_saudi/core/networking/data.dart';
import 'package:asala_saudi/core/networking/web_services.dart';
import 'package:asala_saudi/feature/presentation/home/widgets/community_item.dart';
import 'package:asala_saudi/feature/presentation/home/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/extentions/extentions.dart';
import '../../../core/routing/routing.dart';
import 'community_Details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController searchController = TextEditingController();
// bool isCommunitySelected = true;
  late TabController _tabController;

  // final List<Map<String, String>> communityItems = [
  //   {
  //     'title': 'مجتمع الرسامين الإلكترونيين',
  //     'imageUrl': "assets/images/carosol1.png",
  //   },
  //   {
  //     'title': 'مجتمع النحاتين الفنيين',
  //     'imageUrl': "assets/images/carosol1.png",
  //   },
  // ];
  //
  // final List<Map<String, String>> clubItems = [
  //   {
  //     'title': 'نادي التصميم الإبداعي',
  //     'imageUrl':"assets/images/carosol1.png",
  //   },
  //   {
  //     'title': 'نادي التصوير الفوتوغرافي',
  //     'imageUrl': "assets/images/carosol1.png",
  //   },
  // ];
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {

    // MyAppData.communities.forEach((item){
    //   item.members.forEach((member){
    //     print("********* ${item.name}  :  ${member.userName}   :  ${MyAppData.user?.userName}  ********");
    //     print(item.members.any((user) => user?.id == MyAppData.user?.id)) ;
    //   });
    // });
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
              verticalSpace(10),
              Row(
                children: [
                  SearchBarWithSuggestions(),
                  horizontalSpace(5.w),
                  Icon(
                    Icons.tune,
                    color: AppColors.mainAccentColor,
                    size: 40,
                  ),
                ],
              ),
              // TextField(
              //   controller: searchController,
              //   decoration: InputDecoration(
              //     hintText: 'search',
              //     hintStyle: const TextStyle(color: Colors.grey),
              //     prefixIcon: const Icon(Icons.search, color: Colors.green),
              //     suffixIcon: const Row(
              //       mainAxisSize: MainAxisSize.min,
              //       children: [
              //         Icon(Icons.tune, color: Colors.green),
              //         Icon(Icons.more_vert, color: Colors.green),
              //       ],
              //     ),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(8),
              //       borderSide: const BorderSide(color: Colors.grey),
              //     ),
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(8),
              //       borderSide: const BorderSide(color: Colors.grey),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(8),
              //       borderSide: const BorderSide(color: Colors.green),
              //     ),
              //     fillColor: Colors.grey[200],
              //     filled: true,
              //   ),
              // ),
              const SizedBox(height: 20),
              TabBar(
                controller: _tabController,
                labelColor: AppColors.mainColor,
                unselectedLabelColor: AppColors.mainAccentColor,
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                tabs: [
                  Tab(text: "community"),
                  Tab(text: "club"),
                ],
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 10, color: AppColors.mainColor),
                  insets: EdgeInsets.symmetric(horizontal: 60.w),
                ),
              ),
              // CommunityItem(
              //   title: item['title']!,
              //   imageUrl: item['imageUrl']!,
              //   onTap: () {
              //     HapticFeedback.lightImpact();
              //     // Navigator.push(
              //     //   context,
              //     //   MaterialPageRoute(
              //     //       builder: (context) => CommunityDetailScreen(
              //     //           title: item['title']!, imageUrl: item['imageUrl']!)),
              //     // );
              //   },
              // )
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ListView(
                        children: List.generate(
                            MyAppData.communities.length,
                            (index) =>
                                // isCommunitySelected ?
                                CommunityItem(
                                  onJoin: () => WebServices().joinCommunity(MyAppData.communities[index].id ?? 0),
                                  title:
                                      MyAppData.communities[index].name ?? "",
                                  imageUrl:
                                      MyAppData.communities[index].image ?? "",
                                  onTap: () {
                                    HapticFeedback.lightImpact();
                                    context.pushNamed(Routes.communityDetailsScreen,arguments: MyAppData.communities[index] );
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) => CommunityDetailScreen(
                                    //           title: item['title']!, imageUrl: item['imageUrl']!)),
                                    // );
                                  }, isJoined:   MyAppData.communities[index].members.any((user) => user?.id == MyAppData.user?.id) ,
                                ))),
                    ListView(
                        children: List.generate(
                            MyAppData.clubs.length,
                            (index) => CommunityItem(
                                  title: MyAppData.clubs[index].name ?? "",
                                  imageUrl: MyAppData.clubs[index].image ?? "",
                                isJoined: MyAppData.clubs[index].members.any((user) => user?.id == MyAppData.user?.id),
                                  onTap: () {
                                    HapticFeedback.lightImpact();
                                    context.pushNamed(Routes.clubDetailsScreen,arguments: MyAppData.clubs[index] );
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) => CommunityDetailScreen(
                                    //           title: item['title']!, imageUrl: item['imageUrl']!)),
                                    // );
                                  },
                              onJoin: () => WebServices().joinClub(MyAppData.clubs[index].id ?? 0),
                                ))),
                  ],
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     GestureDetector(
              //       onTap: () {
              //         setState(() {
              //           isCommunitySelected = true;
              //         });
              //       },
              //       child: Container(
              //         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              //         decoration: BoxDecoration(
              //           color: isCommunitySelected ? Colors.green : Colors.white,
              //           border: Border.all(color: Colors.green),
              //           borderRadius: BorderRadius.circular(5),
              //         ),
              //         child: Text(
              //           'community',
              //           style: TextStyle(
              //             fontSize: 18,
              //             color: isCommunitySelected ? Colors.white : Colors.green,
              //           ),
              //         ),
              //       ),
              //     ),
              //     const SizedBox(width: 8),
              //     GestureDetector(
              //       onTap: () {
              //         setState(() {
              //           isCommunitySelected = false;
              //         });
              //       },
              //       child: Container(
              //         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              //         decoration: BoxDecoration(
              //           color: !isCommunitySelected ? Colors.green : Colors.white,
              //           border: Border.all(color: Colors.green),
              //           borderRadius: BorderRadius.circular(5),
              //         ),
              //         child: Text(
              //           'club',
              //           style: TextStyle(
              //             fontSize: 18,
              //             color: !isCommunitySelected ? Colors.white : Colors.green,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 20),
              // SizedBox(
              //   height: 300.h,
              //   child: ListView(
              //     children: (isCommunitySelected ? communityItems : clubItems)
              //         .map((item) => CommunityItem(
              //       title: item['title']!,
              //       imageUrl: item['imageUrl']!,
              //       onTap: () {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => CommunityDetailScreen(
              //                   title: item['title']!, imageUrl: item['imageUrl']!)),
              //         );
              //       },
              //     ))
              //         .toList(),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
