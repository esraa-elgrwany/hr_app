import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_app/features/home_screen/data/model/salary_model.dart';
import 'package:hr_app/l10n/app_localizations.dart';
import '../../../../core/utils/styles/colors.dart';
import '../view_model/home_cubit.dart';

class SalaryLineScreen extends StatefulWidget{
  static const String routeName="salaryLineScreen";
  final SalaryResult? slip;
   const SalaryLineScreen({super.key,this.slip});

  @override
  State<SalaryLineScreen> createState() => _SalaryLineScreenState();
}

class _SalaryLineScreenState extends State<SalaryLineScreen> {
  @override
  Widget build(BuildContext context) {
   return BlocProvider(
        create: (context) => HomeCubit()..getSalaryLine(ids: widget.slip?.lineIds??[]),
        child: Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.salaryLine, style: TextStyle(color: Colors.white,fontSize: 22.sp,fontWeight: FontWeight.bold)),
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
                      if (state is GetSalaryLineLoading) {
                        return Center(
                          child: Column(
                            children: [
                              SizedBox(height: 240.h,),
                              CircularProgressIndicator(color: Colors.green),
                            ],
                          ),
                        );
                      }
                      else if (state is GetSalaryLineError) {
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
                      } else if (state is GetSalaryLineSuccess) {
                        final salaryLine = context.read<HomeCubit>().salaryLine;
                        if (salaryLine.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:[
                                SizedBox(height: 240.h,),
                                Icon(Icons.money,
                                    color: Colors.grey, size: 60.sp),
                                SizedBox(height: 12.h),
                                Text(
                                  "No Salary Line Data Found",
                                  style: TextStyle(fontSize: 20.sp, color: Colors.grey),
                                ),
                              ],
                            ),
                          );
                        }
                        return  Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              itemCount:salaryLine.length,
                              padding: EdgeInsets.all(8),
                              itemBuilder: (context, index) {
                                return Card(
                                  color: Theme.of(context).colorScheme.onBackground,
                                  shape:
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  margin: EdgeInsets.only(
                                     top: 8,bottom: 8
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: Image.asset("assets/images/cost.png",width: 40.w,height: 40.h,),
                                      title: Text(salaryLine[index]?.name??"no name",style:TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      )),
                                      trailing: Text(
                                        "${salaryLine[index]?.total?.toStringAsFixed(2)} EGP",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.green
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      } return SizedBox();
                    }),
              ]),
        )
    );
  }
}
