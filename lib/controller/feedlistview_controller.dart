import 'package:get/state_manager.dart';
// import 'package:aithon/api/api_service.dart';  // for production
import 'package:aithon/api/api_service_local.dart'; // for local 
import 'package:aithon/model/feed_list_model.dart';
import 'package:aithon/model/home_screen_model.dart';

class FeedListController extends GetxController {
  int classId;
  FeedListController(this.classId);
  // Controller for fetching the specific classroom in which
  //  the currently user is enrolled/ or created

  var feedList = <ClassroomFeedListModel>[].obs;
  var isLoading = true.obs; // to show circular loading moving icon

  @override
  void onInit() {
    fetchFeeds();
    super.onInit();
  }

  // call API to fetch the classrooms of users
  void fetchFeeds() async {
    // controller to fetch the list of created/enrolled classrooms (for both teacher and student)

    isLoading(true);
    try {
      var feeds = await APIService.getFeeds(classId.toString());
      if (feeds != null) {
        for (int i = 0; i < feeds.length; i++) {
          feedList.add(feeds[i]);
        }
        // feedList.value = feeds;
      }
    } finally {
      isLoading(false);
    }
  }
}