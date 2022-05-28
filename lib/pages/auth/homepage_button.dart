import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/pages/auth/sign_up_page.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../routes/route_helper.dart';
import '../../utils/color.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';

class HomePageButton extends StatefulWidget {
  static const String id = 'homepage_button';
  const HomePageButton({Key? key}) : super(key: key);

  @override
  _HomePageButtonState createState() => _HomePageButtonState();
}

class _HomePageButtonState extends State<HomePageButton> {
  @override
  Widget build(BuildContext context) {
   return Container(
        child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.maxFinite,
              height: 200,
              margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius15),
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/image/logo.png"
                      )
                  )
              ),
            ),
            SizedBox(height: 100,),


            GestureDetector(
              onTap: (){
                Get.toNamed(RouteHelper.getSignInPage());
              },
              child: Container(

                height: Dimensions.height10*5,
                margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                ),
                child: Center(child: BigText(text: "Login", color: Colors.white, size: Dimensions.font16,)),

              ),
            ),
            SizedBox(height: Dimensions.height20,),



            GestureDetector(
              onTap: (){
                //Get.toNamed(RouteHelper.getSignUpPage());
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignUpPage(
                      )),
                );
              },
              child: Container(
                height: Dimensions.height10*5,
                margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                ),
                child: Center(child: BigText(text: "Sign Up", color: Colors.white, size: Dimensions.font16,)),

              ),
            ),
            SizedBox(height: 200,),

            RichText(
              textAlign: TextAlign.center,
                text: TextSpan(
                    text: "A successful business requires one simple thing: PASSION -Teresa Collins",
                    style: TextStyle(
                      color: AppColors.titleColor,
                      fontSize: Dimensions.font16,


                    )
                )
            ),
            SizedBox(height: Dimensions.height20,),


          ],
        )));

  }
  }

