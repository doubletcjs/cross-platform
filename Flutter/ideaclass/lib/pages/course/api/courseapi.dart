import 'package:ideaclass/public/networking.dart';

class CourseApi {
  getCourseList(currPage, pageSize, title, Function finish) {
    Networking.requestBase(
      "/app/course/getCourseList",
      finish,
      params: {
        "currPage": currPage,
        "pageSize": pageSize,
        "title": title,
      },
    );
  }

  searchLector(currPage, pageSize, title, type, Function finish) {
    Networking.requestBase(
      "/app/index/searchLector",
      finish,
      params: {
        "currPage": currPage,
        "pageSize": pageSize,
        "title": title,
        "type": type,
      },
    );
  }

  getCourseDetail(courseId, Function finish) {
    Networking.requestBase(
      "/app/course/getCourseDetail",
      finish,
      params: {
        "courseId": courseId,
      },
    );
  }
}
