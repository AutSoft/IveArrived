import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:i_ve_arrived/main.dart';
import 'package:i_ve_arrived/remote/models.dart';
import 'package:i_ve_arrived/remote/service.dart';
import 'package:i_ve_arrived/ui/color.dart';
import 'package:i_ve_arrived/ui/main/me_store.dart';
import 'package:i_ve_arrived/ui/main/order_store.dart';
import 'package:i_ve_arrived/ui/main/orderdetail/orderdetail.dart';
import 'package:i_ve_arrived/ui/widget/order_item.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class OrderListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: parseColor("#f6f7fa"),
      body: Observer(
        builder: (context) {
          var pageStore = Provider.of<OrderStore>(context);
          var list = pageStore.currentList ?? [];
          return Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 240,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        parseColor("#4bb04f"),
                        parseColor("#5dbd61"),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 37,
                right: 30,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(500),
                  child: Observer(builder: (context) {
                    var meStore = Provider.of<MeStore>(context);
                    var url = meStore.myRequest?.value?.logoUrl;
                    return url == null ? Container() : Image.network(
                       url == "string" ? placeholderProfileUrl : url,
                      width: 57,
                      height: 57,
                    );
                  }),
                ),
              ),
              Positioned(
                top: 70,
                left: 40,
                child: Text(
                  "My packages",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Positioned.fill(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    SizedBox(
                      height: 111,
                    ),
                    Container(
                      constraints: BoxConstraints(minHeight: 180),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
                        color: parseColor("#f6f7fa"),
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 27.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Packages on the way",
                                  style: TextStyle(color: parseColor("#52b556"), fontSize: 14, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(width: 20),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(100), boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 6,
                                      )
                                    ]),
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 12,
                                        ),
                                        Icon(
                                          Icons.search,
                                          size: 14,
                                          color: parseColor("#acacac"),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                          child: TextField(
                                            style: TextStyle(fontSize: 14),
                                            decoration: InputDecoration(
                                              isDense: true,
                                              border: InputBorder.none,
                                              hintText: "Search...",
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 12,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListView.separated(
                            primary: false,
                            shrinkWrap: true,
                            itemBuilder: (_, i) => OrderItemWidget(
                              item: list[i],
                              onItemPressed: (item) {
                                Navigator.of(context).push(route(() => OrderDetailPage(
                                      item: item,
                                    )));
                              },
                            ),
                            separatorBuilder: (_, __) => SizedBox(
                              height: 11,
                            ),
                            itemCount: list.length,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
