import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_app/features/home_screen/presentation/view_model/home_cubit.dart';
import 'package:intl/intl.dart';

class HolidayRequestScreen extends StatefulWidget {
  static const String routeName = "holidayRequestScreen";

  const HolidayRequestScreen({super.key});

  @override
  State<HolidayRequestScreen> createState() => _HolidayRequestScreenState();
}

class _HolidayRequestScreenState extends State<HolidayRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();

  int selectedStatusId = 1;
  bool isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is RequestHolidaysLoading) {
            setState(() => isSubmitting = true);
          } else {
            setState(() => isSubmitting = false);
            if (state is RequestHolidaysSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text("Holiday request submitted successfully")),
              );
              Navigator.pop(context);
            } else if (state is RequestHolidaysError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.failures.errormsg)),
              );
            }
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("Holiday Request",
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold)),
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [],
                )),
          ),
        ),
      ),
    );
  }
}
