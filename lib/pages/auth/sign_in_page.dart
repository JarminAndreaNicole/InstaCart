import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_delivery/controllers/services/food_app_service.dart';
import 'package:food_delivery/pages/auth/account_page.dart';
import 'package:food_delivery/pages/auth/sign_up_page.dart';
import 'package:food_delivery/pages/cart/cart_history.dart';
import 'package:food_delivery/pages/home/food_page_body.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/utils/color.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_text_field.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../base/show_custom_snackbar.dart';
import '../../controllers/auth_controller.dart';
import '../../routes/route_helper.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../home/home_page.dart';


class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final FoodAppService _foodAppService = FoodAppService();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late String loginMessage = '';
  late String Email;
  late String Password;

  String get errorMessEmail => "Password Field is Empty!";
  String get errorMessPassword => "Email Field is Empty!";
  String get errorMessEmailAndPass => "Email & Password is Empty!";

  @override
  Widget build(BuildContext context) {


    void _login(AuthController authController){
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if(email.isEmpty){
        showCustomSnackBar("Type your email address", title: "Email Address");

      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Type your valid email address", title: "Valid Email Address");

      }else if(password.isEmpty){
        showCustomSnackBar("Type your password", title: "Password");

      }else if(password.length<6){
        showCustomSnackBar("Password can not be less than six characters", title: "password");

      }else{
        authController.login(email, password).then((status){
          if(status.isSuccess){
          Get.toNamed(RouteHelper.getInitial());
          }else{
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController){
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimensions.screenHeight*0.05,),
              Container(
                height: Dimensions.screenHeight*0.25,
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 100,
                    backgroundImage: AssetImage(
                        "assets/image/try1.png"
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height20,),

             AppTextField(textController: emailController, hintText: "Email", icon: Icons.email),
              SizedBox(height: Dimensions.height20,),
              AppTextField(textController: passwordController, hintText: "Password", icon: Icons.password_sharp, isObscure:true),
              SizedBox(height: Dimensions.height20,),

              SizedBox(height: Dimensions.height20,),
              Container(
                margin: EdgeInsets.only(left: Dimensions.width20),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "                    Sign into your account",
                      style: TextStyle(
                        fontSize: Dimensions.font20,
                        color: AppColors.titleColor,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: Dimensions.screenHeight*0.05,),
              GestureDetector(

                child: Container(
                  width: Dimensions.screenWidth/2,
                  height: Dimensions.screenHeight/13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                  ),
                  child: Center(
                    child: ElevatedButton(
                      child: BigText(
                        text: "Sign In",
                        size: 100,
                      ),
                      onPressed: () async
                      {
                        print(emailController.text);
                        print(passwordController.text);
                      if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
                        final http.Response response = await _foodAppService.loginUser(Email: emailController.text,  Password: passwordController.text);
                        var jsonData = jsonDecode(response.body);
                        if (response.statusCode == 200) {
                          if (jsonData['success'] == true) {
                            Fluttertoast.showToast(
                              msg: 'Sign in Success!',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 2,
                              backgroundColor: Colors.deepOrange[300],
                              textColor: Colors.white,
                              fontSize: 12.0,
                            );
                            // Process success function
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage(

                              )),
                            );

                      } else {
                      // Display error message
                      String errorMessage = jsonData['message'];
                      print('Error: $errorMessage');
                      setState(() {
                      loginMessage = errorMessage;

                      });
                      }
                      }
                      // call login API

                           } else {
                      if (emailController.text.isNotEmpty) {
                      setState(() {
                      loginMessage = errorMessEmail;
                      print('loginMessage $loginMessage');
                      });
                      }
                      if (passwordController.text.isNotEmpty) {
                      setState(() {
                      loginMessage = errorMessPassword;
                      print('loginMessage $loginMessage');
                      });
                      }
                      if (emailController.text.isEmpty && passwordController.text.isEmpty) {
                      setState(() {
                      loginMessage = errorMessEmailAndPass;
                      print('loginMessage $loginMessage');
                      });
                      }
                          }
                        }
                    ),

                  ),
                ),
              ),

              SizedBox(height: Dimensions.screenHeight*0.05,),
              RichText(
                  text: TextSpan(
                      text: "Don\'t have an account? ",
                      style: TextStyle(
                        color: AppColors.titleColor,
                        fontSize: Dimensions.font20,
                      ),
                      children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage(), transition: Transition.fade),
                            text: " Create",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.titleColor,
                              fontSize: Dimensions.font20,
                            )),
                      ]
                  )
              )
            ],
          ),
        );
      }),
    );
  }
}
