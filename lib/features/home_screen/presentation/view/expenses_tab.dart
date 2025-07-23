import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_app/core/utils/styles/colors.dart';
import 'package:hr_app/features/home_screen/presentation/view/widgets/expenses_card.dart';
import 'package:hr_app/features/home_screen/presentation/view/widgets/floating_button.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../view_model/home_cubit.dart';

class ExpensesTab extends StatefulWidget {
  static const String routeName = "expensesTab";

  const ExpensesTab({super.key});

  @override
  State<ExpensesTab> createState() => _ExpensesTabState();
}

class _ExpensesTabState extends State<ExpensesTab> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getExpenses(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Expenses", style: TextStyle(color: Colors.white)),
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
                if (state is GetExpensesLoading) {
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(height: 240.h,),
                        CircularProgressIndicator(color: Colors.green),
                      ],
                    ),
                  );
                }
                else if (state is GetExpensesError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 240.h),
                        Icon(Icons.warning_amber_rounded,
                            color: Colors.red, size: 50),
                        SizedBox(height: 16.h),
                        Text(
                          "An error occurred.",
                          style: TextStyle(color: Colors.red, fontSize: 18),
                        ),
                      ],
                    ),
                  );
                } else if (state is GetExpensesSuccess) {
                  final expenses = context.read<HomeCubit>().expenses;
                  if (expenses.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          SizedBox(height: 240.h,),
                          Icon(LucideIcons.calculator,
                              color: Colors.grey, size: 50),
                          SizedBox(height: 12),
                          Text(
                            "No Expenses Found",
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  }
                  return  Expanded(
                    child: ListView.builder(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      itemCount:expenses.length,
                      itemBuilder: (context, index) {
                        return ExpensesCard(
                          index: index,
                        );
                      },
                    ),
                  );
                } return SizedBox();
             }),
        ]),
        floatingActionButton: FloatingButton(""),
      )
    );
  }
}
