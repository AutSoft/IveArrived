import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:i_ve_arrived/remote/models.dart';
import 'package:i_ve_arrived/remote/service.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

part 'orderlist.g.dart';

class OrderListStore = _OrderListStore with _$OrderListStore;

abstract class _OrderListStore with Store {
  _OrderListStore() {
    orderRequest = ObservableFuture(service.fetchOrderList());
  }

  @observable
  ObservableFuture<OrderListClientResponse> orderRequest;
}

class OrderListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => OrderListStore(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Orders"),
        ),
        body: Observer(
          builder: (context) {
            var pageStore = Provider.of<OrderListStore>(context);
            if (pageStore.orderRequest.status == FutureStatus.pending) {
              return Center(child: CircularProgressIndicator());
            } else {
              var list = pageStore.orderRequest?.value?.resultList ?? [];
              return ListView.separated(
                itemBuilder: (context, i) {
                  var item = list[i];
                  return OrderItemWidget(
                    id: item.id,
                    date: item.orderDate,
                  );
                },
                separatorBuilder: (_, __) => SizedBox(height: 16),
                itemCount: list.length,
              );
            }
          },
        ),
      ),
    );
  }
}

class OrderItemWidget extends StatelessWidget {
  final String id;
  final String date;

  const OrderItemWidget({Key key, this.id, this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 80,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              id,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              date,
              style: TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
