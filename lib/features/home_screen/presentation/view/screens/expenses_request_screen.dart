import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hr_app/features/home_screen/data/model/product_model.dart';
import 'package:hr_app/features/home_screen/data/model/status_model.dart';
import 'package:hr_app/features/home_screen/presentation/view/Expenses_tab.dart';
import 'package:hr_app/features/home_screen/presentation/view_model/home_cubit.dart';
import 'package:intl/intl.dart';

import '../../../../../core/utils/styles/colors.dart';

class ExpensesRequestScreen extends StatefulWidget{
  static const String routeName="expensesRequestScreen";
  const ExpensesRequestScreen({super.key});

  @override
  State<ExpensesRequestScreen> createState() => _ExpensesRequestScreenState();
}

class _ExpensesRequestScreenState extends State<ExpensesRequestScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  ProductResult? product;
  String? selectedProduct;
  DateTime? selectedDate;

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
          selectedDate = picked;
      });
    }
  }

  String formatDate(DateTime? date) {
    if (date == null) return 'yyyy-MM-dd';
    return DateFormat('yyyy-MM-dd').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getProduct(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          bool isLoading = state is RequestExpensesLoading;
          return Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  backgroundColor: primaryColor,
                  toolbarHeight: 100.h,
                  leading: const BackButton(color: Colors.white),
                  title: Text(
                    'Expenses Request',
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
                          elevation: 8,
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
                                      color: Theme.of(context).colorScheme.onSecondary,
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
                                  'Select product',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.sp,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.secondary,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: BlocBuilder<HomeCubit, HomeState>(
                                    builder: (context, state) {
                                      final productTypes =
                                          HomeCubit.get(context).products;
                                      return DropdownButtonFormField<ProductResult>(
                                        value:product,
                                        hint: Text(
                                          'Select product',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.sp,
                                            color: Theme.of(context).colorScheme.onSurface
                                          ),
                                        ),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.sp,
                                          color: Theme.of(context).colorScheme.onSurface
                                        ),
                                        icon:  Icon(
                                          Icons.keyboard_arrow_down,
                                          color:Theme.of(context).colorScheme.onSecondary,
                                        ),
                                        isExpanded: true,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none),
                                        dropdownColor: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                        items: productTypes.map((type) {
                                          return DropdownMenuItem<ProductResult>(
                                            value: type,
                                            child: Text(type.name ?? ""),
                                          );
                                        }).toList(),
                                        validator: (value) => value == null
                                            ? 'Please select leave type'
                                            : null,
                                        onChanged: (value) => setState(() {
                                          product=value;
                                          selectedProduct = value?.name??"";
                                        }),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                Text(
                                  'Date',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.sp,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () =>
                                            pickDate(context, isFrom: true),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).colorScheme.secondary,
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
                                                    color:Theme.of(context).colorScheme.onSecondary,
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
                                  ),
                                SizedBox(height: 16.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BlocListener<HomeCubit, HomeState>(
                                      listener: (context, state) {
                                        if (state is RequestExpensesError) {
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
                                        } else if (state is RequestExpensesSuccess) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Center(
                                                  child: Text(
                                                    "Expenses Request Sent Successfully",
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
                                            MaterialPageRoute(builder: (_) => ExpensesTab()),
                                          );
                                        }
                                      },
                                      child: InkWell(
                                        onTap: () {
                                          print("date:${formatDate(selectedDate)}");
                                          print("product ID:${product?.id??0}");
                                          print("name:${nameController.text}");
                                          if (_formKey.currentState!.validate()){
                                          HomeCubit.get(context).requestExpenses(
                                            name: nameController.text,date: formatDate(selectedDate),productId: product?.id??0
                                             );}
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
