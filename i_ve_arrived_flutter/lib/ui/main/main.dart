import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_ve_arrived/main.dart';
import 'package:i_ve_arrived/remote/models.dart';
import 'package:i_ve_arrived/remote/service.dart';
import 'package:i_ve_arrived/ui/color.dart';
import 'package:i_ve_arrived/ui/main/delivery/delivery_history_list.dart';
import 'package:i_ve_arrived/ui/main/doorbell/doorbell.dart';
import 'package:i_ve_arrived/ui/main/me_store.dart';
import 'package:i_ve_arrived/ui/main/order_store.dart';
import 'package:i_ve_arrived/ui/main/orderlist/orderlist.dart';
import 'package:i_ve_arrived/ui/main/places/places.dart';
import 'package:i_ve_arrived/ui/main/profile/profile.dart';
import 'package:i_ve_arrived/ui/widget/fullscreen_dialog.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart';

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
  StreamSubscription linkSubscription;

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
            ProfilePage(),
            PlacesPage(),
          ];
    navigatorKeys = widgets.map((_) => GlobalKey()).toList();
    () async {
      var token = await firebaseMessaging.getToken();
      service.addFirebaseToken(token);
    }();

    pageStore = OrderStore();
    //reactionDisposer = reaction((_) => pageStore.currentlyRingingOrder?.packageId, (text) async {
      reactionDisposer = reaction((_) => pageStore.currentList?.firstWhere((_) => true, orElse: null)?.packageId, (itemId) async {
      var item = pageStore.currentList?.firstWhere((it) => it.packageId == itemId, orElse: null);
      if (item != null && !isDeliveryMode) {
        FlutterRingtonePlayer.playAlarm();
        var result = await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => FullscreenDialog(
            builder: (_) => DoorbellPage(item: item),
          ),
        );
        if (result != null) {
          pageStore.reactToRingingOrder(result);
        }
        FlutterRingtonePlayer.stop();
      }
    });
    () async {
      linkSubscription = getLinksStream().listen(_handleLink);
      var url = await getInitialLink();
      _handleLink(url);
    }();

    super.initState();
  }

  void _handleLink(String url) {
    if (url != null) {
      var part = url.split("/").last;
      var packageId = Uri.decodeFull(part);
      print(packageId);
      pageStore.subscribeToOrder(packageId);
    }
  }

  @override
  void dispose() {
    pageStore.dispose();
    reactionDisposer();
    linkSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => MeStore(),
      child: Provider<OrderStore>.value(
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
            elevation: 20,
            items: isDeliveryMode
                ? [
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset("images/address.svg"),
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
                      icon: SvgPicture.asset(
                        "images/my_packages_icon_grey.svg",
                        color: selectedPage == 0 ? parseColor("#47ae4c") : null,
                      ),
                      title: Text(
                        "MY PACKAGES",
                        style: TextStyle(
                          fontWeight: selectedPage == 0 ? FontWeight.w600 : null,
                        ),
                      ),
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        "images/user.svg",
                        color: selectedPage == 1 ? parseColor("#47ae4c") : null,
                      ),
                      title: Text(
                        "MY PROFILE",
                        style: TextStyle(
                          fontWeight: selectedPage == 1 ? FontWeight.w600 : null,
                        ),
                      ),
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        "images/address.svg",
                        color: selectedPage == 2 ? parseColor("#47ae4c") : null,
                      ),
                      title: Text(
                        "LOCAL STORES",
                        style: TextStyle(
                          fontWeight: selectedPage == 2 ? FontWeight.w600 : null,
                        ),
                      ),
                    ),
                  ],
            currentIndex: selectedPage,
            selectedItemColor: parseColor("#928f8f"),
            unselectedItemColor: parseColor("#928f8f"),
            selectedFontSize: 10,
            unselectedFontSize: 10,
            onTap: (i) {
              setState(() {
                selectedPage = i;
              });
            },
          ),
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
