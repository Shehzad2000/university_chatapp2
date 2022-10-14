part of 'course_bloc.dart';

@override
abstract class CourseStates {}

class CourseInitialState extends CourseStates {}
class CourseLoadingState extends CourseStates {}
class CourseSuccessState extends CourseStates {

}
class CourseErrorState extends CourseStates {}
class CourseShowDataState extends CourseStates {
  List<CourseRequestModel>? list;
  CourseShowDataState(this.list);
}
