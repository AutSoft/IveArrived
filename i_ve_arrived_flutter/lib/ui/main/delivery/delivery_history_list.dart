import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:i_ve_arrived/main.dart';
import 'package:i_ve_arrived/remote/models.dart';
import 'package:i_ve_arrived/ui/main/order_delivery_store.dart';
import 'package:i_ve_arrived/ui/main/orderdetail/orderdetail.dart';
import 'package:i_ve_arrived/ui/widget/order_item.dart';
import 'package:provider/provider.dart';

class DeliveryHistoryPage extends StatelessWidget {
  final DeliveryStatus filterStatus;

  const DeliveryHistoryPage({Key key, this.filterStatus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("History")),
      body: Observer(
        builder: (context) {
          var pageStore = Provider.of<OrderDeliveryStore>(context);
          var filteredList = pageStore.currentList.where((it) => it.status == filterStatus).toList();
          return ListView.separated(
            itemBuilder: (_, i) => OrderItemWidget(
              item: filteredList[i],
              onItemPressed: (item) {
                Navigator.of(context).push(route(() => OrderDetailPage(
                      item: item,
                    )));
              },
            ),
            separatorBuilder: (_, __) => SizedBox(height: 16),
            itemCount: filteredList.length,
          );
        },
      ),
    );
  }
}
