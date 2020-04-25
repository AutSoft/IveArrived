import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_ve_arrived/remote/models.dart';
import 'package:i_ve_arrived/ui/widget/map_snapshot.dart';

class OrderDetailPage extends StatelessWidget{
  final OrderItem item;

  const OrderDetailPage({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.packageId),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network("https://topszotar.hu/inc/image/entry/EN/p/package_jelentese.jpg"),
          Text(item.packageId),
          Text(item.orderDate),
          SizedBox(
            height: 200,
            child: MapSnapshot(
              address: item.address,
            ),
          ),
        ],
      ),
    );
  }
}