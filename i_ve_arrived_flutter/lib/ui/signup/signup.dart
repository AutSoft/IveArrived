import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:i_ve_arrived/main.dart';
import 'package:i_ve_arrived/remote/service.dart';
import 'package:i_ve_arrived/ui/main/main.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
part 'signup.g.dart';

class SignupStore = _SignupStore with _$SignupStore;
abstract class _SignupStore with Store{
  @observable
  ObservableFuture reqisterRequest;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @action
  Future runSignup() async{
    reqisterRequest = ObservableFuture(isDeliveryMode ? service.signupCourier(passwordController.text, emailController.text) : service.signupUser(passwordController.text, emailController.text));
    await reqisterRequest;
    await service.loginUser(emailController.text, passwordController.text);
  }
}

class SignupPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Signup"),),
      body: Provider(
        create: (_) => SignupStore(),
        child: Observer(
          builder: (context){
            var pageStore = Provider.of<SignupStore>(context);
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: pageStore.emailController,
                    ),
                    TextField(
                      controller: pageStore.passwordController,
                    ),
                    RaisedButton(
                      child: Text("Signup"),
                      onPressed: () async{
                        await pageStore.runSignup();
                        Navigator.pushAndRemoveUntil(context, route(() => MainPage()), (_) => false);
                      },
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

}