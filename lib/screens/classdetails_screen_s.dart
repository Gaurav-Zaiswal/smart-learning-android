import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aithon/controller/feedlistview_controller.dart';
import 'package:aithon/widgets/feed_widget.dart';
// import 'package:aithon/utils/detail_page_drawer_t.dart';

// classroom detail screen for teacher
class ClassDetailsStudent extends StatefulWidget {
  @override
  ClassDetailsStudentState createState() => ClassDetailsStudentState();
  // _ClassDetailsStudentState(id);
}

class ClassDetailsStudentState extends State<ClassDetailsStudent> {
  late String feed;
  late FeedListController feedController;
  int classroomId = int.parse(Get.parameters["id"]!);

  ClassDetailsStudentState() {
    feedController = Get.put(FeedListController(classroomId));
  }

  @override
  Widget build(BuildContext context) {
    Widget buildFeeds() => SliverToBoxAdapter(child: Obx(
      () {
        if (feedController.isLoading.value) {        
        return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
              itemCount: feedController.feedList.length,
              primary: false,
              shrinkWrap: true,
              itemBuilder: (BuildContext ctx, index) {
                return FeedBox(
                  feed: feedController.feedList[index],
                );
              });
        }
      },
    ));
    // render a list of feeds that are posted in that class by teacher
    return Scaffold(
      appBar: AppBar(
          // title: Text(classId),
          title: const Text("Class Feeds")),
      // drawer: DetailPageDrawerTeacher(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed("/list-assignment/$classroomId"),
        child: const Icon(Icons.assignment),
      ),
      body: CustomScrollView(
        slivers: [
          buildFeeds()
        ],
      ),
      // body: Center(
      //   // child: TextFieldForFeed(classRoomId: this.classroomId),
      //   child: buildFeeds(),
      // ),
    );
  }
}