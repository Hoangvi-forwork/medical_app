import 'package:flutter/material.dart';
import '../colors.dart';

class BuildFloatingActionScrollButton extends StatelessWidget {
  const BuildFloatingActionScrollButton({
    Key? key,
    required this.isVisibale,
    required this.scrollController,
  }) : super(key: key);

  final bool isVisibale;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisibale,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 400),
        opacity: 0.8,
        child: FloatingActionButton(
          onPressed: () {
            scrollController.animateTo(0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut);
          },
          elevation: 0,
          backgroundColor: AppColors.primaryColor,
          child: const Icon(Icons.arrow_upward),
        ),
      ),
    );
  }
}
