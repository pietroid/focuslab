import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PopupPage extends StatelessWidget {
  final Widget content;
  const PopupPage({
    super.key,
    required this.content,
  });

  static void show({required BuildContext context, required Widget content}) {
    showDialog(
      context: context,
      builder: (context) => PopupPage(content: content),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog.fullscreen(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: content,
        ),
      ),
    );
  }
}
