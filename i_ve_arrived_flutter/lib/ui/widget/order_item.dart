import 'package:flutter/material.dart';
import 'package:i_ve_arrived/remote/models.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderItem item;
  final void Function(OrderItem) onItemPressed;

  const OrderItemWidget({Key key, this.item, this.onItemPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () => onItemPressed?.call(item),
      child: Container(
        height: 80,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              item.packageId,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              item.orderDate,
              style: TextStyle(fontSize: 16),
            ),
            Text("Status: ${item.state}")
          ],
        ),
      ),
    );
  }
}
