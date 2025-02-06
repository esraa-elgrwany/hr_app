import 'package:flutter/material.dart';
import 'package:hr_app/features/home_screen/presentation/view/widgets/holiday_icon_badge.dart';
import 'package:hr_app/features/home_screen/presentation/view/widgets/icon_badge.dart';
import 'package:hr_app/features/home_screen/presentation/view/widgets/status_badge.dart';
import 'package:hr_app/features/home_screen/presentation/view_model/home_cubit.dart';

class HolidayCard extends StatelessWidget {
  int index;

  HolidayCard({required this.index});

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
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Container(
                height: 100,
                child: Row(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StatusBadge(
                            "${HomeCubit.get(context).holidays[index].state}"),
                        SizedBox(height: 8),
                        Text(
                            "${HomeCubit.get(context).holidayReason[index] ?? "no reason"}",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF121645))),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                                "${HomeCubit.get(context).holidays[index].requestDateFrom}",
                                style: TextStyle(color: Color(0XFF8e95a1))),
                            SizedBox(width: 8),
                            Icon(Icons.calendar_today_outlined,
                                size: 16, color: Color(0XFF8e95a1)),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Flexible(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                              "${HomeCubit.get(context).holidays[index].name ?? "no name"}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ],
                      ),
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
          child: Align(
              alignment: Alignment.centerRight, child: HolidayIconBadge()),
        ),
      ],
    );
  }
}
