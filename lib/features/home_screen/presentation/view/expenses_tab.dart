import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view_model/home_cubit.dart';

class ExpensesTab extends StatefulWidget{
  static const String routeName="expensesTab";
  const ExpensesTab({super.key});

  @override
  State<ExpensesTab> createState() => _ExpensesTabState();
}

class _ExpensesTabState extends State<ExpensesTab> {
  List<String> state=["draft","submitted","approved"];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => HomeCubit()..getEmployee()..getExpenses(),
  child: Scaffold(
      appBar: AppBar(
        title: Text("Expenses", style: TextStyle(color: Colors.white)),
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
              child: Icon(Icons.arrow_back_outlined,color: Colors.white,)),
        ),
      ),
      body: BlocBuilder<HomeCubit,HomeState>(
  builder: (context, state) {
    if (state is GetExpensesLoading) {
      return Center(child: CircularProgressIndicator(
          color: Colors.green
      ),);
    } else if (state is GetExpensesError) {
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
    }else{
    return Column(
        children: [
          Container(
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFF121645),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount:HomeCubit.get(context).expenses.length,
              itemBuilder: (context, index) {
                return _buildExpenseCard(context,index);
              },
            ),
          ),
        ],
      );}
  },
),
        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius:BorderRadiusDirectional.circular(30)
          ),
        backgroundColor: Color(0xFF121645),
    onPressed: () {},
    child: Icon(Icons.add, size: 32,color: Colors.white,),
    ),
    ),
);
  }

  Widget _buildExpenseCard(BuildContext context, int index) {
    return Stack(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              //margin: EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Container(
                 height: 90,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildStatusBadge(state[1]),
                          SizedBox(height:16),
                          Text("${HomeCubit.get(context).expenses[index].totalAmountCurrency} SAR",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF121645))),
                        ],
                      ),
                     Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              "${HomeCubit.get(context).expenses[index].name}",
                                maxLines: 2,
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Text("${HomeCubit.get(context).expenses[index].date}", style: TextStyle(color:Color(0XFF8e95a1))),
                              SizedBox(width:8),
                              Icon(Icons.calendar_today_outlined, size: 16, color:Color(0XFF8e95a1)),
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
            top:20,
            right:0,
            child: Align(
                alignment: Alignment.centerRight,
                child: _buildIconBadge()),
          ),
        ],

    );
  }

  Widget _buildStatusBadge(String status) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical:6),
      decoration: BoxDecoration(color:Color(0xFFe7fbef), borderRadius: BorderRadius.circular(12)),
      child: Text(status, style: TextStyle(color:Color(0XFF37bf85), fontSize: 16,fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildIconBadge() {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.yellow,
      child: Icon(Icons.attach_money, color: Colors.blue, size:24),
    );
  }
}
