import 'package:app_ui/app_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:menu_repository/menu_repository.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final menuItemsList = context.read<MenuRepository>().getMenuItems();
    return DefaultScaffold(
        title: 'Menu',
        body: Padding(
          padding: const EdgeInsets.all(AppSpacing.medium),
          child: ListView.separated(
            itemBuilder: (context, index) {
              final menuItem = menuItemsList[index];
              return DefaultCard(
                  child: Text('${menuItem.emoji} ${menuItem.title}'),
                  onTap: () {
                    context.push(menuItem.route);
                  });
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: AppSpacing.extraSmall);
            },
            itemCount: menuItemsList.length,
          ),
        ));
  }
}
