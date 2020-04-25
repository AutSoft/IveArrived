import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_ve_arrived/main.dart';
import 'package:i_ve_arrived/remote/models.dart';
import 'package:i_ve_arrived/remote/service.dart';
import 'package:i_ve_arrived/ui/main/delivery/delivery_history_list.dart';
import 'package:i_ve_arrived/ui/main/order_store.dart';
import 'package:i_ve_arrived/ui/main/orderlist/orderlist.dart';
import 'package:i_ve_arrived/ui/main/places/places.dart';
import 'package:i_ve_arrived/ui/main/profile/profile.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import 'delivery/delivery.dart';

class TestPage extends StatelessWidget {
  final String title;

  const TestPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(title),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var selectedPage = 0;

  List<Widget> widgets;
  List<GlobalKey> navigatorKeys;

  OrderStore pageStore;
  ReactionDisposer reactionDisposer;

  @override
  void initState() {
    widgets = isDeliveryMode
        ? [
            DeliveryPage(),
            DeliveryHistoryPage(
              filterStatus: DeliveryStatus.DeliveryInProgress,
            ),
            DeliveryHistoryPage(
              filterStatus: DeliveryStatus.DeliveryFailed,
            ),
            ProfilePage(),
          ]
        : [
            OrderListPage(),
            PlacesPage(),
            ProfilePage(),
          ];
    navigatorKeys = widgets.map((_) => GlobalKey()).toList();
    () async {
      var token = await firebaseMessaging.getToken();
      service.addFirebaseToken(token);
    }();

    pageStore = OrderStore();
    reactionDisposer = reaction((_) => pageStore.currentlyRingingOrder, (item) {
      if (item != null && !isDeliveryMode) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text("Order is ringing"),
              content: Text("Can you accept the order?"),
              actions: <Widget>[
                FlatButton(
                  child: Text("No"),
                  onPressed: () => pageStore.reactToRingingOrder(false),
                ),
                FlatButton(
                  child: Text("Yes"),
                  onPressed: () => pageStore.reactToRingingOrder(true),
                )
              ],
            );
          },
        );
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    reactionDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<OrderStore>.value(
      value: pageStore,
      child: Scaffold(
        primary: false,
        body: WillPopScope(
          child: Stack(
            fit: StackFit.expand,
            children: [
              for (int i = 0; i < widgets.length; i++)
                Positioned.fill(
                  child: IgnorePointer(
                    ignoring: i != selectedPage,
                    child: AnimatedOpacity(
                      child: Navigator(
                        key: navigatorKeys[i],
                        initialRoute: "/",
                        onGenerateRoute: (_) => routeContext(
                          (context) => widgets[i],
                        ),
                      ),
                      opacity: selectedPage == i ? 1 : 0,
                      duration: kDefaultAnimationDuration,
                    ),
                  ),
                ),
            ],
          ),
          onWillPop: () async {
            var subNavigator = navigatorKeys[selectedPage].currentState as NavigatorState;
            if (subNavigator.canPop()) {
              return !(await subNavigator.maybePop());
            } else {
              return true;
            }
          },
        ),
        /*AnimatedCrossFadeExtended(
          children: <Widget>[
            DeliveryPage(),
            TestPage(title: "Map"),
          ],
          currentChildPosition: selectedPage,
          duration: kDefaultAnimationDuration,
          curve: kDefaultAnimationCurve,
        ),*/
        bottomNavigationBar: BottomNavigationBar(
          items: isDeliveryMode
              ? [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    title: Text("Home"),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.check),
                    title: Text("Delivered"),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.delete),
                    title: Text("Cancelled"),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle),
                    title: Text("Profile"),
                  ),
                ]
              : [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    title: Text("Orders"),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.store),
                    title: Text("Stores"),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle),
                    title: Text("Profile"),
                  ),
                ],
          currentIndex: selectedPage,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.amber[800],
          onTap: (i) {
            setState(() {
              selectedPage = i;
            });
          },
        ),
      ),
    );
  }
}

class AnimatedCrossFadeExtended extends StatefulWidget {
  final List<Widget> children;
  final int currentChildPosition;
  final Duration duration;
  final Curve curve;

  AnimatedCrossFadeExtended({Key key, @required this.children, @required this.currentChildPosition, @required this.duration, @required this.curve}) : super(key: key);

  @override
  _AnimatedCrossFadeExtendedState createState() => _AnimatedCrossFadeExtendedState();
}

class _AnimatedCrossFadeExtendedState extends State<AnimatedCrossFadeExtended> {
  int firstChildPosition;
  int secondChildPosition;
  CrossFadeState crossFadeState;

  @override
  void initState() {
    firstChildPosition = widget.currentChildPosition;
    secondChildPosition = 0;
    crossFadeState = CrossFadeState.showFirst;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (crossFadeState == CrossFadeState.showFirst && firstChildPosition != widget.currentChildPosition) {
      setState(() {
        secondChildPosition = widget.currentChildPosition;
        crossFadeState = CrossFadeState.showSecond;
      });
    } else if (crossFadeState == CrossFadeState.showSecond && secondChildPosition != widget.currentChildPosition) {
      setState(() {
        firstChildPosition = widget.currentChildPosition;
        crossFadeState = CrossFadeState.showFirst;
      });
    }
    return AnimatedCrossFade(
      firstChild: AbsorbPointer(absorbing: crossFadeState == CrossFadeState.showSecond, child: widget.children[firstChildPosition]),
      secondChild: AbsorbPointer(absorbing: crossFadeState == CrossFadeState.showFirst, child: widget.children[secondChildPosition]),
      crossFadeState: crossFadeState,
      duration: widget.duration,
      firstCurve: widget.curve,
      secondCurve: widget.curve,
    );
  }
}
