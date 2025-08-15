import 'package:app_ui/app_ui.dart';
import 'package:finance_repository/finance_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focuslab/l10n/l10n.dart';
import 'package:focuslab/router/app_router.dart';
import 'package:menu_repository/menu_repository.dart';
import 'package:music_experience_repository/music_experience_repository.dart';

class App extends StatelessWidget {
  final FinanceRepository financeRepository;
  const App({
    super.key,
    required this.financeRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        // Add your repositories here
        RepositoryProvider(create: (_) => MenuRepository()),
        RepositoryProvider(create: (_) => MusicExperienceRepository()),
        RepositoryProvider(create: (_) => financeRepository),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        color: AppColors.primaryColor,
        theme: AppTheme().themeData,
        routerConfig: AppRouter().router,
      ),
    );
  }
}
