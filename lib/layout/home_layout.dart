import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list_app/shared/cubit/cubit.dart';
import 'package:todo_list_app/shared/cubit/states.dart';
class HomeLayout extends StatelessWidget
{
  late Database database;
  var scaffoldKey=GlobalKey<ScaffoldState>();
  var formKey=GlobalKey<FormState>();
  var titleController =TextEditingController();
  var timeController =TextEditingController();
  var dateController =TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(BuildContext context)=>AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates states){
          if(states is AppInsertDatabaseState)
          {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates states)
        {
          AppCubit cubit=AppCubit.get(context);

          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.currentIndex],
              ),
            ),
            body: states is AppGetDatabaseLoadingState ? Center(child: CircularProgressIndicator()):
            cubit.screens[cubit.currentIndex],
            // ConditionalBuilder(
            //   condition: true,
            //   builder: (context)=>cubit.screens[cubit.currentIndex],
            //   fallback: (context)=> Center(child: CircularProgressIndicator()),
            // ),
            floatingActionButton: FloatingActionButton(
              onPressed: ()
              {
                if(cubit.isBottomSheetShown)
                {
                  if(formKey.currentState!.validate())
                  {
                    cubit.insertToDatabase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text);
                    // insertToDatabase(
                    //   title:titleController.text,
                    //   date: dateController.text,
                    //   time: timeController.text,
                    // ).then((value){
                    //   getDataFromDatabase(database).then((value)
                    //   {
                    //     Navigator.pop(context);
                    //     // setState(()
                    //     // {
                    //     //   isBottomSheetShown=false;
                    //     //   fabIcon=Icons.edit;
                    //     //
                    //     //   tasks=value;
                    //     // print('tasks from database$tasks');
                    //     // });
                    //   });
                    // });
                  }
                }else
                {
                  scaffoldKey.currentState!.showBottomSheet((context) =>
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(20.0,),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.text,
                                controller: titleController,

                                validator: ( value)
                                {
                                  if(value!.isEmpty) {
                                    return 'title must not be empty';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Task Title',
                                  prefixIcon: Icon(Icons.title),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              // defaultFromField(
                              //     controller: titleController,
                              //     type: TextInputType.text,
                              //     validate: ( value)
                              //     {
                              //       if(value.isEmpty) {
                              //         return 'title must not be empty';
                              //       }
                              //       return null;
                              //     },
                              //     lable:  'Task Title',
                              //     prefix: Icons.title
                              // ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.datetime,
                                controller: timeController,
                                onTap: ()
                                {
                                  showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now()
                                  ).then((value){
                                    timeController.text=value!.format(context).toString();
                                    print (value.format(context));
                                  });

                                },
                                validator: ( value)
                                {
                                  if(value!.isEmpty) {
                                    return 'Time must not be empty';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Task Time',
                                  prefixIcon: Icon(Icons.access_time_outlined),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              // defaultFromField(
                              //   controller: timeController,
                              //   type: TextInputType.datetime,
                              //   onTab: ()
                              //   {
                              //     showTimePicker(
                              //       context: context,
                              //       initialTime: TimeOfDay.now(),
                              //     ).then((value){
                              //       timeController.text= value!.format(context).toString();
                              //       print(value.format(context));
                              //     });
                              //   },
                              //   validate: ( value)
                              //   {
                              //     if(value.isEmpty) {
                              //       return 'Time must not be empty';
                              //     }
                              //     return null;
                              //   },
                              //   lable:  'Task Time',
                              //   prefix: Icons.access_time,
                              // ),
                              SizedBox(
                                height: 10,
                              ),
                              // defaultFromField(
                              //   controller: dateController,
                              //   type: TextInputType.datetime,
                              //   onTab: (){
                              //     showDatePicker(
                              //       context: context,
                              //       initialDate: DateTime.now(),
                              //       firstDate: DateTime.now(),
                              //       lastDate: DateTime.parse('2021-09-09'),
                              //     ).then((value)
                              //     {
                              //       dateController.text=DateFormat.yMMMd().format(value!).toString();
                              //     });
                              //
                              //   },
                              //   validate: (value)
                              //   {
                              //     if(value.isEmpty) {
                              //       return 'Date must not be empty';
                              //     }
                              //     return null;
                              //   },
                              //   lable:  'Task Date',
                              //   prefix: Icons.calendar_today,
                              // ),
                              TextFormField(
                                keyboardType: TextInputType.datetime,
                                controller: dateController,
                                onTap: ()
                                {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse('2021-09-09'),
                                  ).then((value){
                                    dateController.text=DateFormat.yMMMd().format(value!).toString();

                                  });

                                },
                                validator: ( value)
                                {
                                  if(value!.isEmpty) {
                                    return 'Date must not be empty';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Task Time',
                                  prefixIcon: Icon(Icons.calendar_today),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      elevation: 20.0
                  ).closed.then((value)
                  {
                    cubit.changeBottomSheetState(
                      isShow: false,
                      icon: Icons.edit,
                    );
                  });
                  cubit.changeBottomSheetState(
                    isShow: true,
                    icon: Icons.add,
                  );
                }
              },
              child: Icon(cubit.fabIcon,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex:cubit.currentIndex,
              onTap: (index)
              {
                cubit.changeIndex(index);
              },
              items:
              [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu,
                  ),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.check_circle_outline,
                  ),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.archive_outlined,
                  ),
                  label: 'Archived',
                ),

              ],
            ),
          );
        },
      ),
    );
  }

// Future<String> getName() async
// {
//   return 'youssef mohammed';
// }



}



