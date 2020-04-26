import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_focus_watcher/flutter_focus_watcher.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_ve_arrived/main.dart';
import 'package:i_ve_arrived/remote/service.dart';
import 'package:i_ve_arrived/ui/color.dart';
import 'package:i_ve_arrived/ui/main/main.dart';
import 'package:i_ve_arrived/ui/signup/signup.dart';
import 'package:i_ve_arrived/ui/widget/green_gradient_button.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

part 'login.g.dart';

class LoginPageStore = _LoginPageStore with _$LoginPageStore;

abstract class _LoginPageStore with Store {
  @observable
  ObservableFuture loginRequest;

  @action
  Future startLogin() async {
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
          backgroundColor: parseColor("#f6f7fa"),
          resizeToAvoidBottomInset: false,
          body: Observer(
            builder: (context) {
              var pageStore = Provider.of<LoginPageStore>(context);
              var isLoading = pageStore.loginRequest?.status == FutureStatus.pending;
              return Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Positioned(
                    left: 0,
                    top: 0,
                    right: 0,
                    height: 223,
                    child: SvgPicture.asset("images/hullamos_hatter.svg", fit: BoxFit.fill,),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        height: 223,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 33.8,
                            ),
                            SvgPicture.asset("images/ive_arrived_logo_ccolored.svg", color: Colors.white),
                            SizedBox(
                              height: 12.2,
                            ),
                            Text(
                              "We are glad you arrived!",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(43),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.16),
                                blurRadius: 25,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          height: 270,
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 24),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                child: TextField(
                                  controller: pageStore.emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  style: TextStyle(
                                    color: parseColor("#5d5d5d"),
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.start,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.alternate_email,
                                      size: 14,
                                      color: parseColor("#acd9ae"),
                                    ),
                                    hintText: "E-mail",
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                child: TextField(
                                  controller: pageStore.passwordController,
                                  obscureText: true,
                                  onSubmitted: (_) async {
                                    pageStore.startLogin();
                                    await pageStore.loginRequest;
                                    Navigator.of(context).pushReplacement(route(() => MainPage()));
                                  },
                                  style: TextStyle(
                                    color: parseColor("#5d5d5d"),
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.start,
                                  decoration: InputDecoration(
                                    prefixIcon: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 17),
                                        child: SvgPicture.asset(
                                          "images/password.svg",
                                          width: 14,
                                          height: 14,
                                          color: parseColor("#acd9ae"),
                                        ),
                                      ),
                                    ),
                                    hintText: "Password",
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(right: 24),
                                child: Text(
                                  "Forgot password?",
                                  style: TextStyle(
                                    color: parseColor("#47ae4c"),
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 38),
                                child: GreenGradientButton(
                                  title: "Log in",
                                  onPressed: () async {
                                    pageStore.startLogin();
                                    await pageStore.loginRequest;
                                    Navigator.of(context).pushReplacement(route(() => MainPage()));
                                  },
                                  isLoading: pageStore.loginRequest?.status == FutureStatus.pending,
                                ),
                              ),
                              SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 29,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Image.asset(
                            "images/facebook_circle.png",
                            height: 44,
                            width: 44,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Image.asset(
                            "images/google_icon.png",
                            height: 44,
                            width: 44,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(route(() => SignupPage()));
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                color: parseColor("#a7a7a7"),
                                fontSize: 14
                              ),
                            ),
                            SizedBox(width: 8,),
                            Text(
                              "Sign up",
                              style: TextStyle(
                                  color: parseColor("#47ae4c"),
                                  fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
