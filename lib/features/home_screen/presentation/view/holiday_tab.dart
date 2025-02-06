import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_app/features/home_screen/presentation/view/widgets/floating_button.dart';
import 'package:hr_app/features/home_screen/presentation/view/widgets/holiday_card.dart';
import 'package:hr_app/features/home_screen/presentation/view_model/home_cubit.dart';

class HolidayTab extends StatelessWidget {
  static const String routeName = "holidayTab";

  const HolidayTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getHolidays(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Holidays", style: TextStyle(color: Colors.white)),
          backgroundColor: Color(0xFF121645),
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
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFF121645),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
            ),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is GetHolidaysLoading) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        CircularProgressIndicator(color: Colors.green),
                      ],
                    ),
                  );
                } else if (state is GetHolidaysError) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Error"),
                        content: Text(state.failures.errormsg),
                      ),
                    );
                  });
                  return Center(
                    child: Text(
                      "An error occurred.",
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      itemCount: HomeCubit.get(context).holidays.length,
                      itemBuilder: (context, index) {
                        return HolidayCard(
                          index: index,
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
        floatingActionButton: FloatingButton(),
      ),
    );
  }
}
