import 'package:menu_repository/src/menu_item.dart';

/// {@template menu_repository}
/// Repository to fetch the main menu items for the application.
/// {@endtemplate}
class MenuRepository {
  ///
  List<MenuItem> getMenuItems() {
    return const [
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
      MenuItem(
        emoji: '🔊',
        title: 'Music experience',
        route: '/music-experience',
      ),
    ];
  }
}
