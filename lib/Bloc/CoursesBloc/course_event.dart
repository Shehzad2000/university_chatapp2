part of 'course_bloc.dart';

@override
abstract class CourseEvents {}
class RegisterCourseEvent extends CourseEvents{
  CourseRequestModel? requestModel;
  RegisterCourseEvent(this.requestModel);
}
class UpdateCourseEvent extends CourseEvents{
  CourseRequestModel? courseRequestModel;
  UpdateCourseEvent(this.courseRequestModel);
}
class RemoveCourseEvent extends CourseEvents{
  String? ID;
  RemoveCourseEvent(this.ID);
}
class CourseDetailEvent extends CourseEvents{
  String? ID;
  CourseDetailEvent(this.ID);
}
class ShowAllCourseWithDetailsEvent extends CourseEvents{
}
class SearchCourseEvent extends CourseEvents{
  String? courseCode1,courseCode2;
  SearchCourseEvent({ this.courseCode1, this.courseCode2});
}
