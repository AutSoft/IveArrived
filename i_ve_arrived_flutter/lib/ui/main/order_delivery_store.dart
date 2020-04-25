import 'package:i_ve_arrived/remote/models.dart';
import 'package:i_ve_arrived/remote/service.dart';
import 'package:mobx/mobx.dart';
part 'order_delivery_store.g.dart';

class OrderDeliveryStore = _OrderDeliveryStore with _$OrderDeliveryStore;
abstract class _OrderDeliveryStore with Store {
  _OrderDeliveryStore() {
    currentList = ObservableList();
    fetchDeliveryList();
  }

  @observable
  ObservableFuture<OrderListResponse> deliveryListRequest;

  @observable
  ObservableList<OrderItem> currentList;

  @computed
  List<OrderItem> get inProgressList => currentList.where((it) => it.status == DeliveryStatus.IN_PROGRESS).toList();

  @action
  Future fetchDeliveryList() async {
    deliveryListRequest = ObservableFuture(service.fetchOrderList());
    await deliveryListRequest;
    currentList.clear();
    currentList.addAll(deliveryListRequest.value.resultList);
  }

  @action
  void orderDelivered(OrderItem item){
    var i = currentList.indexOf(item);
    currentList[i] = currentList[i].copyWith(status: DeliveryStatus.DELIVERED);
  }

  @action
  void orderCancelled(OrderItem item){
    var i = currentList.indexOf(item);
    currentList[i] = currentList[i].copyWith(status: DeliveryStatus.CANCELLED);
  }
}