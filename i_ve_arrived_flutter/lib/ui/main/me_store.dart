import 'package:i_ve_arrived/remote/models.dart';
import 'package:i_ve_arrived/remote/service.dart';
import 'package:mobx/mobx.dart';

part 'me_store.g.dart';

class MeStore = _MeStore with _$MeStore;
abstract class _MeStore with Store{
  _MeStore(){
    fetchMyData();
  }

  @observable
  ObservableFuture<MeData> myRequest;

  @action
  void fetchMyData(){
    myRequest = ObservableFuture(service.fetchMeData());
  }
}