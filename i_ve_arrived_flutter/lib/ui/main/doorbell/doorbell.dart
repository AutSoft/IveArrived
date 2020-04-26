import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_ve_arrived/main.dart';
import 'package:i_ve_arrived/remote/models.dart';
import 'package:i_ve_arrived/ui/color.dart';
import 'package:i_ve_arrived/ui/widget/green_gradient_button.dart';

class DoorbellPage extends StatelessWidget {
  final OrderItem item;

  const DoorbellPage({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 19, top: 31, right: 19, bottom: 41),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            foregroundDecoration: BoxDecoration(borderRadius: BorderRadius.circular(100), border: Border.all(color: parseColor("#acd9ae"), width: 1.5)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(item.courier?.logoUrl ?? placeholderProfileUrl, width: 82, height: 82),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            item.courier?.displayName ?? "Billy Black",
            style: TextStyle(
              fontSize: 13,
              color: parseColor("#47ae4c"),
            ),
          ),
          SizedBox(height: 17,),
          Text(
            "Your courier has arrived and he is ringing to you virtually!",
            style: TextStyle(
              color: parseColor("#5d5d5d"),
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          Expanded(child: Container(),),
          Container(
            height: 129,
            width: 129,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.16),
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Container(
              width: 108,
              height: 108,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    parseColor("#52b556"),
                    parseColor("#77e67c"),
                  ]
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(172, 217, 174, 0.31),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              alignment: Alignment.center,
              child: Icon(Icons.notifications_active, color: Colors.white, size: 50,),
            ),
          ),
          Expanded(child: Container(),),
          Text(
            "Can you pick up the package now?",
            style: TextStyle(
              color: parseColor("#5d5d5d"),
              fontSize: 16,
            ),
          ),
          SizedBox(height: 24,),
          Row(
            children: <Widget>[
              Expanded(
                child: GreenGradientButton(
                  title: "Yes, I'm going",
                  isLoading: false,
                  onPressed: (){
                    Navigator.pop(context, true);
                  },
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: RedGradientButton(
                  title: "No.",
                  onPressed: (){
                    Navigator.pop(context, false);
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}