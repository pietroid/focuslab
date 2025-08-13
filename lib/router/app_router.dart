import 'package:focuslab/meditation_wearable/view/medidation_wearable_page.dart';
import 'package:focuslab/menu/view/menu_page.dart';
import 'package:focuslab/music_experience/view/music_experience_page.dart';
import 'package:focuslab/ui_experience/view/ui_experience_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  GoRouter get router => GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) {
              return const MenuPage();
            },
          ),
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
}
