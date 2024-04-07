import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thoughts/utils/themes/text_theme.dart';

class CustomIcon extends StatelessWidget {
  final VoidCallback? onTap;
  final String iconPath;
  final String? iconText;
  final TextStyle? iconTextStyle;
  final bool isPng;

  const CustomIcon(
      {super.key,
      required this.iconPath,
      this.onTap,
      this.iconText,
      this.iconTextStyle,
      this.isPng = false});

  @override
  Widget build(BuildContext context) {
    return iconText == null
        ? GestureDetector(
            onTap: onTap,
            child: isPng
                ? Image.asset(iconPath)
                : SvgPicture.asset(
                    iconPath,
                  ),
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: onTap,
                child: isPng
                    ? Image.asset(iconPath)
                    : SvgPicture.asset(
                        iconPath,
                      ),
              ),
              const SizedBox(
                width: 8,
              ),
              Flexible(
                child: Text(
                  iconText!,
                  maxLines: 2,
                  style: iconTextStyle ??
                      TT.f14w400.copyWith(color: const Color(0xff1A1A1A)),
                ),
              )
            ],
          );
  }
}
