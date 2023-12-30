import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:global_groove/models/quotes_model.dart';
import 'package:global_groove/sizer/sizer.dart';

Widget quotesCard(QuotesModel quotes){
  return Neumorphic(
    style: NeumorphicStyle(
      depth: 10,
      intensity: 1,
      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(5.sp)),
    ),
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 4.sp, horizontal: 8.sp),
      width: 70.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(quotes.content, style: TextStyle(fontSize: 11.sp), textAlign: TextAlign.justify),
          Text('- ${quotes.author}', style: TextStyle(fontSize: 9.sp), textAlign: TextAlign.left),
        ],
      ),
    ),

  );
}