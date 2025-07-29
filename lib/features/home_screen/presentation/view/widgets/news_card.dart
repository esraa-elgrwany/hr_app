import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_app/features/home_screen/data/model/news_model.dart';
import 'package:hr_app/features/home_screen/presentation/view_model/home_cubit.dart';

class NewsCard extends StatelessWidget{
  int index;
   NewsCard({super.key,required this.index});

  @override
  Widget build(BuildContext context) {
    NewsResult news = HomeCubit.get(context).news[index];

    String cleanedAnnouncement = (news.announcement ?? "")
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .trim();

    return Card(
      color: Theme.of(context).colorScheme.onBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      margin: const EdgeInsets.only(bottom: 8, top: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.name ?? "No name",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.announcement_outlined, size: 22.sp, color: Color(0XFF37bf85)),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          cleanedAnnouncement.isNotEmpty
                              ? cleanedAnnouncement
                              : "No announcement",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(Icons.calendar_month_rounded, size: 22.sp, color: Color(0XFF37bf85)),
                      SizedBox(width: 8.w),
                      Text(
                        news.dateStart ?? "No date",
                        style: TextStyle(
                          color: Color(0XFF8e95a1),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.w),
            Image.asset(
              'assets/images/freedom-press_10642288.png',
              width: 60.w,
              height: 60.h,
            ),
          ],
        ),
      ),
    );
  }

}
