import 'package:courier_app/src/components/custom_divider.dart';
import 'package:courier_app/src/core/constants/assets.dart';
import 'package:courier_app/src/core/constants/dimensions.dart';
import 'package:courier_app/src/features/features/add_order/add_order1_screen.dart';
import 'package:courier_app/src/features/features/all_item/all_item_screen.dart';
import 'package:courier_app/src/features/features/all_item/all_item_screen_2.dart';
import 'package:courier_app/src/features/features/home/home_screen.dart';
import 'package:courier_app/src/features/features/profile/edit_profile.dart';
import 'package:courier_app/src/features/features/profile/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../constants/palette.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({Key? key}) : super(key: key);

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int _selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  bool click = false;
  bool click2 = false;
  bool click3 = false;
  bool click4 = false;

  List<Widget> navigationWidgets = [
    HomeScreen(),
    AllItemScreen(
      selectedStatus: 'Pickup Pending',
      navigatedFromNavBar: true,
    ),
    AllItemScreen2(selectedStatus: 'All', navigatedFromNavBar: true),
    ProfileScreen(navigatedFromNavBar: true),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(const AddOrderOneScreen());
            print('object');
          },
          backgroundColor: AppColors.darkBlue,
          child: const CircleAvatar(
            backgroundColor: AppColors.orange,
            child: Icon(Icons.add, color: AppColors.white),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 2,
          child: Container(
            color: AppColors.darkBlue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 0;
                      });
                    },
                    icon: SizedBox(
                      height: 25,
                      child: Image.asset(
                        ImgAssets.homeNav,
                        color: AppColors.blue,
                        colorBlendMode:  _selectedIndex == 0 ? BlendMode.modulate : BlendMode.dstIn,
                      ),
                    )),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    },
                    icon: SizedBox(
                      height: 25,
                      child: Image.asset(
                        ImgAssets.boxTimeNav,
                        color: AppColors.blue,
                        colorBlendMode: _selectedIndex == 1 ? BlendMode.modulate : BlendMode.dstIn,
                      ),
                    )),
                SizedBox(
                  width: width_14,
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 2;
                      });
                    },
                    icon: SizedBox(
                      height: 25,
                      child: Image.asset(
                        ImgAssets.itemNav,
                        color: AppColors.blue,
                        colorBlendMode: _selectedIndex == 2 ? BlendMode.modulate : BlendMode.dstIn,
                      ),
                    )),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 3;
                      });
                    },
                    icon: SizedBox(
                      height: 25,
                      child: Image.asset(
                        ImgAssets.userNav,
                        color: AppColors.blue,
                        colorBlendMode: _selectedIndex == 3 ? BlendMode.modulate : BlendMode.dstIn,
                      ),
                    )),
              ],
            ),
          ),
        ),
        body: navigationWidgets.elementAt(_selectedIndex));
  }
}

// CustomDivider(
// width: width_50,
// ),

// IconButton(onPressed: (){
// setState(() {
// click4 =! click4;
// if(click=false){
// click2=true;
// }else if(click2=false){
// click2=true;
// } else if(click3=false){
// click2=true;
// }
// });
// Get.to(ProfileScreen());
// print('object');
// }, icon:
// Image.asset( ImgAssets.userNav,color: AppColors.orange, colorBlendMode:click4==false? BlendMode.modulate: BlendMode.srcIn,)),
//
