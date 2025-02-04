import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home_screen/presentation/view/Home_Screen.dart';
import '../view_model/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "LoginScreen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool secure = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer< LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Error"),
                content: Text(state.failure.errormsg),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("okay",
                          style: TextStyle(
                              color:
                              Colors.green))),
                ],
              ),
            );
          } else if (state is LoginSuccess) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
          }
          else{
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Center(child: CircularProgressIndicator()),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Form(
                    key:formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.login, size: 80, color: Colors.blue),
                        SizedBox(height: 20),
                        Text(
                          'Welcome ',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        // Username TextField
                        TextFormField(
                          controller: userController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)
                            ),
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: passwordController,
                          obscureText: secure?true:false,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)
                                    
                            ),
                            suffixIcon:  IconButton(onPressed:() {
                              secure=!secure;
                              setState(() {
                              });
                            },
                              icon:secure?Icon(Icons.visibility_off
                              )
                                  :Icon(Icons.visibility,
                              )
                              ,),
                            prefixIcon: Icon(Icons.lock),
                          ),
                        ),
                        SizedBox(height: 32),
                        // Login Button
                        ElevatedButton(
                          onPressed: () {
                            LoginCubit.get(context).login( userController.text,passwordController.text);
                          },
                          child: Text('Login'),
                          style: ElevatedButton.styleFrom(
                           padding: EdgeInsets.only(
                             bottom: 8,
                             top: 8,
                             left: 32,
                             right: 32
                           ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusDirectional.circular(12)
                            ),
                            textStyle: TextStyle(fontSize: 22),
                          ),
                        ),
                        SizedBox(height: 20),

                        TextButton(
                          onPressed: () {},
                          child: Text('Forgot Password?'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
