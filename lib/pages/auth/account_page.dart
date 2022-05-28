import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utils/color.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/account_widget.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../routes/route_helper.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: "Profile", size: 24, color: Colors.white,
        ),
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: Dimensions.height20),
        child: Column(

          children: [
            //profile icon
            AppIcon(icon: Icons.person,
              backgroundColor: AppColors.mainColor,
              iconColor: Colors.white,
              iconSize: Dimensions.height45+Dimensions.height30,
              size: Dimensions.height15*10,),
            SizedBox(height: Dimensions.height30,),

            Expanded(
              child: SingleChildScrollView(
                child: Column (
                  children: [
                    //name
                    AccountWidget(
                        appIcon:  AppIcon(icon: Icons.person,
                          backgroundColor: AppColors.yellowColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*5,),
                        bigText: BigText(text: "Name",)
                    ),
                    SizedBox(height: Dimensions.height20,),

                    //phone number
                    AccountWidget(
                        appIcon:  AppIcon(icon: Icons.phone,
                          backgroundColor: AppColors.yellowColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*5,),
                        bigText: BigText(text: "Mobile Number",)
                    ),
                    SizedBox(height: Dimensions.height20,),

                    //address
                    AccountWidget(
                        appIcon:  AppIcon(icon: Icons.location_on,
                          backgroundColor: AppColors.yellowColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*5,),
                        bigText: BigText(text: "Address",)
                    ),
                    SizedBox(height: Dimensions.height20,),

                    //emails
                    AccountWidget(
                        appIcon:  AppIcon(icon: Icons.email,
                          backgroundColor: AppColors.yellowColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*5,),
                        bigText: BigText(text: "username",)
                    ),
                    SizedBox(height: Dimensions.height20,),
                    //emails
                    GestureDetector(
                      onTap: (){
                        Get.offNamed(RouteHelper.getSignInPage());
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                        child: BigText(text: "Log Out", color: Colors.white,),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.mainColor,
                        ),
                    ),

                    )],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}