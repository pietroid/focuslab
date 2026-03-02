import 'package:focus/app/home/view/home_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  GoRouter get router => GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const HomePage(),
          ),
        ],
      );
}
