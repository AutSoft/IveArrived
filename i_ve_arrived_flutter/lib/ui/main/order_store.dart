import 'package:i_ve_arrived/main.dart';
import 'package:i_ve_arrived/remote/models.dart';
import 'package:i_ve_arrived/remote/service.dart';
import 'package:mobx/mobx.dart';
part 'order_store.g.dart';

class OrderStore = _OrderStore with _$OrderStore;
abstract class _OrderStore with Store {
  _OrderStore() {
    currentList = ObservableList();
    fetchDeliveryList();
  }

  void dispose(){
    print("DISPOSING!");
    lastMessageNotifier.removeListener(messageNotification);
  }

  @action
  void messageNotification(){
    var message = lastMessageNotifier.value as Map<dynamic, dynamic>;
    if (message.isNotEmpty){
      message = message["data"] as Map<dynamic, dynamic>;
      var packageId = message["PackageId"] as String;
      var orderItem = currentList.firstWhere((it) => it.packageId == packageId);
      if (orderItem != null) {
        if (message["MessageType"] == "DoorBell") {
          currentlyRingingOrder = orderItem;
        } else if (message["MessageType"] == "DoorBellResponse") {
          isRingingSuccess = message["IsAvailable"] == "True";
        } else if (message["MessageType"] == "ChangeDeliveryState"){
          var newState = DeliveryStatus.values.firstWhere((it) => it.toString() == message["State"]);
          var index = currentList.indexOf(orderItem);
          currentList[index] = orderItem.copyWith(state: newState);
        }
      }
      lastMessageNotifier.value = {};
    }
  }

  @observable
  ObservableFuture<OrderListResponse> deliveryListRequest;

  @observable
  ObservableList<OrderItem> currentList;

  @observable
  OrderItem currentlyRingingOrder;

  @action
  void reactToRingingOrder(bool accept){
    service.orderRingingResponse(currentlyRingingOrder.packageId, accept);
    currentlyRingingOrder = null;
  }

  @observable
  bool isRingingCurrentOrder = false;

  @observable
  bool isRingingSuccess;

  @computed
  List<OrderItem> get inProgressList => currentList.where((it) => it.state == DeliveryStatus.DeliveryInProgress).toList();

  @action
  Future fetchDeliveryList() async {
    lastMessageNotifier.removeListener(messageNotification);
    if (isDeliveryMode) {
      deliveryListRequest = ObservableFuture(service.fetchOrderListCourier());
    } else {
      deliveryListRequest = ObservableFuture(service.fetchOrderListRecipient());
    }
    await deliveryListRequest;
    currentList.clear();
    currentList.addAll(deliveryListRequest.value.resultList);
    lastMessageNotifier.addListener(messageNotification);
    messageNotification();
  }

  @action
  void orderStartRing(OrderItem item){
    isRingingCurrentOrder = true;
    isRingingSuccess = null;
    () async{
      var firebaseToken = await firebaseMessaging.getToken();
      service.startOrderRinging(item.packageId, firebaseToken);
    }();
  }

  @action
  void orderDelivered(OrderItem item){
    var i = currentList.indexOf(item);
    currentList[i] = currentList[i].copyWith(state: DeliveryStatus.DeliverySuccess);
    isRingingCurrentOrder = false;
    isRingingSuccess = null;
    service.finishOrder(item.packageId, true);
  }

  @action
  void orderCancelled(OrderItem item){
    var i = currentList.indexOf(item);
    currentList[i] = currentList[i].copyWith(state: DeliveryStatus.DeliveryFailed);
    isRingingCurrentOrder = false;
    isRingingSuccess = null;
    service.finishOrder(item.packageId, false);
  }

  @action
  Future subscribeToOrder(String packageId) async{
    var firebaseToken = await firebaseMessaging.getToken();
    await deliveryListRequest;
    await service.subscribeToOrder(packageId, firebaseToken);
    await fetchDeliveryList();
  }
}