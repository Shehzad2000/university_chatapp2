import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_chatapp2/Bloc/CreateGroupBloc/create_group_bloc.dart';
import 'package:university_chatapp2/Screens/ChatScreen/MessageScreen.dart';
import '../Contraints/Gradient_contraints.dart';
import 'DashBoard_Cards.dart';
class UserDashboard_Card extends StatefulWidget {
  UserDashboard_Card({Key? key}) : super(key: key);

  @override
  State<UserDashboard_Card> createState() => _UserDashboard_CardState();
}

class _UserDashboard_CardState extends State<UserDashboard_Card> {



  CreateGroupBloc? createGroupBloc;

  @override
  void initState() {
    createGroupBloc = BlocProvider.of<CreateGroupBloc>(context);
    createGroupBloc!.add(GetGroupsByStudentID(studentID: "Lg6vUsFiD6jHKpeOrW9A"));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:BlocBuilder<CreateGroupBloc, CreateGroupStates>(
  builder: (context, state) {
   if(state is CreateGroupLoadingState){
     return const CircularProgressIndicator();
   }
   else if(state is CreateGroupShowDataState){
     return ListView.builder(
         itemCount: state.list!.length,
         scrollDirection: Axis.vertical,
         itemBuilder: (BuildContext context,int index){
           return   GestureDetector(
             child: Container(
                 height: MediaQuery.of(context).size.height*0.31/1.9,
                 margin:  EdgeInsets.only(left: MediaQuery.of(context).size.height*0.1/10,top: MediaQuery.of(context).size.height*0.1/10,right: MediaQuery.of(context).size.height*0.1/10,bottom: MediaQuery.of(context).size.height*0.1/10),
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height*0.1/6),

                     gradient: gradients(Alignment.centerRight, Alignment.center,Colors.orangeAccent,Colors.deepOrange,Colors.deepOrangeAccent)
                 ),
                 child:card( state.list![index].groupName.toString(),state.list![index].groupDescription.toString(), (){
                   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MessageScreen(
                     createGroupModel: state.list![index],
                   )));
                 },context)
             ),onTap: (){
             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MessageScreen(
               createGroupModel: state.list![index],
             )));
           },
           );
         });
   }
   else if(state is CreateGroupErrorState){
     return const Center(child: Text("Choti Bachi ho Kiya"));
   }
   return Container();
  },

),

    );
  }
}
