import 'package:flutter/material.dart';
import 'package:sir/res/colours.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final Color colour, textColor;
  final VoidCallback onPress;
  final bool loading;

  RoundButton(
      {super.key,
      required this.title,
      this.loading = false,
      required this.onPress,
      this.textColor = AppColors.whiteColor,
      this.colour = AppColors.primaryColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading ? null : onPress,
      child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(50)),
          child: loading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Center(
                  child: Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: textColor, fontSize: 16),
                  ),
                )),
    );
  }
}
