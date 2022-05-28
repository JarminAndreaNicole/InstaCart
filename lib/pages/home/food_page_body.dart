import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utils/color.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_and_text_widget.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../routes/route_helper.dart';
import '../food/popular_food_detail.dart';


class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularProductController>(builder:(popularProducts){
          return Container(
            //color: Colors.redAccent,
            height: Dimensions.pageView,
              child: PageView.builder(
                  controller: pageController,
                  itemCount: 1,
                  itemBuilder: (context, position) {
                    return _buildPageItem(position);
                  }),
            );
        }),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Menu"),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(text: ".", color: Colors.black26,),
              ),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: "Food Pairing",),
              ),
            ],
          ),
        ),

         GetBuilder<RecommendedProductController>(builder: (recommendedProduct){
           return ListView.builder(
           physics: NeverScrollableScrollPhysics(),
           shrinkWrap: true,
               itemCount: 10,
               itemBuilder: (context, index){
            return GestureDetector(
             onTap: (){
              Get.toNamed(RouteHelper.getRecommendedFood(index, "home"));
             },
             child: Container(
                 margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20, bottom: Dimensions.height10,),
             child: Row(
             children: [
               Container(
              width: Dimensions.ListViewImgSize,
              height: Dimensions.ListViewTextContSize,
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius20),
              color: Colors.white38,
              image: const DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                   "assets/image/images3.jpg",
    ),
    ),
    ),
    ),

               Expanded(
              child: Container(
                  height: Dimensions.ListViewTextContSize,
                   decoration: BoxDecoration(
                 borderRadius: BorderRadius.only(
                topRight: Radius.circular(Dimensions.radius20),
                   bottomRight: Radius.circular(Dimensions.radius20),
    ),
              color: Colors.white,
    ),
                  child: Padding(
                 padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
               child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BigText(text: "Sisilog"),
               SizedBox(height: Dimensions.height10,),
                //SmallText(text: "Bistek Tagalog"),
                //SizedBox(height: Dimensions.height10,),
    ],
    )
    ),
    ),
    ),
    ],
    ),
    ),
           );
    });
         }),
  ],
    );
  }

  Widget _buildPageItem(int index) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()){
      var currScale = 1-(_currPageValue-index)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0,);

    }else if(index ==_currPageValue.floor()+1)
    {
      var currScale = _scaleFactor +
          (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0,);

    }else if(index ==_currPageValue.floor()-1){
    var currScale = _scaleFactor+(_currPageValue-index+1)*(1-_scaleFactor);
    var currTrans = _height*(1-currScale)/2;
    matrix = Matrix4.diagonal3Values(1, currScale, 1);
    matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);

    }else{
    var currScale = 0.8;
    matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height*(1-_scaleFactor)/2, 1);
    }
      return Transform(
        transform: matrix,
        child: Stack(
        children: [
          GestureDetector(
            onTap: (){
               //Get.toNamed(RouteHelper.getPopularFood(index));
        },
              child: Container(
                height: 250,
                margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                    image: const DecorationImage(
                      fit: BoxFit.fill,
                        image: AssetImage(
                            "assets/image/IMG.jpg",
                        )
                    ),

                ),
              ),
            ),
        ],
    ),
      );
    }
  }

