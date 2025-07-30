import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_app/features/home_screen/presentation/view/salary_line_screen.dart';
import 'package:hr_app/features/home_screen/presentation/view/widgets/salary_slip_card.dart';
import 'package:hr_app/features/home_screen/presentation/view_model/home_cubit.dart';
import 'package:hr_app/l10n/app_localizations.dart';
import '../../../../core/utils/styles/colors.dart';

class SalaryScreen extends StatelessWidget{
  static const String routeName="salaryScreen";
  const SalaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeCubit()..getSalary(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.salary, style: TextStyle(color: Colors.white,fontSize: 24.sp,fontWeight: FontWeight.bold)),
            backgroundColor: primaryColor,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_outlined,
                    color: Colors.white,
                  )),
            ),
          ),
          body: Column(
              children: [
                Container(
                  height: 24.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(32)),
                  ),
                ),
                BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      if (state is GetSalaryLoading) {
                        return Center(
                          child: Column(
                            children: [
                              SizedBox(height: 240.h,),
                              CircularProgressIndicator(color: Colors.green),
                            ],
                          ),
                        );
                      }
                      else if (state is GetSalaryError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 240.h),
                              Icon(Icons.warning_amber_rounded,
                                  color: Colors.red, size: 60.sp),
                              SizedBox(height: 16.h),
                              Text(
                                "An error occurred.",
                                style: TextStyle(color: Colors.red, fontSize: 20.sp),
                              ),
                            ],
                          ),
                        );
                      } else if (state is GetSalarySuccess) {
                        final salary = context.read<HomeCubit>().salary;
                        if (salary.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:[
                                SizedBox(height: 240.h,),
                                Icon(Icons.money,
                                    color: Colors.grey, size: 60.sp),
                                SizedBox(height: 12.h),
                                Text(
                                  "No Salary Data Found",
                                  style: TextStyle(fontSize: 20.sp, color: Colors.grey),
                                ),
                              ],
                            ),
                          );
                        }
                        return  Expanded(
                          child: ListView.builder(
                            padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            itemCount:salary.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SalaryLineScreen(slip: salary[index],),
                                      ),
                                  );

                                },
                                  child: SalarySlipCard(index: index));
                            },
                          ),
                        );
                      } return SizedBox();
                    }),
              ]),
        )
    );
  }
}
