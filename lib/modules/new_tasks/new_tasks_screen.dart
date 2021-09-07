import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/shared/components/components.dart';
import 'package:todo_list_app/shared/cubit/cubit.dart';
import 'package:todo_list_app/shared/cubit/states.dart';

class NewTasksScreen extends StatelessWidget
{

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){},
      builder: (context, state){
        var tasks=AppCubit.get(context).newTasks;
        return ListView.separated(
          itemBuilder: (context,index)=> buildTaskItem(tasks[index], context),
          separatorBuilder: (context, index)=>
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 60,),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
          itemCount: tasks.length,
        );
      },

    );
  }
}
