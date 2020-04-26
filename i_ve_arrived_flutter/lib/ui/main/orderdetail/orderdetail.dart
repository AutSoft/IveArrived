import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_ve_arrived/main.dart';
import 'package:i_ve_arrived/remote/models.dart';
import 'package:i_ve_arrived/ui/color.dart';
import 'package:i_ve_arrived/ui/widget/green_gradient_button.dart';
import 'package:i_ve_arrived/ui/widget/map_snapshot.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailPage extends StatelessWidget {
  final OrderItem item;

  const OrderDetailPage({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var deliveryName = item.courier?.displayName ?? "Billy Black";
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 253,
            child: MapSnapshot(
              address: item.address,
            ),
          ),
          Positioned(
            top: 16,
            left: 10,
            child: IconButton(
              icon: Icon(
                Icons.chevron_left,
                color: parseColor("#acacac"),
              ),
              iconSize: 40,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Positioned(
            top: 224,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(color: parseColor("#f6f7fa"), borderRadius: BorderRadius.vertical(top: Radius.circular(35)), boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.16),
                  blurRadius: 25,
                )
              ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 29,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: Text(
                      "Package on the way",
                      style: TextStyle(color: parseColor("#52b556"), fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                        ),
                      ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 21),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Container(
                                      foregroundDecoration: BoxDecoration(borderRadius: BorderRadius.circular(100), border: Border.all(color: parseColor("#47ae4c"), width: 1.5)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: Image.network(item.courier?.logoUrl ?? placeholderProfileUrl, width: 57, height: 57),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      deliveryName,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: parseColor("#acd9ae"),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 24),
                                Expanded(
                                  child: Text(
                                    "Your courier is already nearby!\nHe only has 3 addresses up to your address.",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: parseColor("#acacac"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 11,
                            ),
                            SizedBox(
                              width: 138,
                              child: GreenGradientButton(
                                title: "Call ${deliveryName.split(" ")[0]}",
                                onPressed: () {
                                  launch("tel://${item.courier?.phoneNumber ?? "+36705684390"}");
                                },
                                isLoading: false,
                              ),
                            ),
                            SizedBox(
                              height: 23,
                            ),
                            Container(
                              color: Colors.black.withOpacity(0.1),
                              height: 0.5,
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  "SENDER:",
                                  style: TextStyle(
                                    color: parseColor("#5d5d5d"),
                                    fontSize: 14
                                  ),
                                ),
                                SizedBox(width: 4,),
                                Text(
                                  (item.senderName == "string" || item.senderName == null) ? "Joe Smith's happy bakery" : item.senderName,
                                  style: TextStyle(
                                    color: parseColor("#47ae4c"),
                                    fontSize: 13,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  "WEIGHT:",
                                  style: TextStyle(
                                      color: parseColor("#5d5d5d"),
                                      fontSize: 14
                                  ),
                                ),
                                SizedBox(width: 4,),
                                Text(
                                  "3,2 kg",
                                  style: TextStyle(
                                    color: parseColor("#acacac"),
                                    fontSize: 13,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  "PACKAGE ID:",
                                  style: TextStyle(
                                      color: parseColor("#5d5d5d"),
                                      fontSize: 14
                                  ),
                                ),
                                SizedBox(width: 4,),
                                Text(
                                  item.packageId.substring(0, 8),
                                  style: TextStyle(
                                    color: parseColor("#47ae4c"),
                                    fontSize: 13,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  "EXPECTED:",
                                  style: TextStyle(
                                      color: parseColor("#5d5d5d"),
                                      fontSize: 14
                                  ),
                                ),
                                SizedBox(width: 4,),
                                Text(
                                  item.estimatedDeliveryEnd,
                                  style: TextStyle(
                                    color: parseColor("#acacac"),
                                    fontSize: 13,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
