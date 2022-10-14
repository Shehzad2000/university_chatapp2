import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_chatapp2/Bloc/AdminBloc/SignUpbloc.dart';
import 'package:university_chatapp2/Models/RequestModels/AdminRequestModel.dart';
import 'package:university_chatapp2/Utility/Contraints/Decoration.dart';
import 'package:university_chatapp2/Utility/Widget/Buttons.dart';
import 'package:university_chatapp2/Utility/Widget/IconButtons.dart';

import '../../../Bloc/AdminBloc/SignUpState.dart';
import '../../../Utility/Contraints/Text.dart';
import '../../../Utility/Widget/AppBarWidget.dart';
import '../../../Utility/Widget/DropDownWidgets/DropDownWidget.dart';
import '../../../Utility/Widget/ListTile.dart';
import '../../../Utility/Widget/MyNav.dart';
import '../../../Utility/Widget/NavigationBar1.dart';
class EditProfile extends StatefulWidget {
  AdminRequestModel? requestModel;
  EditProfile({Key? key,this.requestModel}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  SignUpBloc? signUpBloc;
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var contactController=TextEditingController();
  var passwordController=TextEditingController();
  dynamic groupValue;
  dynamic status;
  dynamic image;
  @override
  void initState() {
    signUpBloc=BlocProvider.of<SignUpBloc>(context);
    if(widget.requestModel!=null){
      nameController.text=widget.requestModel!.adminName!;
      emailController.text=widget.requestModel!.adminEmail!;
      contactController.text=widget.requestModel!.adminContact!;
      passwordController.text=widget.requestModel!.adminPassword==null?"null":"null";
      groupValue=widget.requestModel!.adminGender!;
      status=widget.requestModel!.adminStatus==1?"Active":"InActive";
      image=widget.requestModel!.adminImage!;
    }
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:  PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.13),
          child:const AppBarWidget()
      ),
      body: BlocListener<SignUpBloc, SingUpStates>(
  listener: (context, state) {

    // TODO: implement listener
  },
  child: SingleChildScrollView(
        child: Stack(
          children: [
        Column(
        children: [
        Center(
        child: Container(
          margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/2),
          height: MediaQuery.of(context).size.height*.16,
          width: MediaQuery
              .of(context)
              .size
              .width * 0.4,
        decoration: const BoxDecoration(
          // color: Colors.green,
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage("assets/images/z.jpg"),
              fit: BoxFit.fill,
            )
        ),
      ),
    ),

          Container(
            margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/8),
            child: text(widget.requestModel!.adminName.toString(), FontWeight.normal, 15.0, Colors.blue),
          ),
          Container(
            margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/16,bottom: MediaQuery.of(context).size.height*0.1/16),
            child: text(
                widget.requestModel!.adminEmail!, FontWeight.normal, 15.0,
                Colors.blue
            ),
          ),
     Divider(
       height: MediaQuery.of(context).size.height*.1/8,
       thickness: 1,
    ),
          Center(
            child: Form(
               child: Column(
                 children: [
                   Container(
                       margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*.1/8,),
                       width: MediaQuery.of(context).size.width * 0.9,
                       child: TextFormField(
                         controller: nameController,
                         decoration: buildInputDecoration("Name", 1, false),
                       )
                   ),
                   Container(
                       margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*.1/8,),
                       width: MediaQuery.of(context).size.width * 0.9,
                    child: TextFormField(
                      controller: emailController,
                      decoration: buildInputDecoration("Email", 1, false),
                    )
                   //  child: buildTextField("Name:", "Beast Incarnet", false),
              ),
                   Container(

                       margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*.1/8,),
                       width: MediaQuery.of(context).size.width * 0.9,
                       child: TextFormField(
                         controller: passwordController,
                         decoration: buildInputDecoration("Password", 1, false),
                       )
                   ),
                   Container(

                       margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*.1/8,),
                       width: MediaQuery.of(context).size.width * 0.9,
                       child: TextFormField(
                         controller: contactController,
                         decoration: buildInputDecoration("Contact", 1, false),
                       )
                   ),
                   Container(
                     alignment: Alignment.topLeft,
                     margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1/8,left: MediaQuery.of(context).size.height*0.1/3),
                     child: const Text('Gender:',style: TextStyle(color:Colors.blue,fontSize: 20),),
                   ),
                   SizedBox(
                     width: MediaQuery.of(context).size.width*.8,

                     child: Row(
                       children: <Widget>[

                         Expanded(
                           flex: 1,
                           child: RadioListTile(
                             value: "Male",
                             groupValue: groupValue,
                             title: Text("Male",style: TextStyle(color:Colors.blue,fontSize: 17),),
                             onChanged: (newValue) =>
                                 setState(() => groupValue = newValue as String?),
                             activeColor: Colors.lightBlueAccent,
                             selected: false,
                           ),
                         ),
                         Expanded(
                           flex: 1,
                           child: RadioListTile(
                             value: "Female",
                             groupValue: groupValue,
                             title: Text("Female",style: TextStyle(color:Colors.blue,fontSize: 17)),
                             onChanged: (newValue) =>
                                 setState(() => groupValue = newValue as String?),
                             activeColor: Colors.lightBlueAccent,
                             selected: false,
                           ),
                         ),
                       ],
                     ),
                   ),

                   Container(
                       width: MediaQuery.of(context).size.width*0.9,
                       margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*.1/8),
                       child: DropDown(
                         callbackFunction: customFunction,
                       )),

                 ],
               ),


            ),
          ),



    ],
    ),
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.15, left: MediaQuery.of(context).size.height*.26),

                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius:  MediaQuery.of(context).size.height*0.1/3.8,
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.height*0.1/4.2,
                    child:const Icon(CupertinoIcons.camera, size: 30,),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                alignment: Alignment.bottomCenter,
                margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*.9,bottom: MediaQuery.of(context).size.height*0.1/10),
                height: MediaQuery.of(context).size.height*0.26/4,
                child: MyButton(title: "Edit Profile",onPressed: (){},),
              ),
            )
          ],

        ),
      ),
),
      bottomNavigationBar: Theme(data: Theme.of(context).copyWith(
          iconTheme:const IconThemeData(color: Colors.white)), child: navbar2()),
    );
  }

  void customFunction(newString){
    setState(() {
      status=newString;
    });
  }
}
Widget buildTextField(String labelText,String placeholder,bool isPasswordTextField){
  var isObsecurePassword;
  return Padding(
padding: const EdgeInsets.only(bottom: 30.0),
    child: TextField(
      obscureText: isPasswordTextField?isObsecurePassword:false,
      decoration: InputDecoration(
        suffixIcon: isPasswordTextField?iconButton(Icons.remove_red_eye, Colors.grey, 15):null,
        contentPadding: EdgeInsets.only(bottom: 5),
        labelText: labelText,
        hintText: placeholder,
        hintStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey
        )
      ),
    ),
  );
}