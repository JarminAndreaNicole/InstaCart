import 'package:flutter/cupertino.dart';
import 'package:food_delivery/widgets/small_text.dart';

import '../utils/dimensions.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icons;
  final String text;
  final Color iconColor;

  const IconAndTextWidget({Key? key,
    required this.icons,
    required this.text,
    required this.iconColor, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icons, color: iconColor, size: Dimensions.iconSize24),
        SizedBox(width: 5,),
        SmallText(text: text),
      ],
    );
  }
}
