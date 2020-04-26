// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OrderStore on _OrderStore, Store {
  Computed<List<OrderItem>> _$inProgressListComputed;

  @override
  List<OrderItem> get inProgressList => (_$inProgressListComputed ??=
          Computed<List<OrderItem>>(() => super.inProgressList))
      .value;

  final _$deliveryListRequestAtom =
      Atom(name: '_OrderStore.deliveryListRequest');

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

  final _$currentListAtom = Atom(name: '_OrderStore.currentList');

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

  final _$currentlyRingingOrderAtom =
      Atom(name: '_OrderStore.currentlyRingingOrder');

  @override
  OrderItem get currentlyRingingOrder {
    _$currentlyRingingOrderAtom.context
        .enforceReadPolicy(_$currentlyRingingOrderAtom);
    _$currentlyRingingOrderAtom.reportObserved();
    return super.currentlyRingingOrder;
  }

  @override
  set currentlyRingingOrder(OrderItem value) {
    _$currentlyRingingOrderAtom.context.conditionallyRunInAction(() {
      super.currentlyRingingOrder = value;
      _$currentlyRingingOrderAtom.reportChanged();
    }, _$currentlyRingingOrderAtom,
        name: '${_$currentlyRingingOrderAtom.name}_set');
  }

  final _$isRingingCurrentOrderAtom =
      Atom(name: '_OrderStore.isRingingCurrentOrder');

  @override
  bool get isRingingCurrentOrder {
    _$isRingingCurrentOrderAtom.context
        .enforceReadPolicy(_$isRingingCurrentOrderAtom);
    _$isRingingCurrentOrderAtom.reportObserved();
    return super.isRingingCurrentOrder;
  }

  @override
  set isRingingCurrentOrder(bool value) {
    _$isRingingCurrentOrderAtom.context.conditionallyRunInAction(() {
      super.isRingingCurrentOrder = value;
      _$isRingingCurrentOrderAtom.reportChanged();
    }, _$isRingingCurrentOrderAtom,
        name: '${_$isRingingCurrentOrderAtom.name}_set');
  }

  final _$isRingingSuccessAtom = Atom(name: '_OrderStore.isRingingSuccess');

  @override
  bool get isRingingSuccess {
    _$isRingingSuccessAtom.context.enforceReadPolicy(_$isRingingSuccessAtom);
    _$isRingingSuccessAtom.reportObserved();
    return super.isRingingSuccess;
  }

  @override
  set isRingingSuccess(bool value) {
    _$isRingingSuccessAtom.context.conditionallyRunInAction(() {
      super.isRingingSuccess = value;
      _$isRingingSuccessAtom.reportChanged();
    }, _$isRingingSuccessAtom, name: '${_$isRingingSuccessAtom.name}_set');
  }

  final _$fetchDeliveryListAsyncAction = AsyncAction('fetchDeliveryList');

  @override
  Future<dynamic> fetchDeliveryList() {
    return _$fetchDeliveryListAsyncAction.run(() => super.fetchDeliveryList());
  }

  final _$_OrderStoreActionController = ActionController(name: '_OrderStore');

  @override
  void messageNotification() {
    final _$actionInfo = _$_OrderStoreActionController.startAction();
    try {
      return super.messageNotification();
    } finally {
      _$_OrderStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reactToRingingOrder(bool accept) {
    final _$actionInfo = _$_OrderStoreActionController.startAction();
    try {
      return super.reactToRingingOrder(accept);
    } finally {
      _$_OrderStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void orderStartRing(OrderItem item) {
    final _$actionInfo = _$_OrderStoreActionController.startAction();
    try {
      return super.orderStartRing(item);
    } finally {
      _$_OrderStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void orderDelivered(OrderItem item) {
    final _$actionInfo = _$_OrderStoreActionController.startAction();
    try {
      return super.orderDelivered(item);
    } finally {
      _$_OrderStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void orderCancelled(OrderItem item) {
    final _$actionInfo = _$_OrderStoreActionController.startAction();
    try {
      return super.orderCancelled(item);
    } finally {
      _$_OrderStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'deliveryListRequest: ${deliveryListRequest.toString()},currentList: ${currentList.toString()},currentlyRingingOrder: ${currentlyRingingOrder.toString()},isRingingCurrentOrder: ${isRingingCurrentOrder.toString()},isRingingSuccess: ${isRingingSuccess.toString()},inProgressList: ${inProgressList.toString()}';
    return '{$string}';
  }
}
