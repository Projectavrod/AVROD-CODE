
import 'package:avrod/models/user.dart';
import 'package:avrod/models/user_model.dart';
import 'package:avrod/models/userprofile_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/profileUpdate_cubit/profileupdate_cubit.dart';
import '../../../services/firebase_post.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.userData});
 final UserModel userData;
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formkey = GlobalKey<FormState>();
  final NameController      = TextEditingController();
  final bioController      = TextEditingController();
  final eduController       = TextEditingController();
  final locationController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          NameController.text=widget.userData.name??"";
          bioController.text=widget.userData.bio??"";
          eduController.text=widget.userData.education ??"";
          locationController.text=widget.userData.location??'';
        });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => ProfileupdateCubit(),
  child: Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back,color: Colors.black),
              onPressed: () { Navigator.pop(context); },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      body: BlocBuilder<ProfileupdateCubit, ProfileupdateState>(
  builder: (context, updateState) {
    if(updateState is ProfileupdateUpdated){
      context.read<ProfileupdateCubit>().resetCubit();
    }
    return Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Row(
                //    mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Stack(
                //       children: [
                //         Container(
                //           decoration: BoxDecoration(
                //             shape: BoxShape.circle,
                //             border: Border.all(
                //               color: Colors.white,
                //               width: 5,
                //               style: BorderStyle.solid,
                //             ),
                //           ),
                //           child: CircleAvatar(
                //             backgroundImage: AssetImage("assets/images/user/messi.jpg"),
                //             radius: 75,
                //           ),
                //         ),
                //
                //           Positioned(
                //             bottom: 0,
                //             right: 0,
                //             child: Container(
                //                 padding: const EdgeInsets.all(8),
                //                 decoration: BoxDecoration(
                //                   color: Colors.grey[100],
                //                   shape: BoxShape.circle,
                //                 ),
                //                 child: const Icon(
                //                   Icons.edit,
                //                   color: Colors.black,
                //                   size: 22,
                //                 )),
                //           ),
                //       ],
                //     ),
                //   ],
                // ),
                Row(
                  children: [
                    const Text(
                      "Name",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: NameController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.3),
                      hintText: 'Name',
                      hintStyle: TextStyle(color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.transparent
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.transparent
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.transparent
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),)
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    const Text(
                      "Bio",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: bioController,
                  maxLines: 5,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.3),
                      hintText: 'Bio details',
                      hintStyle: TextStyle(color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.transparent
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.transparent
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.transparent
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),)
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    const Text(
                      "Education",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: eduController,
                  maxLines: 2,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.3),
                      hintText: 'Education details',
                      hintStyle: TextStyle(color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.transparent
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.transparent
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.transparent
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),)
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    const Text(
                      "Location",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: locationController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.3),
                      hintText: 'Location',
                      hintStyle: TextStyle(color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.transparent
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.transparent
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.transparent
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),)
                ),
                SizedBox(height: 30,),
                InkWell(
                  onTap: (){
                    // if(_formkey.currentState!.validate()){
                    context.read<ProfileupdateCubit>().updateProfile( name: NameController.text??"", bio: bioController.text??'', education: eduController.text??'', location: locationController.text??'');
                    // }

                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 46,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue
                    ),
                    child: updateState is ProfileupdateLoading?Row(mainAxisAlignment: MainAxisAlignment.center,children: [SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 0.6,color: Colors.white,)),const SizedBox(width: 8,),Text("Updating...",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold)),],):Text("Update",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                  ),
                )
              ],
            ),
          ),
        ),
      );
  },
),
    ),
);
  }
}
