import 'package:focuslab/dashboard/dashboard_page.dart';
import 'package:focuslab/finance/view/finance_page.dart';
import 'package:focuslab/meditation_wearable/view/medidation_wearable_page.dart';
import 'package:focuslab/menu/view/menu_page.dart';
import 'package:focuslab/music_experience/view/music_experience_page.dart';
import 'package:focuslab/new_home/new_home_page.dart';
import 'package:focuslab/ui_experience/view/ui_experience_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: '/dashboard',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const MenuPage();
        },
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) {
          return const DashboardPage();
        },
      ),
      GoRoute(
        path: '/new-home',
        builder: (context, state) {
          return const NewHomePage();
        },
      ),
      GoRoute(
          path: '/finance',
          builder: (context, state) {
            return const FinancePage();
          }),
      GoRoute(
          path: '/meditation-wearable',
          builder: (context, state) {
            return const MeditationWearablePage();
          }),
      GoRoute(
          path: '/music-experience',
          builder: (context, state) {
            return const MusicExperiencePage();
          }),
      GoRoute(
        path: '/ui-experience',
        builder: (context, state) {
          return const UIExperiencePage();
        },
      )
    ],
  );

  GoRouter get router => _router;
}
