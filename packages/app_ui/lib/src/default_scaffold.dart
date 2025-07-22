import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class DefaultScaffold extends StatelessWidget {
  const DefaultScaffold({
    super.key,
    required this.body,
    required this.title,
  });

  final Widget body;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            shadowColor: Colors.transparent,
            title: Text(
              //textAlign: TextAlign.left,
              title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.backgroundGradientLightColor,
                AppColors.backgroundGradientDarkColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(child: body),
        ));
  }
}
