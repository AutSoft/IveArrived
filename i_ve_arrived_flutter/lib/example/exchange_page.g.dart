// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_page.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ExchangePageStore on _ExchangePageStore, Store {
  final _$rateRequestAtom = Atom(name: '_ExchangePageStore.rateRequest');

  @override
  ObservableFuture<RateResponse> get rateRequest {
    _$rateRequestAtom.context.enforceReadPolicy(_$rateRequestAtom);
    _$rateRequestAtom.reportObserved();
    return super.rateRequest;
  }

  @override
  set rateRequest(ObservableFuture<RateResponse> value) {
    _$rateRequestAtom.context.conditionallyRunInAction(() {
      super.rateRequest = value;
      _$rateRequestAtom.reportChanged();
    }, _$rateRequestAtom, name: '${_$rateRequestAtom.name}_set');
  }

  final _$_ExchangePageStoreActionController =
      ActionController(name: '_ExchangePageStore');

  @override
  void fetchRateRequest() {
    final _$actionInfo = _$_ExchangePageStoreActionController.startAction();
    try {
      return super.fetchRateRequest();
    } finally {
      _$_ExchangePageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'rateRequest: ${rateRequest.toString()}';
    return '{$string}';
  }
}
