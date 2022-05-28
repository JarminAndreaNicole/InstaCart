import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/base/show_custom_snackbar.dart';
import 'package:food_delivery/pages/auth/sign_in_page.dart';
import 'package:food_delivery/utils/color.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_text_field.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/services/food_app_service.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();

}

class _SignUpPageState extends State<SignUpPage> {
  final FoodAppService _foodAppService = FoodAppService();
  late String loginMessage = '';


  TextEditingController FullnameController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController AddressController = TextEditingController();
  TextEditingController UsernameController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    void _registration(AuthController authController){
      String Fullname = FullnameController.text.trim();
      String Email = EmailController.text.trim();
      String Address = AddressController.text.trim();
      String Username = UsernameController.text.trim();
      String Password = PasswordController.text.trim();



      if(Fullname.isEmpty){
        showCustomSnackBar("Type your name", title: "Name");

      }else if(Email.isEmpty){
        showCustomSnackBar("Type your email address", title: "Email Address");

      }else if(Address.isEmpty){
        showCustomSnackBar("Type your complete address", title: "Address");

      }else if(Username.isEmpty){
        showCustomSnackBar("Type your Username", title: "Username");

      }else if(!GetUtils.isEmail(Email)){
        showCustomSnackBar("Type your valid email address", title: "Valid Email Address");

      }else if(Password.isEmpty){
        showCustomSnackBar("Type your password", title: "Password");

      }else if(Password.length<6){
        showCustomSnackBar("Password can not be less than six characters", title: "password");

      }else{
        showCustomSnackBar("All went well", title: "Perfect");

        /*SignUpBody signUpBody = SignUpBody(
            fullname: fullname,
            address: address,
            email: email,
            password: password);
        authController.registration(signUpBody).then((status){
          if(status.isSuccess){
            print("Success registration");
            Get.offNamed(RouteHelper.getInitial());
          }else{
            showCustomSnackBar(status.message);
          }
        });*/
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController){
        return !_authController.isLoading?SingleChildScrollView(
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

              AppTextField(textController: FullnameController, hintText: "FullName", icon: Icons.person),
              SizedBox(height: Dimensions.height20,),
              AppTextField(textController: EmailController, hintText: "Email", icon: Icons.email),
              SizedBox(height: Dimensions.height20,),
              AppTextField(textController: AddressController, hintText: "Address", icon: Icons.location_on),
              SizedBox(height: Dimensions.height20,),
              AppTextField(textController: UsernameController, hintText: "Username", icon: Icons.location_on),
              SizedBox(height: Dimensions.height20,),
              AppTextField(textController: PasswordController, hintText: "Password", icon: Icons.password_sharp, isObscure:true),
              SizedBox(height: Dimensions.height20,),


              GestureDetector(
                /*onTap: (){
                  Get.toNamed(RouteHelper.getSignInPage());

                },*/

                child: Container(
                  width: Dimensions.screenWidth/2,
                  height: Dimensions.screenHeight/13,
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(Dimensions.radius30),
                  //   color: AppColors.mainColor,
                  // ),
                  child: Center(
                    child: RaisedButton(
                        child: BigText(
                          text: "Register",
                          size: 100,
                          color: AppColors.titleColor,
                        ),
                        onPressed: () async
                        {
                          print(FullnameController.text);
                          print(EmailController.text);
                          print(AddressController.text);
                          print(UsernameController.text);
                          print(PasswordController.text);
                            final http.Response response = await _foodAppService.signupPage(Fullname: FullnameController.text, Email: EmailController.text, Address: AddressController.text, Username: UsernameController.text, Password: PasswordController.text, );
                            var jsonData = jsonDecode(response.body);
                            if (response.statusCode == 200) {
                              if (jsonData['success'] == true) {
                                Fluttertoast.showToast(
                                  msg: 'Sign up Success!',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 2,
                                  backgroundColor: Colors.lightGreen[300],
                                  textColor: Colors.black,
                                  fontSize: 12.0,
                                );
                                // Process success function
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SignInPage(

                                  )),
                                );

                              } else {
                                Fluttertoast.showToast(
                                  msg: 'Register Failed!',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 2,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 12.0,
                                );
                                // Display error message
                                String errorMessage = jsonData['message'];
                                print('Error: $errorMessage');
                              }
                            }
                            // call login API
                          }

                    ),
                    /*child: BigText(
                      text: "Sign Up",
                      size: 30,
                      color: AppColors.titleColor,
                    ),*/
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height10,),
              RichText(
                  text: TextSpan(
                      recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                      text: "Have an account already?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.titleColor,
                        fontSize: Dimensions.font20,
                      )
                  )
              ),
              SizedBox(height: Dimensions.screenHeight*0.05,),

            ],
          ),
        ):const CustomLoader();
      },),
    );

  }
}
