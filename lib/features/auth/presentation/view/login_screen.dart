import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_app/features/auth/presentation/view/widgets/header.dart';
import 'package:hr_app/features/auth/presentation/view/widgets/login_form.dart';
import '../../../../core/cache/shared_preferences.dart';
import '../../../home_screen/presentation/view/Home_Screen.dart';
import '../../../home_screen/presentation/view_model/home_cubit.dart';
import '../view_model/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "LoginScreen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
      ],
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: Theme.of(context).colorScheme.onBackground,
                title: Text("Error"),
                content: Text(state.failure.errormsg),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // ✅ Set background color
                    ),
                    child: Text("Okay", style: TextStyle(color: Colors.green)),
                  ),
                ],
              ),
            );
          } else if (state is LoginSuccess) {
            context.read<HomeCubit>().getEmployee(id: state.loginModel.result!);
            CacheData.getData(key: "employeeId");
            CacheData.getData(key: "employeeName");
            CacheData.saveId(data: state.loginModel.result, key: "userId");
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ));
          } else {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Center(child: CircularProgressIndicator(color: Colors.green,)),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Color(0XFF181729),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Header(),
                      const SizedBox(height: 40),
                      LoginForm(),
                    ],
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
