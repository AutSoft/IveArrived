import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:i_ve_arrived/main.dart';
import 'package:i_ve_arrived/ui/main/me_store.dart';
import 'package:i_ve_arrived/ui/widget/green_gradient_button.dart';
import 'package:provider/provider.dart';

import '../../color.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(builder: (context) {
        var meStore = Provider.of<MeStore>(context);
        var meData = meStore.myRequest?.value;
        var url = meStore.myRequest?.value?.logoUrl;
        return Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              height: 240,
              child: Container(
                color: parseColor("#4bb04f"),
                alignment: Alignment.center,
              ),
            ),
            Positioned(
              top: 37,
              right: 30,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(500),
                child: Builder(builder: (context) {
                  return Image.network(
                          url == "string" || url == null ? placeholderProfileUrl : url,
                          width: 57,
                          height: 57,
                        );
                }),
              ),
            ),
            Positioned(
              top: 100,
              left: 48,
              child: Text(
                "My profile",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Positioned(
              left: 30,
              top: 150,
              right: 30,
              bottom: 17,
              child: Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(43), boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.16),
                    blurRadius: 25,
                  ),
                ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 29,),
                      Text(
                        "My profile informations",
                        style: TextStyle(
                          color: parseColor("#4ab04f"),
                          fontSize: 14,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      SizedBox(height: 8,),
                      _buildField("City", meData?.city ?? "Budapest"),
                      _buildField("ZIP code", meData?.zipCode ?? "1117"),
                      _buildField("Address", meData?.address ?? "Gábor Dénes utca 4."),
                      _buildField("Phone number", "+36 30 458 7631"),
                      _buildField("Email", meData?.email),
                      SizedBox(height: 18,),
                      Center(
                        child: SizedBox(
                          width: 220,
                          child: GreenGradientButton(
                            title: "Change profile picture",
                            isLoading: false,
                            onPressed: (){},
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      }),
    );
  }

  Widget _buildField(String name, String value){
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 7,),
        Text(
          name,
          style: TextStyle(
              color: parseColor("#4ab04f"),
              fontSize: 14
          ),
        ),
        SizedBox(height: 5,),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            color: parseColor("#5d5d5d"),
          ),
        ),
        SizedBox(height: 9,),
        Container(
          height: 0.5,
          color: parseColor("#dddddd"),
        )
      ],
    );
  }
}
