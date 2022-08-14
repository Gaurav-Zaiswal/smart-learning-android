// To parse this JSON data, do
//
//     final ClassroomFeedListModel = ClassroomFeedListModelFromJson(jsonString);

import 'dart:convert';

List<ClassroomFeedListModel> classroomFeedListModelFromJson(String str) => List<ClassroomFeedListModel>.from(json.decode(str).map((x) => ClassroomFeedListModel.fromJson(x)));

String classroomFeedListModelToJson(List<ClassroomFeedListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClassroomFeedListModel {
    /*
     * model for feeds
     */
    int id;
    String feedDescription;
    DateTime postedOn;
    int classroomId;
    AssignmentId assignmentId;
    PostedBy postedBy;

    ClassroomFeedListModel({
      required  this.id,
      required  this.feedDescription,
      required  this.postedOn,
      required  this.classroomId,
      required  this.assignmentId,
      required  this.postedBy,
    });

    factory ClassroomFeedListModel.fromJson(Map<String, dynamic> json) => ClassroomFeedListModel(
        id: json["id"],
        feedDescription: json["feed_description"],
        postedOn: DateTime.parse(json["posted_on"]),
        classroomId: json["classroom_id"],
        assignmentId: AssignmentId.fromJson(json["assignment_id"]),
        postedBy: PostedBy.fromJson(json["posted_by"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "feed_description": feedDescription,
        "posted_on": postedOn.toIso8601String(),
        "classroom_id": classroomId,
        "assignment_id": assignmentId.toJson(),
        "posted_by": postedBy.toJson(),
    };
}

class AssignmentId {
  /*
   * model for assignment
   */
    String title;
    String description;
    DateTime creationDate;
    PostedBy teacher;
    ClassName className;
    int id;

    AssignmentId({
      required  this.title,
      required  this.description,
      required  this.creationDate,
      required  this.teacher,
      required  this.className,
      required  this.id,
    });

    factory AssignmentId.fromJson(Map<String, dynamic> json) => AssignmentId(
        title: json["title"],
        description: json["description"],
        creationDate: DateTime.parse(json["creation_date"]),
        teacher: PostedBy.fromJson(json["teacher"]),
        className: ClassName.fromJson(json["class_name"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "creation_date": creationDate.toIso8601String(),
        "teacher": teacher.toJson(),
        "class_name": className.toJson(),
        "id": id,
    };
}

class ClassName {
    /*
    *model for classroom 
    */
    int id;
    String className;
    String classDescription;
    DateTime creationDate;
    bool isClassCodeEnabled;
    String classCode;
    PostedBy createdBy;

    ClassName({
      required  this.id,
      required  this.className,
      required  this.classDescription,
      required  this.creationDate,
      required  this.isClassCodeEnabled,
      required  this.classCode,
      required  this.createdBy,
    });

    factory ClassName.fromJson(Map<String, dynamic> json) => ClassName(
        id: json["id"],
        className: json["class_name"],
        classDescription: json["class_description"],
        creationDate: DateTime.parse(json["creation_date"]),
        isClassCodeEnabled: json["is_class_code_enabled"],
        classCode: json["class_code"],
        createdBy: PostedBy.fromJson(json["created_by"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "class_name": className,
        "class_description": classDescription,
        "creation_date": creationDate.toIso8601String(),
        "is_class_code_enabled": isClassCodeEnabled,
        "class_code": classCode,
        "created_by": createdBy.toJson(),
    };
}

class PostedBy {
    PostedBy({
      required  this.user,
    });

    User user;

    factory PostedBy.fromJson(Map<String, dynamic> json) => PostedBy(
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user.toJson(),
    };
}

class User {
    User({
      required  this.id,
      required  this.firstName,
      required  this.lastName,
      required  this.isTeacher,
      required  this.isStudent,
    });

    int id;
    String firstName;
    String lastName;
    bool isTeacher;
    bool isStudent;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        isTeacher: json["is_teacher"],
        isStudent: json["is_student"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "is_teacher": isTeacher,
        "is_student": isStudent,
    };
}