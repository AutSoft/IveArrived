import 'package:animated_stream_list/animated_stream_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:i_ve_arrived/main.dart';
import 'package:i_ve_arrived/remote/models.dart';
import 'package:i_ve_arrived/remote/service.dart';
import 'package:i_ve_arrived/ui/main/order_store.dart';
import 'package:i_ve_arrived/ui/main/orderdetail/orderdetail.dart';
import 'package:i_ve_arrived/ui/widget/animated_list.dart';
import 'package:i_ve_arrived/ui/widget/map_snapshot.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DeliveryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Current Delivery")),
      body: Observer(
        builder: (context) {
          var pageStore = Provider.of<OrderStore>(context);
          if (pageStore.deliveryListRequest.status == FutureStatus.pending) {
            return Center(child: CircularProgressIndicator());
          } else {
            var list = pageStore.inProgressList;
            /*return AutomaticAnimatedList<OrderItem>(
              list: pageStore.inProgressList,
              builder: (OrderItem item, int index, BuildContext context, Animation<double> animation) {
                if (index == 0) {
                  return SizeTransition(
                    sizeFactor: animation,
                    child: CurrentDeliveryPanel(
                      key: ValueKey(item.id),
                      item: item,
                      onItemPressed: (item) {},
                    ),
                  );
                } else {
                  return SizeTransition(sizeFactor: animation,child: DeliveryItemWidget(item: item, onTap: () {},));
                }
              },
            );*/
          return SingleChildScrollView(
              child: Column(children: [
                CurrentDeliveryPanel(
                  key: ValueKey(list[0].packageId),
                  item: list[0],
                  onItemPressed: (item) {Navigator.of(context).push(route(() => OrderDetailPage(item: item,)));},
                  isRinging: pageStore.isRingingCurrentOrder,
                  onRingingPressed: () => pageStore.orderStartRing(list[0]),
                  onDeliveredPressed: () => pageStore.orderDelivered(list[0]),
                  onCancelPressed: () => pageStore.orderCancelled(list[0]),
                ),
                NextDeliveriesPanel(
                  items: list.skip(1).toList(),
                  onItemPressed: (item) {Navigator.of(context).push(route(() => OrderDetailPage(item: item,)));},
                )
              ]),
            );
          }
        },
      ),
    );
  }
}

class CurrentDeliveryPanel extends StatelessWidget {
  final OrderItem item;
  final void Function(OrderItem) onItemPressed;
  final bool isRinging;
  final VoidCallback onRingingPressed;
  final VoidCallback onDeliveredPressed;
  final VoidCallback onCancelPressed;

  const CurrentDeliveryPanel({Key key, this.item, this.onItemPressed, this.isRinging, this.onRingingPressed, this.onDeliveredPressed, this.onCancelPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var orderDeliveryStore = Provider.of<OrderStore>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text("Next address:"),
          DeliveryItemWidget(
            item: item,
            onTap: () => onItemPressed(item),
          ),
          SizedBox(
            height: 200,
            width: double.infinity,
            child: MapSnapshot(
              address: item.address,
              onPressed: () async {
                var url = "https://www.google.com/maps/dir/?api=1&destination=${Uri.encodeFull(item.address)}";
                if (await canLaunch(url)) {
                  launch(url);
                }
              },
            ),
          ),
          AnimatedCrossFade(
            firstChild: RaisedButton(
              child: Container(width: 100, alignment: Alignment.center, child: Text("Hívás/Csengő")),
              onPressed: onRingingPressed,
            ),
            secondChild: Column(
              children: <Widget>[
                RaisedButton(
                  child: Container(width: 100, alignment: Alignment.center, child: Text("Átvette")),
                  onPressed: onDeliveredPressed,
                ),
                RaisedButton(
                  child: Container(width: 100, alignment: Alignment.center, child: Text("Nem vette át")),
                  onPressed: onCancelPressed,
                )
              ],
            ),
            crossFadeState: isRinging ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: kDefaultAnimationDuration,
            firstCurve: kDefaultAnimationCurve,
            secondCurve: kDefaultAnimationCurve,
            sizeCurve: kDefaultAnimationCurve,
          )
        ],
      ),
    );
  }
}

class NextDeliveriesPanel extends StatelessWidget {
  final List<OrderItem> items;
  final void Function(OrderItem) onItemPressed;

  const NextDeliveriesPanel({Key key, this.items, this.onItemPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text("Soron következő címeid (${items.length})"),
        ListView.separated(
          primary: false,
          shrinkWrap: true,
          itemBuilder: (context, i) => DeliveryItemWidget(item: items[i], onTap: () => onItemPressed(items[i]),),
          separatorBuilder: (_, __) => SizedBox(height: 8),
          itemCount: items.length,
        ),
      ],
    );
  }
}

class DeliveryItemWidget extends StatelessWidget {
  final OrderItem item;
  final VoidCallback onTap;

  const DeliveryItemWidget({Key key, this.item, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onTap,
      child: Container(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(item.packageId),
            Text(item.orderDate),
            Text(item.address),
          ],
        ),
      ),
    );
  }
}
