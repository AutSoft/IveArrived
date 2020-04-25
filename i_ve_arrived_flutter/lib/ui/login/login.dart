import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_focus_watcher/flutter_focus_watcher.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:i_ve_arrived/main.dart';
import 'package:i_ve_arrived/remote/service.dart';
import 'package:i_ve_arrived/ui/main/main.dart';
import 'package:i_ve_arrived/ui/signup/signup.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

part 'login.g.dart';

class LoginPageStore = _LoginPageStore with _$LoginPageStore;
abstract class _LoginPageStore with Store {

  @observable
  ObservableFuture loginRequest;

  @action
  Future startLogin() async{
    loginRequest = ObservableFuture(service.loginUser(emailController.text, passwordController.text));
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<LoginPageStore>(
      create: (_) => LoginPageStore(),
      child: FocusWatcher(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text("Login"),
          ),
          body: Observer(
            builder: (context) {
              var pageStore = Provider.of<LoginPageStore>(context);
              var isLoading = pageStore.loginRequest?.status == FutureStatus.pending;
              return Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        FlutterLogo(
                          size: 240,
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        TextField(
                          controller: pageStore.emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "E-mail",
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextField(
                          controller: pageStore.passwordController,
                          obscureText: true,
                          onSubmitted: (_) async {
                            pageStore.startLogin();
                            await pageStore.loginRequest;
                            Navigator.of(context).pushReplacement(route(() => MainPage()));
                          },
                          decoration: InputDecoration(
                            hintText: "Password",
                          ),
                        ),
                        SizedBox(height: 16),
                        RaisedButton(
                          child: Text("Login"),
                          onPressed: () async{
                            pageStore.startLogin();
                            await pageStore.loginRequest;
                            Navigator.of(context).pushReplacement(route(() => MainPage()));
                          },
                        ),
                        RaisedButton(
                          child: Text("Signup"),
                          onPressed: () {
                            Navigator.of(context).push(route(() => SignupPage()));
                          },
                        ),
                      ],
                    ),
                  ),
                  Positioned.fill(
                    child: AnimatedOpacity(
                      duration: kDefaultAnimationDuration,
                      opacity: isLoading ? 1 : 0,
                      child: Container(
                        color: isLoading ? Colors.black.withOpacity(0.6) : null,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
