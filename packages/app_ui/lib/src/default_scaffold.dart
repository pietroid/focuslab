import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class DefaultScaffold extends StatelessWidget {
  const DefaultScaffold({
    required this.body,
    super.key,
    this.title,
    this.action,
  });

  final Widget body;
  final Widget? action;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: (title != null)
          ? AppBar(
              scrolledUnderElevation: 0,
              automaticallyImplyLeading: false,
              shadowColor: Colors.transparent,
              actions: [
                if (action != null) action!,
              ],
              actionsPadding: const EdgeInsets.only(right: AppSpacing.large),
              title: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Text(
                    title!,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              backgroundColor: Colors.transparent,
              centerTitle: false,
            )
          : null,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
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
      ),
    );
  }
}
