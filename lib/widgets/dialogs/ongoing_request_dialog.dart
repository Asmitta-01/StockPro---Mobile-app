import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class OngoingRequestDialog extends StatelessWidget {
  final String text;
  const OngoingRequestDialog({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        child: Container(
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Get.theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LoadingAnimationWidget.staggeredDotsWave(
                color: Get.theme.colorScheme.primary,
                size: 40,
              ),
              const SizedBox(height: 16.0),
              Text(text),
            ],
          ),
        ),
      ),
    );
  }
}
