import 'package:menu_repository/src/menu_item.dart';

/// {@template menu_repository}
/// Repository to fetch the main menu items for the application.
/// {@endtemplate}
class MenuRepository {
  ///
  List<MenuItem> getMenuItems() {
    return const [
      MenuItem(emoji: '🖥️', title: 'Dashboard', route: '/dashboard'),
      MenuItem(emoji: '📱', title: 'New Home', route: '/new-home'),
      MenuItem(
        emoji: '💰',
        title: 'Finance',
        route: '/finance',
      ),
      MenuItem(
        emoji: '🎨',
        title: 'UI Experience',
        route: '/ui-experience',
      ),
      MenuItem(
        emoji: '🔊',
        title: 'Music experience',
        route: '/music-experience',
      ),
      MenuItem(
        emoji: '📱',
        title: 'Medidation - Wearable',
        route: '/meditation-wearable',
      ),
      MenuItem(
        emoji: '🧘‍♀️',
        title: 'Medidation - Computer',
        route: '/meditation-computer',
      ),
      MenuItem(
        emoji: '📄',
        title: 'Tablet Scanner',
        route: '/tablet-scanner',
      ),
    ];
  }
}
