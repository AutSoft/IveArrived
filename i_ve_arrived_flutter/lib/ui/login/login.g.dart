// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginPageStore on _LoginPageStore, Store {
  final _$loginRequestAtom = Atom(name: '_LoginPageStore.loginRequest');

  @override
  ObservableFuture<dynamic> get loginRequest {
    _$loginRequestAtom.context.enforceReadPolicy(_$loginRequestAtom);
    _$loginRequestAtom.reportObserved();
    return super.loginRequest;
  }

  @override
  set loginRequest(ObservableFuture<dynamic> value) {
    _$loginRequestAtom.context.conditionallyRunInAction(() {
      super.loginRequest = value;
      _$loginRequestAtom.reportChanged();
    }, _$loginRequestAtom, name: '${_$loginRequestAtom.name}_set');
  }

  final _$startLoginAsyncAction = AsyncAction('startLogin');

  @override
  Future<dynamic> startLogin() {
    return _$startLoginAsyncAction.run(() => super.startLogin());
  }

  @override
  String toString() {
    final string = 'loginRequest: ${loginRequest.toString()}';
    return '{$string}';
  }
}
