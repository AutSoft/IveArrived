// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'me_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MeStore on _MeStore, Store {
  final _$myRequestAtom = Atom(name: '_MeStore.myRequest');

  @override
  ObservableFuture<MeData> get myRequest {
    _$myRequestAtom.context.enforceReadPolicy(_$myRequestAtom);
    _$myRequestAtom.reportObserved();
    return super.myRequest;
  }

  @override
  set myRequest(ObservableFuture<MeData> value) {
    _$myRequestAtom.context.conditionallyRunInAction(() {
      super.myRequest = value;
      _$myRequestAtom.reportChanged();
    }, _$myRequestAtom, name: '${_$myRequestAtom.name}_set');
  }

  final _$_MeStoreActionController = ActionController(name: '_MeStore');

  @override
  void fetchMyData() {
    final _$actionInfo = _$_MeStoreActionController.startAction();
    try {
      return super.fetchMyData();
    } finally {
      _$_MeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'myRequest: ${myRequest.toString()}';
    return '{$string}';
  }
}
