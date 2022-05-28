import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/no_data_page.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/utils/color.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../models/cart_model.dart';
import '../../routes/route_helper.dart';
import '../../widgets/small_text.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Get.find<CartController>()
        .getCartHistoryList().reversed.toList();

    Map<String, int> cartItemsPerOrder = Map();

    for(int i=0; i<getCartHistoryList.length; i++){
      if(cartItemsPerOrder.containsKey(getCartHistoryList[i].time)){
        cartItemsPerOrder.update(getCartHistoryList[i].time!, (value) => ++value);
      }else{
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!,()=>1);
      }
    }
    List<int> cartItemsPerOrderTimeToList(){
      return cartItemsPerOrder.entries.map((e)=>e.value).toList();
    }
    List<String> cartOrderTimeToList(){
      return cartItemsPerOrder.entries.map((e)=>e.key).toList();
    }

    List<int> itemsPerOrder =cartItemsPerOrderTimeToList();

    var listCounter=0;
    Widget timeWidget(int index){
      var outputDate = DateTime.now().toString();
        if(index<getCartHistoryList.length){
          DateTime parseDate =  DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[listCounter].time!);
          var inputDate = DateTime.parse(parseDate.toString());
          var outputFormat= DateFormat("MM/dd/yyyy hh:mm a");
          outputDate = outputFormat.format(inputDate);
        }
        return BigText(text: outputDate);
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 100,
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: 45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(text: "Cart History", color:  Colors.white,),
                AppIcon(icon: Icons.shopping_cart_outlined,
                  iconColor: AppColors.mainColor,
                  backgroundColor: AppColors.yellowColor,
                ),
              ],
            ),
          ),
         
          GetBuilder<CartController>(builder: (_cartContorller) {
            return _cartContorller
                .getCartHistoryList()
                .length > 0 ?
            Expanded(child: Container(
                margin: EdgeInsets.only(
                  top: Dimensions.height20,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                ),
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context, child: ListView(
                  children: [
                    for(int i = 0; i < 5; i++)
                      Container(
                        height: 120,
                        margin: EdgeInsets.only(bottom: Dimensions.height20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            timeWidget(listCounter),
                            //BigText(text: "04/24/2022"),
                            SizedBox(height: Dimensions.height10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Wrap(
                                    direction: Axis.horizontal,
                                    children: List.generate(3, (index) {
                                      if (listCounter < getCartHistoryList.length) {
                                        listCounter++;
                                      }
                                      return index <= 2 ? Container(
                                        height: 80,
                                        width: 80,
                                        margin: EdgeInsets.only(right: Dimensions.width10 / 2),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(Dimensions.radius15 / 2),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                  "assets/image/images3.jpg",
                                                )
                                            )
                                        ),
                                      ) : Container();
                                    })
                                ),

                                Container(
                                  height: 80,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SmallText(text: "Total", color: AppColors.titleColor),
                                      BigText(text: "3" + " Items", color: AppColors.titleColor,),
                                      GestureDetector(
                                        onTap: () {
                                          var orderTime = cartOrderTimeToList();
                                          Map<int, CartModel> moreOrder = {};
                                          for (int j = 0; j < getCartHistoryList.length; j++) {
                                            if (getCartHistoryList[j].time == orderTime[i]) {
                                              moreOrder.putIfAbsent(getCartHistoryList[j].id!, () =>
                                                  CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j])))
                                              );
                                            }
                                          }
                                          Get
                                              .find<CartController>()
                                              .setItems = moreOrder;
                                          Get.find<CartController>().addtoCartList();
                                          Get.toNamed(RouteHelper.getCartPage());
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: Dimensions.width10 / 2, vertical: Dimensions.height10 / 2),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(Dimensions.radius15 / 3),
                                              border: Border.all(width: 1, color: AppColors.mainColor)
                                          ),
                                          child: SmallText(text: "Buy Again", color: AppColors.mainColor,),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                  ],
                ),)
            )) :
            SizedBox(
              height: MediaQuery.of(context).size.height/1.5,
                child: const Center(
                  child: NoDataPage(
                    text: "Your didn't buy anything so far!",
                    imgPath: "assets/image/empty_box.png",),
                ));
          }),
        ],
      ),
    );
  }
}
