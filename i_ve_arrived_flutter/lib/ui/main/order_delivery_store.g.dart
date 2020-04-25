// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_delivery_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OrderDeliveryStore on _OrderDeliveryStore, Store {
  Computed<List<OrderItem>> _$inProgressListComputed;

  @override
  List<OrderItem> get inProgressList => (_$inProgressListComputed ??=
          Computed<List<OrderItem>>(() => super.inProgressList))
      .value;

  final _$deliveryListRequestAtom =
      Atom(name: '_OrderDeliveryStore.deliveryListRequest');

  @override
  ObservableFuture<OrderListResponse> get deliveryListRequest {
    _$deliveryListRequestAtom.context
        .enforceReadPolicy(_$deliveryListRequestAtom);
    _$deliveryListRequestAtom.reportObserved();
    return super.deliveryListRequest;
  }

  @override
  set deliveryListRequest(ObservableFuture<OrderListResponse> value) {
    _$deliveryListRequestAtom.context.conditionallyRunInAction(() {
      super.deliveryListRequest = value;
      _$deliveryListRequestAtom.reportChanged();
    }, _$deliveryListRequestAtom,
        name: '${_$deliveryListRequestAtom.name}_set');
  }

  final _$currentListAtom = Atom(name: '_OrderDeliveryStore.currentList');

  @override
  ObservableList<OrderItem> get currentList {
    _$currentListAtom.context.enforceReadPolicy(_$currentListAtom);
    _$currentListAtom.reportObserved();
    return super.currentList;
  }

  @override
  set currentList(ObservableList<OrderItem> value) {
    _$currentListAtom.context.conditionallyRunInAction(() {
      super.currentList = value;
      _$currentListAtom.reportChanged();
    }, _$currentListAtom, name: '${_$currentListAtom.name}_set');
  }

  final _$fetchDeliveryListAsyncAction = AsyncAction('fetchDeliveryList');

  @override
  Future<dynamic> fetchDeliveryList() {
    return _$fetchDeliveryListAsyncAction.run(() => super.fetchDeliveryList());
  }

  final _$_OrderDeliveryStoreActionController =
      ActionController(name: '_OrderDeliveryStore');

  @override
  void orderDelivered(OrderItem item) {
    final _$actionInfo = _$_OrderDeliveryStoreActionController.startAction();
    try {
      return super.orderDelivered(item);
    } finally {
      _$_OrderDeliveryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void orderCancelled(OrderItem item) {
    final _$actionInfo = _$_OrderDeliveryStoreActionController.startAction();
    try {
      return super.orderCancelled(item);
    } finally {
      _$_OrderDeliveryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'deliveryListRequest: ${deliveryListRequest.toString()},currentList: ${currentList.toString()},inProgressList: ${inProgressList.toString()}';
    return '{$string}';
  }
}
