import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/styles/colors.dart';

class TextFormItem extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  String hint;
  IconData icon;
  String validateTxt;

  TextFormItem(
      {required this.controller,
      required this.hint,
      required this.icon,
      required this.validateTxt});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style:
        TextStyle(color:Theme.of(context).colorScheme.onSurface,fontSize: 16.sp, fontWeight: FontWeight.w600),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color:Theme.of(context).colorScheme.onSecondary,fontSize: 16.sp, fontWeight: FontWeight.w500),
        filled: true,
        fillColor:Theme.of(context).colorScheme.secondary,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color:Theme.of(context).colorScheme.secondary)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color:Theme.of(context).colorScheme.secondary)),
        prefixIcon: Icon(icon, color:thirdPrimary,size: 24.sp,),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validateTxt;
        }
        return null;
      },
    );
  }
}
