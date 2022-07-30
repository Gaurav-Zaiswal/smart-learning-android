import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:aithon/controller/classroom_controller.dart';
import 'package:aithon/model/home_screen_model.dart';

// class ClassBoxStudent extends StatefulWidget {
//   // this widget acts as a card for classrooms
//   // primariely used on the homescreen to display list of classrooms

//   final ClassListModel classroomList;
//   ClassBoxStudent({this.classroomList});

//   // const ClassBoxStudent({ Key? key }) : super(key: key);

//   @override
//   State<ClassBoxStudent> createState() => _ClassBoxStudentState(classroomList);
// }

class ClassBoxStudent extends StatelessWidget {
  const ClassBoxStudent({Key? key, required this.data}) : super(key: key);
  final ClassListModel data;

  // static ClassListModel classroomList;
  // // final ClassroomController classroomList;
  // static var t = classroomList.className;
  // ClassBoxStudent(t);
  // print(classroomList);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[600],
      child: InkWell(
        splashColor: Colors.grey.withAlpha(100),
        onTap: () {
          // pass classroom_id ->int in url below
          Get.toNamed(
            '/view-class-student/${data.id}',
          );
        },
        child: Column( 
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [Icon(Icons.class_)],
            ),
            const SizedBox(height: 10),
            ListTile(
              // leading: Icon(Icons.class_),
              title: Text(
                data.className,
                style: const TextStyle(color: Colors.white70),
              ),
              dense: false,
              subtitle: Text(
                data.classDescription,
              ),
            ),
          ],
        ),
      ),
    );
  }
}