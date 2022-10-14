import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:university_chatapp2/Repo/SharedPrefrence.dart';
part 'getuser_id_event.dart';
part 'getuser_id_state.dart';

class GetuserIdBloc extends Bloc<GetuserIdEvent, GetuserIdState> {
  GetuserIdBloc() : super(GetuserIdInitial()) {
    on<GetUserId>((event, emit) async {
      String? id = await SharedPreference.getString(SharedPreference.uID);
      emit(GetuserIdSuccess(userId: id));
    });
  }
}
