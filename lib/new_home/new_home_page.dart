import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NewHomePage extends StatelessWidget {
  const NewHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DefaultScaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.medium, horizontal: AppSpacing.large),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  '08:54',
                  style: textTheme.displayLarge?.copyWith(),
                ),
                Text(
                  'Terça-feira, 26 de agosto',
                ),
              ],
            ),
            Column(
              children: [
                CircularProgressIndicator(
                  color: AppColors.captionColor,
                ),
                Text('Agora: codando focuslab'),
                Text('Em breve: café da manhã'),
                Text('pausa'),
              ],
            )
          ],
        ),
        const SizedBox(height: AppSpacing.large),
        Text('Notification space'),
        DefaultCard(
            child: Text('How are you feeling?', style: textTheme.bodyMedium)),
        const SizedBox(height: AppSpacing.large),
        Text('status space'),
        Text('Finance: 🟢Good'),
        Text('Tasks: 🟢Good'),
        Text('Dreams: 🟠Medium'),
        const SizedBox(height: AppSpacing.large),
        Text('Hoje', style: textTheme.titleLarge),
        const SizedBox(height: AppSpacing.large),
        Text('Pendências', style: textTheme.bodyMedium),
        const SizedBox(height: AppSpacing.large),
        Text('Trabalho', style: textTheme.bodyMedium),
        const SizedBox(height: AppSpacing.large),
        Text('Lazer', style: textTheme.bodyMedium),
        const SizedBox(height: AppSpacing.large),
        Text('Próximos dias', style: textTheme.titleLarge),
        const SizedBox(height: AppSpacing.large),
        Text('Notas', style: textTheme.titleLarge),
        const SizedBox(height: AppSpacing.large),
      ]),
    ));
  }
}
