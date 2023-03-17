import 'package:flutter/material.dart';
import 'package:sir/res/colours.dart';


class InputTextField extends StatelessWidget {
  final TextEditingController myController;
  final FocusNode focusNode;
  final FormFieldSetter onFieldSubmittedValue;
  final FormFieldValidator onValidator;
  final TextInputType keyboardType;
  final String hint;
  final bool obscureText;
  final bool enable, autoFocus;

  InputTextField({
    super.key,
    required this.myController,
    required this.focusNode,
    required this.onFieldSubmittedValue,
    required this.keyboardType,
    required this.obscureText,
    required this.hint,
    required this.onValidator,
    this.autoFocus = false,
    this.enable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: TextFormField(
        controller: myController,
        focusNode: focusNode,
        obscureText: obscureText,
        onFieldSubmitted: onFieldSubmittedValue,
        validator: onValidator,
        keyboardType: keyboardType,
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(height: 0, fontSize: 19),
        decoration: InputDecoration(
            hintText: hint,
            contentPadding: EdgeInsets.all(15),
            hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                  height: 0,
                  color: AppColors.primaryTextTextColor.withOpacity(0.8),
                ),
            border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.textFieldDefaultBorderColor),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.secondaryColor),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.textFieldDefaultBorderColor),
                borderRadius: BorderRadius.all(Radius.circular(8)))),
      ),
    );
  }
}
