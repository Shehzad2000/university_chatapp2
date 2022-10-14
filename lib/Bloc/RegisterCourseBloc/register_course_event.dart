part of 'register_course_bloc.dart';

@override
abstract class RegisterCourseEvents {}
class RegisterMainCourseEvent extends RegisterCourseEvents{
  RegisterCoursesRequestModel requestModel;
  RegisterMainCourseEvent(this.requestModel);
}
class RemoveMainCourseEvent extends RegisterCourseEvents{
  String? id;
  RemoveMainCourseEvent(this.id);
}
