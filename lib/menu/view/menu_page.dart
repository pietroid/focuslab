import 'package:app_ui/app_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:focuslab/counter/widgets/card.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
        title: 'Menu',
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DefaultCard(child: Text('📱  Medidation - Wearable')),
              SizedBox(height: 4.0), // Spacing between cards
              DefaultCard(child: Text('🧘‍♀️   Medidation - Computer')),
              SizedBox(height: 4.0), // Spacing between cards
              DefaultCard(child: Text('📄   Tablet Scanner')),
            ],
          ),
        ));
  }
}
