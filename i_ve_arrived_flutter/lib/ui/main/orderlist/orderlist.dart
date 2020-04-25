import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:i_ve_arrived/main.dart';
import 'package:i_ve_arrived/remote/models.dart';
import 'package:i_ve_arrived/remote/service.dart';
import 'package:i_ve_arrived/ui/main/order_store.dart';
import 'package:i_ve_arrived/ui/main/orderdetail/orderdetail.dart';
import 'package:i_ve_arrived/ui/widget/order_item.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class OrderListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
      ),
      body: Observer(
        builder: (context) {
          var pageStore = Provider.of<OrderStore>(context);
          if (pageStore.deliveryListRequest.status == FutureStatus.pending) {
            return Center(child: CircularProgressIndicator());
          } else {
            var list = pageStore.currentList ?? [];
            return ListView.separated(
              itemBuilder: (context, i) {
                var item = list[i];
                return OrderItemWidget(
                  item: item,
                  onItemPressed: (item) {Navigator.of(context).push(route(() => OrderDetailPage(item: item,)));},
                );
              },
              separatorBuilder: (_, __) => SizedBox(height: 16),
              itemCount: list.length,
            );
          }
        },
      ),
    );
  }
}