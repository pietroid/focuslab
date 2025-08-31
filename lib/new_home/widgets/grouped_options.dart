import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class GroupedOptions extends StatefulWidget {
  const GroupedOptions({
    required this.options,
    required this.initialSelectedIndex,
    this.expanded = false,
    super.key,
  });

  final bool expanded;
  final List<OptionInfo> options;
  final int initialSelectedIndex;

  @override
  State<GroupedOptions> createState() => _GroupedOptionsState();
}

class _GroupedOptionsState extends State<GroupedOptions> {
  late int selectedIndex = widget.initialSelectedIndex;
  @override
  Widget build(BuildContext context) {
    final optionsWidgets = widget.options.map((option) {
      final index = widget.options.indexOf(option);
      //List
      return Option(
        icon: option.icon,
        label: option.label,
        isSelected: index == selectedIndex,
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
          option.onTap?.call();
        },
      );
    }).toList();

    //Group
    return Container(
        padding: const EdgeInsets.all(AppSpacing.extraSmall),
        decoration: BoxDecoration(
          color: AppColors.defaultButtonColor,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
            mainAxisSize: widget.expanded ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: widget.expanded
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.start,
            children: optionsWidgets));
  }
}

class Option extends StatefulWidget {
  const Option({
    required this.icon,
    this.label,
    super.key,
    this.onTap,
    this.isSelected = false,
  });

  final IconData icon;
  final String? label;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          color: widget.isSelected
              ? AppColors.defaultButtonColor
              : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(children: [
          Icon(widget.icon, color: Colors.white, size: 16),
          if (widget.label != null) ...[
            const SizedBox(width: 4),
            Text(
              widget.label!,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ]
        ]),
      ),
    );
  }
}

class OptionInfo {
  const OptionInfo({
    required this.icon,
    this.label,
    this.onTap,
  });

  final IconData icon;
  final String? label;
  final VoidCallback? onTap;
}
