import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../Widgets/text_widget.dart';
import '../../constants/global_variables.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailcontroller = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool loading =false;
  bool upSecure=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(16.0),
          child: Container(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 80.0),
                  Text(
                    'AVROD',
                    style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,color: Colors.blue
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Welcome to AVROD',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment:MainAxisAlignment.end,
                        children: [
                          SizedBox(height: 16.0),
                          TextFormField(

                            showCursor: true,
                            cursorColor: Colors.blue,
                            // cursorHeight: 30,
                            cursorWidth: 2,
                            controller: emailcontroller,
                            decoration: InputDecoration(
                                hintText: 'Email',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14),


                                ),
                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14) ),
                                contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 8)

                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.0),
                          TextFormField(
                            showCursor: true,
                            cursorColor: Colors.blue,
                            // cursorHeight: 30,
                            cursorWidth: 2,
                            controller: passwordController,
                            obscureText:upSecure,
                            decoration: InputDecoration(

                              suffixIcon: InkWell(
                                onTap: (){
                                  setState(() {
                                    upSecure=!upSecure;
                                  });
                                },
                                child:upSecure?Icon(
                                  CupertinoIcons.eye_slash_fill,color: Colors.black,
                                ):Icon(
                                  Icons.remove_red_eye,color: Colors.black,
                                ) ,
                              ),
                                hintText: 'Password',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14),


                                ),
                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14) ),
                                contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 8)
                            ),

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.0),
                          InkWell(
                            onTap: () async {

                              if(formKey.currentState?.validate()==true && !(loading)){
                                setState(() {
                                  loading=true;
                                });
                                print(emailcontroller.text);
                                // final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(email:emailcontroller.text,password: passwordController.text)
                                    .then((value1) async {
                                  Fluttertoast.showToast(msg: "Login Successfully Completed");

                                }).catchError((c){
                                  Fluttertoast.showToast(msg: "Invalid Username or Password");
                                });
                                setState(() {
                                  loading=false;
                                });

                              }
                            },
                            child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color:Colors.blue,
                              ),

                              child:  Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  !loading?
                                  const Text('Log in',style: TextStyle(color: Colors.white,fontSize: 20.0,
                                    fontWeight: FontWeight.bold,),):
                                  Container(height: 18,width: 18,child:const CircularProgressIndicator(color: Colors.white,strokeWidth: 1,) ,),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 10.0),
                          TextButton(
                            onPressed: () {
                              // Implement forgot password functionality
                            },
                            child: Text('Forgot Password?',style: TextStyle(color: Colors.black,fontSize: 16.0,
                              fontWeight: FontWeight.normal,),),
                          ),
                          SizedBox(height: 60.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 14,left: 14),
                                width: 80,color:Colors.grey,height: 1,
                              ),
                              const Text("Register Here"),

                              Container(
                                margin: const EdgeInsets.only(left: 14,right: 14),
                                width: 80,color: Colors.grey,height: 1,
                              ),

                            ],
                          ),
                          SizedBox(height: 16.0),
                          const Text("If you don't Have an Account, Register with"),
                          SizedBox(height: 16.0),

                          InkWell(
                            onTap: () async {
                              _handleGoogleSignIn(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.only(left: 20,right: 20,top: 16,bottom: 16),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),border: Border.all(color:Colors.grey)),
                              child: SvgPicture.asset('assets/images/google.svg'),
                            ),
                          ),
                          SizedBox(height: 36.0),
                        ],
                      ),
                    ),
                  ),
                  // InkWell(
                  //
                  //   child: Container(
                  //     height: 48,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(100),
                  //         border: Border.all( color:Colors.blue,)
                  //     ),
                  //
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Text('Create New Account',style: TextStyle(color: Colors.blue,fontSize: 18.0,
                  //           fontWeight: FontWeight.w700,),),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Function for google sign in
  Future<void> _handleGoogleSignIn(BuildContext context) async {
    await GoogleSignIn().signOut();
    final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      // var googleie = await _googleSignIn.currentUser;
      print('----------------------');
      String? name= googleUser?.displayName;
      print(googleUser?.displayName);
      if (googleUser != null) {

        await FirebaseAuth.instance
            .fetchSignInMethodsForEmail(googleUser.email)
            .then((value1) async {

          GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
          User? user;

          if(value1.isNotEmpty){
            AuthCredential credential = GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken,
              idToken: googleAuth.idToken,
            );
            UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
            user = userCredential.user;
          }else{

            String? pass= await setPasswordPopUp(context);
            if(pass != null){
              AuthCredential credential = GoogleAuthProvider.credential(
                accessToken: googleAuth.accessToken,
                idToken: googleAuth.idToken,
              );
              final credential2 = await  FirebaseAuth.instance.createUserWithEmailAndPassword(email: googleUser.email, password: pass);

              // UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential2);
              user = credential2.user;

              try {

                await credential2.user?.linkWithCredential(credential);

                FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
                  "userId":user?.uid,
                  "name":name,
                  "nameSmall":name?.toLowerCase(),
                  "email":user?.email
                });
                credential2.user?.updateDisplayName(name);
              } on FirebaseAuthException catch (e) {
                Fluttertoast.showToast(msg: e.message?? "failed");
              }
            }

          }


          if (user != null) {
            Fluttertoast.showToast(
              // backgroundColor: AppColorUtils.icons,
                msg: 'Logged In Successfully');
          }else{
            Fluttertoast.showToast(
                msg: 'User can not signed in using Google Sign-In, Please TRy Again Later');

          }

        });







      }
    } catch (error) {
      Fluttertoast.showToast(msg: '$error');
    }
  }


  Future<String?> setPasswordPopUp(BuildContext context) async{

    final newPassword = TextEditingController();
    final confirmPassword = TextEditingController();
    bool showPassword1 = false;
    bool showPassword2 = false;
    bool success = false;
    final forgetPassword = GlobalKey<FormState>();

    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {

          return WillPopScope(
            onWillPop: ()async{
              return false;
            },
            child: Dialog(
              child: StatefulBuilder(
                builder: (context, setState) {
                  return BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                    child: Container(
                      // padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color:

                          AppColorUtils.white,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12))),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            children: [
                              const SizedBox(
                                height: 18,
                              ),
                              Text('Create Password',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: AppColorUtils.splashColor1),),
                              const SizedBox(
                                height: 14,
                              ),
                              Divider(height: 1,color: AppColorUtils.splashColor1,),
                              const SizedBox(height: 8,),

                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Form(
                                  key: forgetPassword,
                                  child: Column(
                                    children: [
                                      // Text('Email : ${emailcontroller.text}'),

                                      const SizedBox(height: 8,),
                                      TextFormField(

                                        showCursor: true,
                                        cursorColor: Colors.blue,
                                        // cursorHeight: 30,
                                        cursorWidth: 2,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.deny(RegExp("[ ]")),
                                        ],
                                        style: TextStyle(
                                            color:
                                            AppColorUtils.LTdarkcharcoal
                                        ),
                                        controller: newPassword,
                                        onChanged: (value) {

                                          setState(() {

                                          });

                                        },
                                        obscureText: !showPassword1,
                                        decoration: InputDecoration(
                                          errorMaxLines: 4,
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                showPassword1 = !showPassword1;
                                              });
                                            },
                                            icon: Icon(
                                              (showPassword1)
                                                  ? CupertinoIcons.eye
                                                  : CupertinoIcons.eye_slash,
                                              color: AppColorUtils.DTdovegrey,
                                            ),
                                          ),
                                          labelText: newPassword.text.isNotEmpty ? 'New Password' : null,

                                          labelStyle: TextStyle(
                                              fontSize: TextFontSize.px12,
                                              color:
                                              AppColorUtils.LTdarkgrey,
                                              fontWeight: TextFontWeight.regular),
                                          hintText: 'New Password',
                                          hintStyle: TextStyle(
                                              fontWeight: TextFontWeight.medium,
                                              fontSize: 14,
                                              color:
                                              AppColorUtils.LTdarkgrey

                                          ),

                                          fillColor: Colors.transparent,
                                          contentPadding : const EdgeInsets.only(
                                              left: 10, top: 20, bottom: 8),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                  AppColorUtils.buttons)),


                                          disabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                  AppColorUtils.LTline)),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                  AppColorUtils.LTline)),
                                        ),
                                        validator: (value){
                                          RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$');
                                          if(newPassword.text.isEmpty || value ==null){
                                            return 'Please enter password';
                                          }else if(!regex.hasMatch(value)){
                                            return 'Weak Password... Must be contain atLeast 8 characters in length, one upper case, one lower case, one digit, one Special character... ';
                                          }else{
                                            return null;
                                          }
                                        },
                                      ),
                                      const SizedBox(height: 16,),
                                      TextFormField(
                                        showCursor: true,
                                        cursorColor: Colors.blue,
                                        // cursorHeight: 30,
                                        cursorWidth: 2,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.deny(RegExp("[ ]")),
                                        ],
                                        style: TextStyle(
                                            color:
                                            AppColorUtils.LTdarkcharcoal
                                        ),
                                        controller: confirmPassword,
                                        obscureText: !showPassword2,
                                        onChanged: (value) {

                                          setState(() {

                                          });


                                        },
                                        decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                showPassword2 = !showPassword2;
                                              });
                                            },
                                            icon: Icon(
                                              (showPassword2)
                                                  ? CupertinoIcons.eye
                                                  : CupertinoIcons.eye_slash,
                                              color: AppColorUtils.DTdovegrey,
                                            ),
                                          ),
                                          labelText: confirmPassword.text.isNotEmpty ? 'Confirm Password' : null,
                                          labelStyle: TextStyle(
                                              fontSize: TextFontSize.px12,
                                              color:
                                              AppColorUtils.LTdarkgrey,
                                              fontWeight: TextFontWeight.regular),
                                          hintText: 'Confirm Password',
                                          hintStyle: TextStyle(
                                              fontWeight: TextFontWeight.medium,
                                              fontSize: 14,
                                              color:
                                              AppColorUtils.LTdarkgrey

                                          ),

                                          fillColor: Colors.transparent,
                                          contentPadding : const EdgeInsets.only(
                                              left: 10, top: 20, bottom: 8),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                  AppColorUtils.buttons)),
                                          errorBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColorUtils.red)),

                                          disabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                  AppColorUtils.LTline)),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                  AppColorUtils.LTline)),
                                        ),
                                        validator: (value){

                                          if( confirmPassword.text.isEmpty || value ==null || confirmPassword.text.length < 6){
                                            return 'Please Enter Valid Password';
                                          }else if(newPassword.text != confirmPassword.text){
                                            return 'password Mismatch';
                                          }else{
                                            return null;
                                          }
                                        },
                                      ),
                                      const SizedBox(
                                        height: 24,
                                      ),



                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 36,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(4),
                                                border: Border.all(
                                                    color: AppColorUtils.buttons,
                                                    width: 1),
                                                // color: AppColorUtils.buttons,
                                              ),
                                              child: Text_Widget(
                                                  color: AppColorUtils.buttons,
                                                  fontWeight: TextFontWeight.semibold,
                                                  fontSize: TextFontSize.px12,
                                                  'Cancel'),
                                            ),
                                          ),
                                          // SizedBox(width: 6,),

                                          InkWell(
                                            onTap: () async {
                                              if(forgetPassword.currentState?.validate()==true) {
                                                success=true;
                                                setState((){});
                                                // final credential = EmailAuthProvider.credential(email: emailcontroller.text, password: confirmPassword.text);
                                                // FirebaseAuth.instance.
                                                // signInWithEmailAndPassword(email: emailcontroller.text, password: confirmPassword.text);
                                                Navigator.pop(context);
                                              }

                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 36,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(4),
                                                border: Border.all(
                                                    color: AppColorUtils.buttons,
                                                    width: 1),
                                                color: AppColorUtils.buttons,
                                              ),
                                              child: Text_Widget(
                                                  color: AppColorUtils.white,
                                                  fontWeight: TextFontWeight.semibold,
                                                  fontSize: TextFontSize.px12,
                                                   'ok'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10,),
                                    ],
                                  ),
                                ),
                              )

                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        } ).then((value) {
      return success ? newPassword.text : null;
    });
    return success ? newPassword.text : null;
    // Navigator.pop(context);

  }

}