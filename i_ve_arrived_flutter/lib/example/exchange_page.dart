import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:i_ve_arrived/example/remote/model.dart';
import 'package:i_ve_arrived/example/remote/service.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
part 'exchange_page.g.dart';

class ExchangePageStore = _ExchangePageStore with _$ExchangePageStore;
abstract class _ExchangePageStore with Store{

  _ExchangePageStore(){
    fetchRateRequest();
  }

  @observable
  ObservableFuture<RateResponse> rateRequest;

  @action
  void fetchRateRequest(){
    rateRequest = ObservableFuture(exampleService.fetchRates());
  }
}


class ExchangePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rates"),),
      body: Provider(
          create: (_) => ExchangePageStore(),
          child: Observer(
            builder: (context){
              var store = Provider.of<ExchangePageStore>(context);

              if (store.rateRequest.status == FutureStatus.pending){
                return Center(
                  child: CircularProgressIndicator(),
                )   ;
              } else if (store.rateRequest.status == FutureStatus.fulfilled) {
                var data = store.rateRequest.value;
                return GridView.count(
                  childAspectRatio: 1.0,
                  crossAxisCount: 2,
                  children: data.rates.entries.map((entry) => ExchangePanel(currency: entry.key, rate: entry.value,)).toList(),
                );
              } else {
                return Container();
              }
            },
          ),
      ),
    );
  }
}

class ExchangePanel extends StatelessWidget{
  final String currency;
  final num rate;

  const ExchangePanel({Key key, this.currency, this.rate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      elevation: 10,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 40,
              child: Text(
                currency,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Text(
              rate.toString(),
            ),
          ],
        ),
      ),
    );
  }
}