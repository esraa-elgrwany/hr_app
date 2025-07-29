import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_app/core/cache/shared_preferences.dart';
import 'package:hr_app/features/auth/presentation/view/widgets/button.dart';
import 'package:hr_app/features/auth/presentation/view/widgets/text_form_item.dart';
import 'package:hr_app/features/auth/presentation/view_model/login_cubit.dart';

import '../../../../../core/utils/styles/colors.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool secure = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.75,
      child: Card(
        margin: EdgeInsets.all(8),
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(24),
                topEnd: Radius.circular(24),
                bottomStart: Radius.circular(24),
                bottomEnd: Radius.circular(100))),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Username",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 18.sp)),
                  SizedBox(height: 8.h),
                  TextFormField(
                    controller: userController,
                    style: TextStyle(
                        color:Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: secondPrimary,
                      hintText: 'username',
                      hintStyle: TextStyle(
                          color: thirdPrimary,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                              color: secondPrimary)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                              color:secondPrimary)),
                      prefixIcon: Icon(Icons.person, color: thirdPrimary,size: 24.sp),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text("Password",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 18.sp)),
                  SizedBox(height: 8.h),
                  TextFormField(
                    controller: passwordController,
                    obscureText: secure ? true : false,
                    style: TextStyle(
                        color:Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: secondPrimary,
                      hintText: 'Password',
                      hintStyle: TextStyle(
                          color: thirdPrimary,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                              color: secondPrimary)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                              color:secondPrimary)),
                      suffixIcon: IconButton(
                        onPressed: () {
                          secure = !secure;
                          setState(() {});
                        },
                        icon: secure
                            ? Icon(Icons.visibility_off, color: thirdPrimary,size: 24.sp)
                            : Icon(
                                Icons.visibility,
                                color: thirdPrimary,
                            size: 24.sp
                              ),
                      ),
                      prefixIcon: Icon(Icons.lock, color: thirdPrimary,size: 24.sp),
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              CacheData.saveId(data: passwordController.text, key: "password");
                              LoginCubit.get(context).login(
                                  userController.text, passwordController.text);
                            }
                          },
                          child: Button(
                            txt: "Login",
                          )),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                          color: Color(0XFF1d194a),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
