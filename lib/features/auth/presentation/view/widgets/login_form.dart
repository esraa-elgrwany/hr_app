import 'package:flutter/material.dart';
import 'package:hr_app/features/auth/presentation/view_model/login_cubit.dart';

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
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Username",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0XFF1d194a))),
                const SizedBox(height: 8),
                TextFormField(
                  controller: userController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(color: Color(0XFFa1aaba)),
                    filled: true,
                    fillColor: Color(0XFFebf6fc),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Color(0XFFebf6fc))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Color(0XFFebf6fc))),
                    prefixIcon: Icon(Icons.person, color: Color(0XFF56b5d2)),
                  ),
                ),
                SizedBox(height: 20),
                const Text("Password",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0XFF1d194a))),
                const SizedBox(height: 8),
                TextFormField(
                  controller: passwordController,
                  obscureText: secure ? true : false,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0XFFebf6fc),
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Color(0XFFa1aaba)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Color(0XFFebf6fc))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Color(0XFFebf6fc))),
                    suffixIcon: IconButton(
                      onPressed: () {
                        secure = !secure;
                        setState(() {});
                      },
                      icon: secure
                          ? Icon(Icons.visibility_off, color: Color(0XFF56b5d2))
                          : Icon(
                              Icons.visibility,
                              color: Color(0XFF56b5d2),
                            ),
                    ),
                    prefixIcon: Icon(Icons.lock, color: Color(0XFF56b5d2)),
                  ),
                ),
                SizedBox(height: 40),
                // Login Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        LoginCubit.get(context).login(
                            userController.text, passwordController.text);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0XFF1d194a),
                        padding: EdgeInsets.only(
                            bottom: 8, top: 8, left: 32, right: 32),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.circular(12)),
                        textStyle: TextStyle(fontSize: 22),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: Color(0XFF1d194a)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
