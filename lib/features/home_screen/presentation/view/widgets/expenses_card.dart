import 'package:flutter/material.dart';
import 'package:hr_app/features/home_screen/presentation/view/widgets/icon_badge.dart';
import 'package:hr_app/features/home_screen/presentation/view/widgets/status_badge.dart';
import '../../view_model/home_cubit.dart';

class ExpensesCard extends StatelessWidget {
  int index;

  ExpensesCard({required this.index});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            //margin: EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Container(
                height: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StatusBadge("Submitted"),
                        SizedBox(height: 16),
                        Text(
                            "${HomeCubit.get(context).expenses[index].totalAmountCurrency} SAR",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF121645))),
                      ],
                    ),
                    Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Text(
                              "${HomeCubit.get(context).expenses[index].name}",
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                                "${HomeCubit.get(context).expenses[index].date}",
                                style: TextStyle(color: Color(0XFF8e95a1))),
                            SizedBox(width: 8),
                            Icon(Icons.calendar_today_outlined,
                                size: 16, color: Color(0XFF8e95a1)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 16,
          right: 0,
          child: Align(alignment: Alignment.centerRight, child: IconBadge(img: "assets/images/budget_5545348.png",)),
        ),
      ],
    );
  }
}
