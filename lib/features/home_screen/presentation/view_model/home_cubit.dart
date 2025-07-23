import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_app/core/cache/shared_preferences.dart';
import 'package:hr_app/features/home_screen/data/model/employee_model.dart';
import 'package:hr_app/features/home_screen/data/model/expenses_model.dart';
import 'package:hr_app/features/home_screen/data/model/holiday_model.dart';
import 'package:hr_app/features/home_screen/data/model/holiday_request_model.dart';
import 'package:hr_app/features/home_screen/data/model/status_model.dart';
import 'package:meta/meta.dart';
import '../../../../core/api_services/api-manager.dart';
import '../../../../core/failures/failures.dart';
import '../../data/repo/home_repo.dart';
import '../../data/repo/home_repo_impl.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  static HomeCubit get(context) => BlocProvider.of(context);
  List<ExpensesResult> expenses = [];
  List<StatusResult> status = [];
  List<HolidayResult> holidays = [];
  List<dynamic> holidayReason = [];
  List<EmployeeResult> employee = [];
  int employeeUId = 0;

  HomeCubit() : super(HomeInitial());

  getExpenses() async {
    emit(GetExpensesLoading());
    ApiManager apiManager = ApiManager();
    HomeRepo homeRepo = HomeRepoImpl(apiManager);
    var result = await homeRepo.getExpenses();
    result.fold((l) {
      emit(GetExpensesError(l));
    }, (r) {
      expenses = r.result ?? [];
      print("expenses cubit$expenses");
      emit(GetExpensesSuccess(r));
    });
  }

  getHolidays() async {
    emit(GetHolidaysLoading());
    ApiManager apiManager = ApiManager();
    HomeRepo homeRepo = HomeRepoImpl(apiManager);
    var result = await homeRepo.getHolidays();
    result.fold((l) {
      emit(GetHolidaysError(l));
    }, (r) {
      holidays = r.result ?? [];
      holidayReason = holidays
          .map((holiday) =>
      (holiday.holidayStatusId != null && holiday.holidayStatusId!.length > 1)
          ? holiday.holidayStatusId![1]
          : null)
          .where((status) => status != null)
          .toList();
      emit(GetHolidaysSuccess(r));
      print("Holidays: $holidays");
      print("Extracted Holiday Status Data: $holidayReason");
    });
  }

  requestHolidays({required String name,required int statusId,required String fromDate,
    required String toDate}) async {
    emit(RequestHolidaysLoading());
    ApiManager apiManager = ApiManager();
    HomeRepo homeRepo = HomeRepoImpl(apiManager);
    var result = await homeRepo.requestHoliday(name: name, statusId: statusId, fromDate: fromDate, toDate: toDate);
    result.fold((l) {
      emit(RequestHolidaysError(l));
    }, (r) {
      emit(RequestHolidaysSuccess(r));
      print("request Holiday cubit: $r");
    });
  }

  getEmployee({required int id}) async {
    emit(GetEmployeeLoading());
    ApiManager apiManager = ApiManager();
    HomeRepo homeRepo = HomeRepoImpl(apiManager);
    var result = await homeRepo.getEmployee(uID: id);
    result.fold((l) {
      emit(GetEmployeeError("SomeThing went wrong"));
    }, (r) {
      employee = r.result ?? [];
      if (employee.isNotEmpty) {
        if (employee[0].employeeIds != null &&
            employee[0].employeeIds!.isNotEmpty) {
          employeeUId = employee[0].employeeIds![0];
        } else {
          employeeUId = 0;
        }

        print("employee uidt+++++++++++++++++ ${employeeUId}");
        print("employee result+++++++++++++++++ ${employee}");
        CacheData.saveEmployeeId(data: employeeUId, key: "employeeId");
        CacheData.getEmployeeData(key: "employeeId");
        print(CacheData.getEmployeeData(key: "employeeId"));
        emit(GetEmployeeSuccess(r));
      }
    });
  }

  getStatus() async {
    emit(GetStatusLoading());
    ApiManager apiManager = ApiManager();
    HomeRepo homeRepo = HomeRepoImpl(apiManager);
    var result = await homeRepo.getStatus();
    result.fold((l) {
      emit(GetStatusError(l));
    }, (r) {
      status = r.result ?? [];
      print("Status cubit$expenses");
      emit(GetStatusSuccess(r));
    });
  }
}
