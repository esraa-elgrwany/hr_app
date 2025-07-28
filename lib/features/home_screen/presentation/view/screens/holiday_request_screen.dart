import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_app/features/home_screen/data/model/status_model.dart';
import 'package:hr_app/features/home_screen/presentation/view/holiday_tab.dart';
import 'package:hr_app/features/home_screen/presentation/view_model/home_cubit.dart';
import 'package:intl/intl.dart';

import '../../../../../core/utils/styles/colors.dart';

class HolidayRequestScreen extends StatefulWidget {
  static const String routeName = "holidayRequestScreen";

  const HolidayRequestScreen({super.key});

  @override
  State<HolidayRequestScreen> createState() => _HolidayRequestScreenState();
}

class _HolidayRequestScreenState extends State<HolidayRequestScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  StatusResult? leaveTypeList;
  String? selectedLeaveType;
  int? leaveId;
  bool isMultipleDays = false;
  DateTime? selectedDate;
  DateTime? fromDate;
  DateTime? toDate;

  Future<void> pickDate(BuildContext context, {required bool isFrom}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: primaryColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isMultipleDays) {
          isFrom ? fromDate = picked : toDate = picked;
        } else {
          selectedDate = picked;
        }
      });
    }
  }

  String formatDate(DateTime? date) {
    if (date == null) return 'yyyy-MM-dd';
    return DateFormat('yyyy-MM-dd').format(date);
  }

  void submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      debugPrint('Leave Type: $selectedLeaveType');
      debugPrint('Note: ${noteController.text}');
      debugPrint(isMultipleDays
          ? 'From: ${formatDate(fromDate)}, To: ${formatDate(toDate)}'
          : 'Date: ${formatDate(selectedDate)}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getStatus(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          bool isLoading = state is RequestHolidaysLoading;
          return Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  backgroundColor: primaryColor,
                  toolbarHeight: 100.h,
                  leading: const BackButton(color: Colors.white),
                  title: Text(
                    'Leave Request',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  centerTitle: true,
                ),
                body: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: Form(
                        key: _formKey,
                        child: Card(
                          color: Theme.of(context).colorScheme.background,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Request name',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.sp,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                TextFormField(
                                  controller: nameController,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'name',
                                    suffixIcon: Icon(
                                      Icons.edit,
                                      size: 22.sp,
                                    ),
                                    hintStyle: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                    filled: true,
                                    fillColor:Theme.of(context).colorScheme.secondary,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(color:Theme.of(context).colorScheme.secondary)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(color:Theme.of(context).colorScheme.secondary)),
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                Text(
                                  'Leave type',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.sp,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  decoration: BoxDecoration(
                                    color: secondPrimary,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: BlocBuilder<HomeCubit, HomeState>(
                                    builder: (context, state) {
                                      final leaveTypes =
                                          HomeCubit.get(context).status;
                                      return DropdownButtonFormField<StatusResult>(
                                        value:leaveTypeList ,
                                        hint: Text(
                                          'Leave type',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.sp,
                                            color: primaryColor,
                                          ),
                                        ),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.sp,
                                          color: primaryColor,
                                        ),
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Colors.black,
                                        ),
                                        isExpanded: true,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none),
                                        dropdownColor: Theme.of(context)
                                            .colorScheme
                                            .background,
                                        items: leaveTypes.map((type) {
                                          return DropdownMenuItem<StatusResult>(
                                            value: type,
                                            child: Text(type.name ?? ""),
                                          );
                                        }).toList(),
                                        validator: (value) => value == null
                                            ? 'Please select leave type'
                                            : null,
                                        onChanged: (value) => setState(() {
                                          leaveTypeList=value;
                                          selectedLeaveType = value?.name??"";
                                        }),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                Text(
                                  'Leave duration',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.sp,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: secondPrimary,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () => setState(
                                              () => isMultipleDays = false),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            decoration: BoxDecoration(
                                              color: !isMultipleDays
                                                  ? thirdPrimary
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              'A day',
                                              style: TextStyle(
                                                color: !isMultipleDays
                                                    ? Colors.white
                                                    : thirdPrimary,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () => setState(
                                              () => isMultipleDays = true),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            decoration: BoxDecoration(
                                              color: isMultipleDays
                                                  ? thirdPrimary
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Multiple days',
                                              style: TextStyle(
                                                color: isMultipleDays
                                                    ? Colors.white
                                                    : thirdPrimary,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                if (!isMultipleDays)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () =>
                                            pickDate(context, isFrom: true),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: secondPrimary,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 14, horizontal: 12),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Select the day',
                                                style: TextStyle(
                                                    color: thirdPrimary,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16.sp),
                                              ),
                                              SizedBox(height: 8.h),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 12,
                                                    horizontal: 8),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24)),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .calendar_month_rounded,
                                                      color: primaryColor,
                                                      size: 24.sp,
                                                    ),
                                                    SizedBox(width: 8.w),
                                                    Text(
                                                      formatDate(selectedDate),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 16.sp,
                                                          color: primaryColor),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                else
                                  Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () =>
                                              pickDate(context, isFrom: true),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: secondPrimary,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16, horizontal: 6),
                                            child: Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'From',
                                                    style: TextStyle(
                                                        color: thirdPrimary,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16.sp),
                                                  ),
                                                  SizedBox(height: 8.h),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 8,
                                                            horizontal: 4),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16)),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                            Icons
                                                                .calendar_month_rounded,
                                                            size: 22.sp,
                                                            color:
                                                                primaryColor),
                                                        SizedBox(width: 4.w),
                                                        Text(
                                                          formatDate(fromDate),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 14.sp,
                                                              color:
                                                                  primaryColor),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () =>
                                              pickDate(context, isFrom: false),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFfdf3e9),
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16, horizontal: 6),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'To',
                                                  style: TextStyle(
                                                      color: Color(0XFFf2c790),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16.sp),
                                                ),
                                                SizedBox(height: 8.h),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 4),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16)),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .calendar_month_rounded,
                                                        color: primaryColor,
                                                        size: 22.sp,
                                                      ),
                                                      SizedBox(width: 4.w),
                                                      Text(
                                                        formatDate(toDate),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 14.sp,
                                                            color:
                                                                primaryColor),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                SizedBox(height: 16.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BlocListener<HomeCubit, HomeState>(
                                      listener: (context, state) {
                                        if (state is RequestHolidaysError) {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              backgroundColor: Colors.grey[200],
                                              title: Text(
                                                "Error",
                                                style: TextStyle(
                                                    color: primaryColor),
                                              ),
                                              content: Text(
                                                state.failures.errormsg,
                                                style: TextStyle(
                                                    color: primaryColor),
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("okay",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white))),
                                              ],
                                            ),
                                          );
                                        } else if (state is RequestHolidaysSuccess) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Center(
                                                  child: Text(
                                                    "Leave Request Sent Successfully",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.sp),
                                                  ),
                                                ),
                                                backgroundColor: Colors.green,
                                                duration: Duration(seconds: 4),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                margin: EdgeInsets.all(24),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(24),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 12,
                                                    horizontal: 4)),
                                          );
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(builder: (_) => HolidayTab()),
                                          );
                                        }
                                      },
                                      child: InkWell(
                                        onTap: () {
                                          print("to date:${formatDate(toDate)}");
                                          print("from date:${formatDate(fromDate)}");
                                          print("status ID:${leaveTypeList?.id}");
                                          print("name:${nameController.text}");
                                          HomeCubit.get(context).requestHolidays(
                                              name:nameController.text, statusId:leaveTypeList?.id ??0,
                                              fromDate:isMultipleDays?formatDate(fromDate):formatDate(selectedDate),
                                              toDate:isMultipleDays?formatDate(toDate):formatDate(selectedDate));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 24, vertical: 12),
                                          decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Text(
                                            "Send Request",
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (isLoading)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.green),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
