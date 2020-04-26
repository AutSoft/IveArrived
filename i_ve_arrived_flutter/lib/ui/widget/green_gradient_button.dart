import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_ve_arrived/ui/color.dart';

class GradientButton extends StatelessWidget{
  final String title;
  final bool isLoading;
  final VoidCallback onPressed;
  final Gradient gradient;

  const GradientButton({Key key, this.title, this.isLoading, this.onPressed, this.gradient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
      padding: const EdgeInsets.all(0.0),
      child: Ink(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.all(Radius.circular(80.0)),
        ),
        child: Container(
          constraints: const BoxConstraints(minWidth: 88.0, minHeight: 36.0), // min sizes for Material buttons
          child: Stack(
            fit: StackFit.passthrough,
            children: <Widget>[
              Center(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (isLoading)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(height: 22, width: 22,child: Theme(data: Theme.of(context).copyWith(accentColor: Colors.white),child: CircularProgressIndicator(strokeWidth: 3,))),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

class GreenGradientButton extends StatelessWidget{
  final String title;
  final bool isLoading;
  final VoidCallback onPressed;

  const GreenGradientButton({Key key, this.title, this.isLoading, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientButton(
      title: title,
      isLoading: isLoading ?? false,
      onPressed: onPressed ?? (){},
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            parseColor("#47ae4c"),
            parseColor("#67c46b"),
          ]
      ),
    );
  }
}

class RedGradientButton extends StatelessWidget{
  final String title;
  final bool isLoading;
  final VoidCallback onPressed;

  const RedGradientButton({Key key, this.title, this.isLoading, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientButton(
      title: title,
      isLoading: isLoading ?? false,
      onPressed: onPressed ?? (){},
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            parseColor("#ef5814"),
            parseColor("#fb7a5f"),
          ]
      ),
    );
  }
}