import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_app/features/home_screen/presentation/view/widgets/news_card.dart';
import 'package:hr_app/features/home_screen/presentation/view_model/home_cubit.dart';
import 'package:lucide_icons/lucide_icons.dart';

class NewsTab extends StatelessWidget {
  const NewsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      HomeCubit()
        ..getNews(),
      child: BlocBuilder<HomeCubit,HomeState>(
        builder: (context, state) {
          if (state is GetNewsLoading) {
            return Center(
              child: Column(
                children: [
                  SizedBox(height: 240.h,),
                  CircularProgressIndicator(color: Colors.green),
                ],
              ),
            );
          }
          else if (state is GetNewsError) {
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
          } else if (state is GetNewsSuccess) {
            final  news= context.read<HomeCubit>().news;
            if (news.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    SizedBox(height: 240.h,),
                    Icon(LucideIcons.newspaper,
                        color: Colors.grey, size: 60.sp),
                    SizedBox(height: 12.h),
                    Text(
                      "No News Found",
                      style: TextStyle(fontSize: 22.sp, color: Colors.grey),
                    ),
                  ],
                ),
              );
            }
            return  ListView.builder(
              padding:
              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount:news.length,
              itemBuilder: (context, index) {
                return NewsCard(
                  index: index,
                );
              },
            );
          } return SizedBox();
        },
      ),
    );
  }
}
