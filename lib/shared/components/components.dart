import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_list_app/shared/cubit/cubit.dart';

Widget defaultFromField({
  required TextEditingController controller,
  required TextInputType type,
  Function (String?)? onSubmit,
  Function? onChanged,
  Function? onTab,
  bool isPassword =false,
  required Function validate,
  required String lable,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,

})=> TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  onFieldSubmitted: (s){
    onSubmit!(s);
  },
  onChanged: (s){
    onChanged!(s);
  },
  validator:(s)
  {
    validate(s);
  },
  onTap: (){
    onTab!();
  },
  decoration: InputDecoration(
    labelText: lable,
    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon: suffix != null ? IconButton(
      onPressed: (){
        suffixPressed!();
      },
      icon: Icon(
        suffix,
      ),
    ):null,
    border: OutlineInputBorder(),
  ),
);

Widget buildTaskItem(Map model, context)=> Dismissible(
  key: Key(model['id'].toString()),
  child: Padding(
    padding: const EdgeInsets.all(15.0),
    child: Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue,
          radius: 40.0,
          child: Container(
            child: Text(
              '${model['time']}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model['title']}',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${model['date']}',
                style: TextStyle(
                    color: Colors.grey
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        IconButton(onPressed: ()
        {
          AppCubit.get(context).updateData(
            status: 'done',
            id: model['id'],
          );

        },
            icon: Icon(
              Icons.check_box,
              color: Colors.green,
            )
        ),
        IconButton(onPressed: ()
        {
          AppCubit.get(context).updateData(
            status: 'archive',
            id: model['id'],
          );
        },
            icon: Icon(
              Icons.archive,
              color: Colors.black45,
            )
        ),




      ],
    ),
  ),
  onDismissed:(direction){
    AppCubit.get(context).deleteData(id: model['id']);
  },
);

