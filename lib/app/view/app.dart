import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:focuslab/l10n/l10n.dart';
import 'package:focuslab/menu/view/menu_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const MenuPage(),
      color: AppColors.primaryColor,
      theme: AppTheme().themeData,
    );
  }
}
