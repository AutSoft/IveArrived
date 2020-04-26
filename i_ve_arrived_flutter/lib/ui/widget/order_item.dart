import 'package:flutter/material.dart';
import 'package:i_ve_arrived/main.dart';
import 'package:i_ve_arrived/remote/models.dart';
import 'package:i_ve_arrived/ui/color.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderItem item;
  final void Function(OrderItem) onItemPressed;

  const OrderItemWidget({Key key, this.item, this.onItemPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: RaisedButton(
        color: Colors.white,
        padding: EdgeInsets.zero,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        onPressed: () => onItemPressed?.call(item),
        child: Container(
          height: 114,
          alignment: Alignment.center,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 21,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 21,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Image.network(
                        item.courierService?.logoUrl ?? "https://cdn.cnn.com/cnnnext/dam/assets/180301124611-fedex-logo.png",
                        height: 24,
                      ),
                      SizedBox(width: 13),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: parseColor("#74db78")),
                        ),
                        width: 69,
                        height: 26,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              Icons.check,
                              color: parseColor("#74db78"),
                              size: 17,
                            ),
                            Text(
                              "paid",
                              style: TextStyle(
                                color: parseColor("#74db78"),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "EXPECTED:",
                        style: TextStyle(color: parseColor("#5d5d5d"), fontSize: 13),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        item.estimatedDeliveryEnd,
                        style: TextStyle(
                          color: parseColor("#acacac"),
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "PACKAGE ID:",
                        style: TextStyle(color: parseColor("#5d5d5d"), fontSize: 13),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        item.packageId.substring(0, 8),
                        style: TextStyle(
                          color: parseColor("#47ae4c"),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 13,
                  )
                ],
              ),
              Expanded(
                child: Container(),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 19,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Details",
                        style: TextStyle(
                          color: parseColor("#47ae4c"),
                          fontSize: 12,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: parseColor("#47ae4c"),
                      ),
                      SizedBox(width: 8,)
                    ],
                  ),
                  Container(
                    foregroundDecoration: BoxDecoration(borderRadius: BorderRadius.circular(100), border: Border.all(color: parseColor("#47ae4c"), width: 1.5)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(item.courier?.logoUrl ?? placeholderProfileUrl, width: 44, height: 44),
                    ),
                  ),
                  SizedBox(height: 2,),
                  Text(
                    item.courier?.displayName ?? "Billy Black",
                    style: TextStyle(
                      fontSize: 12,
                      color: parseColor("#acd9ae"),
                    ),
                  )
                ],
              ),
              SizedBox(width: 9,),
            ],
          ),
        ),
      ),
    );
  }
}
