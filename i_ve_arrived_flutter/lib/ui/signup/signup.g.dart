// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignupStore on _SignupStore, Store {
  final _$reqisterRequestAtom = Atom(name: '_SignupStore.reqisterRequest');

  @override
  ObservableFuture<dynamic> get reqisterRequest {
    _$reqisterRequestAtom.context.enforceReadPolicy(_$reqisterRequestAtom);
    _$reqisterRequestAtom.reportObserved();
    return super.reqisterRequest;
  }

  @override
  set reqisterRequest(ObservableFuture<dynamic> value) {
    _$reqisterRequestAtom.context.conditionallyRunInAction(() {
      super.reqisterRequest = value;
      _$reqisterRequestAtom.reportChanged();
    }, _$reqisterRequestAtom, name: '${_$reqisterRequestAtom.name}_set');
  }

  final _$runSignupAsyncAction = AsyncAction('runSignup');

  @override
  Future<dynamic> runSignup() {
    return _$runSignupAsyncAction.run(() => super.runSignup());
  }

  @override
  String toString() {
    final string = 'reqisterRequest: ${reqisterRequest.toString()}';
    return '{$string}';
  }
}
