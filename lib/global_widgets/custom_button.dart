import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:thoughts/utils/themes/colors.dart';
import 'package:thoughts/utils/themes/text_theme.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final bool isLoading;
  final VoidCallback function;
  final Color? customButtonColor;
  const CustomButton(
      {super.key,
      this.customButtonColor,
      required this.buttonText,
      required this.function,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: customButtonColor ?? AppColors.brandBlack,
        ),
        child: isLoading
            ? Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.white,
                size: 25,
              ))
            : Text(
                textAlign: TextAlign.center,
                buttonText,
                style: TT.f16w700.copyWith(
                  color: AppColors.brandWhite,
                ),
              ),
      ),
    );
  }
}
