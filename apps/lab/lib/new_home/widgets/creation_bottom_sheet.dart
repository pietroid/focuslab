import 'dart:ui';

import 'package:app_ui/app_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focuslab/new_home/widgets/duration_selector_popup.dart';
import 'package:focuslab/new_home/widgets/grouped_options.dart';
import 'package:focuslab/new_home/widgets/home_add_buton.dart';
import 'package:focuslab/new_home/widgets/time_selector_popup.dart';

class CreationBottomSheet {
  CreationBottomSheet();

  void show(
    BuildContext context,
  ) {
    showModalBottomSheet(
      useSafeArea: true,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return const CreationBottomSheetWidget();
      },
    );
  }
}

class CreationBottomSheetWidget extends StatelessWidget {
  const CreationBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppSpacing.medium),
            topRight: Radius.circular(AppSpacing.medium),
          ),
          child: ColoredBox(
            color: const Color.fromARGB(14, 255, 255, 255),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 8,
                sigmaY: 8,
                tileMode: TileMode.clamp,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 4,
                  top: 10,
                  right: 4,
                  bottom: 8,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: AppSpacing.medium,
                        right: AppSpacing.medium,
                        bottom: AppSpacing.small,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextField(
                              autofocus: true,
                              //controller: _contentController,
                              textInputAction: TextInputAction.go,
                              onSubmitted: (_) {
                                // context.read<CreationBottomSheetBloc>().add(
                                //       const FormSubmitted(),
                                //     );
                              },
                              maxLines: null,
                              style: GoogleFonts.onest(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                              decoration: const InputDecoration(
                                hintText: '',
                                border: InputBorder.none,
                              ),
                            ),
                          ),

                          // SizedBox(width: AppSpacing.medium),
                          // SendButton(
                          //   onPressed: () {
                          //     // context
                          //     //     .read<CreationBottomSheetBloc>()
                          //     //     .add(const FormSubmitted());
                          //   },
                          // ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        GroupedOptions(
                          initialSelectedIndex: 0,
                          expanded: true,
                          options: [
                            const OptionInfo(
                              icon: CupertinoIcons.square_list,
                              label: 'Depois',
                            ),
                            OptionInfo(
                              icon: CupertinoIcons.time,
                              label: 'Hora',
                              onTap: () {
                                PopupPage.show(
                                  context: context,
                                  content: const TimeSelectorPopup(),
                                );
                              },
                            ),
                            const OptionInfo(
                              icon: CupertinoIcons.play_arrow_solid,
                              label: 'Agora',
                            ),
                          ],
                        ),
                        const SizedBox(width: AppSpacing.extraSmall),
                        GroupedOptions(
                          initialSelectedIndex: 0,
                          expanded: true,
                          options: [
                            OptionInfo(
                              icon: CupertinoIcons.timer,
                              label: '00:15',
                              onTap: () {
                                PopupPage.show(
                                  context: context,
                                  content: const DurationSelectorPopup(),
                                );
                              },
                            ),
                            const OptionInfo(
                              icon: CupertinoIcons.loop,
                            ),
                          ],
                        ),
                        const SizedBox(width: AppSpacing.extraSmall),
                        Expanded(
                          child: Container(),
                        ),
                        const MoreButton(),
                      ],
                    ),
                    // SizedBox(width: AppSpacing.extraSmall),
                    // ActionButton(
                    //   icon: CupertinoIcons.timer,
                    //   label: '30 min',
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MoreButton extends StatelessWidget {
  const MoreButton({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.defaultButtonColor,
          borderRadius: BorderRadius.circular(100),
        ),
        child: const Icon(CupertinoIcons.plus, color: Colors.white, size: 16),
      ),
    );
  }
}

class SendButton extends StatelessWidget {
  const SendButton({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.small),
        decoration: const BoxDecoration(
          color: Color.fromARGB(16, 255, 255, 255),
          shape: BoxShape.circle,
        ),
        child: const Icon(CupertinoIcons.checkmark_alt,
            color: Colors.white, size: 18),
      ),
    );
  }
}
