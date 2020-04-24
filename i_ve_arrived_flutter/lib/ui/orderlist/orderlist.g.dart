// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderlist.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OrderListStore on _OrderListStore, Store {
  final _$orderRequestAtom = Atom(name: '_OrderListStore.orderRequest');

  @override
  ObservableFuture<OrderListClientResponse> get orderRequest {
    _$orderRequestAtom.context.enforceReadPolicy(_$orderRequestAtom);
    _$orderRequestAtom.reportObserved();
    return super.orderRequest;
  }

  @override
  set orderRequest(ObservableFuture<OrderListClientResponse> value) {
    _$orderRequestAtom.context.conditionallyRunInAction(() {
      super.orderRequest = value;
      _$orderRequestAtom.reportChanged();
    }, _$orderRequestAtom, name: '${_$orderRequestAtom.name}_set');
  }

  @override
  String toString() {
    final string = 'orderRequest: ${orderRequest.toString()}';
    return '{$string}';
  }
}
