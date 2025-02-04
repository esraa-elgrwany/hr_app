import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_app/features/home_screen/data/model/expenses_model.dart';
import 'package:meta/meta.dart';
import '../../../../core/Api_Services/Api-Manager.dart';
import '../../../../core/Failures/Failures.dart';
import '../../../../core/cache/shared_preferences.dart';
import '../../../auth/data/models/employee_model.dart';
import '../../Data/Repo/HomeRepo.dart';
import '../../Data/Repo/HomeRepoImpl.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  static HomeCubit get(context) => BlocProvider.of(context);
  List<Result> expenses = [];
  List<EmployeeResult> employee=[];
  List<int> employeeId=[];
  HomeCubit() : super(HomeInitial());

  getExpenses() async {
    emit(GetExpensesLoading());
    ApiManager apiManager = ApiManager();
    HomeRepo homeRepo = HomeRepoImpl(apiManager);
    var result = await homeRepo.getExpenses();
    result.fold((l) {
      emit(GetExpensesError(l));
    }, (r) {
      expenses= r.result??[];
      emit(GetExpensesSuccess(r));
    });
  }
  getEmployee() async {
    await Future.delayed(Duration(seconds: 1));
    emit(GetEmployeeLoading());
    ApiManager apiManager = ApiManager();
    HomeRepo homeRepo = HomeRepoImpl(apiManager);
    var result = await homeRepo.getEmployee();
    result.fold((l) {
      emit(GetEmployeeError("SomeThing went wrong"));
    }, (r) {
      employee=r.result??[];
      employeeId = employee
          .map((employee) => employee.employeeIds ?? [])
          .expand((ids) => ids)
          .toList();

      print("employee result+++++++++++++++++ ${employee}");
      print("employee id +++++++++++++++++${employeeId}");
      CacheData.saveEmployeeId(data: employeeId.first, key:"employeeId");
      CacheData.getEmployeeData( key:"employeeId");
      print(CacheData.getEmployeeData( key:"employeeId"));
      emit(GetEmployeeSuccess(r));
    });
  }
}
