
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Widgets/text_widget.dart';
import '../../constants/global_variables.dart';


class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final currentPassword = TextEditingController();
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();
  bool loading = false;
  final forgetPassword = GlobalKey<FormState>();
  bool showPassword1 = false;
  bool showPassword2 = false;
  bool error = false;
  bool? verify ;


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {


    });

    super.initState();
  }

  RenderBox? mainBox;

  final GlobalKey mainWidgetKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.w,
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Form(
                key: forgetPassword,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Utilsimage.logInImage,

                    const SizedBox(
                      height: 28,
                    ),
                    Container(

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Spacer(),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// Reset Password text

                                Row(
                                  children: [
                                    InkWell(onTap: (){
                                      Navigator.pop(context);
                                    },child: Icon(Icons.arrow_back_outlined)),
                                    Text_Widget(
                                        isLocal: true,
                                        textAlign: TextAlign.center,
                                        color:Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                         'Create New Password'),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),


                                const SizedBox(
                                  height: 16,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 150,width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(150),
                                      image: DecorationImage(image: NetworkImage(FirebaseAuth.instance.currentUser?.photoURL??''),fit: BoxFit.cover,)
                                    ),
                                  ),
                                ),
                                SizedBox(height: 42,),
                                /// Text Field for Current Password
                                TextFormField(
                                  onChanged: (h){
                                    setState(() {

                                    });
                                  },
                                  readOnly: verify==true,
                                  controller: currentPassword,
                                  style: TextStyle(
                                      color: Colors.black
                                  ),
                                  decoration: InputDecoration(
                                    labelText: currentPassword.text.isNotEmpty ? 'Current Password' : null,
                                    labelStyle: TextStyle(
                                        fontSize: 12,
                                       ),
                                    hintText: 'Current Password',
                                    hintStyle: TextStyle(
                                        fontSize: 14,

                                    ),
                                    errorStyle: TextStyle(
                                        color:(verify==true)? Colors.green : Colors.red
                                    ),
                                    errorText: verify==true?'Password Verified':(error)?'Invalid Password' :null,
                                    fillColor: Colors.transparent,
                                    contentPadding : const EdgeInsets.only(
                                        left: 10, top: 20, bottom: 8),
                                    disabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColorUtils.LTdarkgrey
                                        )),
                                    focusedErrorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color:

                                            AppColorUtils.buttons)),
                                    border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color:

                                            AppColorUtils.buttons)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color:

                                            AppColorUtils.buttons)),
                                    errorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color:(verify==true) ? AppColorUtils.green :((currentPassword.text.isEmpty)?AppColorUtils.LTdarkgrey :AppColorUtils.red))),

                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                            AppColorUtils.LTdarkgrey)),
                                  ),
                                ),



                                verify == true ?
                                const SizedBox.shrink() :
                                InkWell(
                                  onTap: () async {
                                    if(loading ==false){
                                      setState(() {
                                        loading = true;
                                      });

                                      verify = await Validate(
                                          currentPassword.text);
                                      error = !(verify ?? false);
                                      setState(() {
                                        loading = false;
                                      });
                                    }


                                  },
                                  child: Container(
                                    height: 40,
                                    margin: EdgeInsets.only(top: 28),
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: AppColorUtils.buttons,
                                        borderRadius: BorderRadius.circular(8)),
                                    child:

                                    /// Continue text
                                    Text_Widget(
                                        isLocal: true,
                                        textAlign: TextAlign.center,
                                        color:

                                        AppColorUtils.DTgrey,
                                        fontWeight: TextFontWeight.semibold,
                                        fontSize: TextFontSize.px14,
                                        (loading)? 'Please Wait...': 'Verify Password'
                                    ),
                                  ),
                                ),




                              ],
                            ),
                          ),



                          Container(
                            foregroundDecoration: BoxDecoration(
                              color: verify != true ?

                              AppColorUtils.white.withOpacity(0.60) :
                              Colors.transparent,
                            ),
                            child: AbsorbPointer(
                              absorbing: verify != true,
                              child: Container(

                                margin: EdgeInsets.only(top: 40),
                                padding: const EdgeInsets.symmetric(horizontal: 16),

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text_Widget(
                                        isLocal: true,
                                        textAlign: TextAlign.center,
                                        color:
                                        AppColorUtils.LTlightblack,
                                        fontWeight: TextFontWeight.bold,
                                        fontSize: TextFontSize.px16,
                                        'New Credentials'),

                                    verify == true?
                                    const Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 8,),
                                        // Text_Widget(
                                        //     isLocal: true,
                                        //     textAlign: TextAlign.left,
                                        //     color:
                                        //     AppColorUtils.DTLTgrey60,
                                        //     fontWeight: TextFontWeight.regular,
                                        //     size: TextFontSize.px12,
                                        //     text: 'credentialsContent')
                                      ],
                                    )
                                        : const SizedBox.shrink(),
                                    const SizedBox(height: 20,),
                                    TextFormField(
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
                                                AppColorUtils.LTdarkgrey)),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color:
                                                AppColorUtils.LTdarkgrey)),
                                      ),
                                      validator: (value){

                                        if(newPassword.text.isEmpty || value ==null || newPassword.text.length < 6){
                                          return 'Please Enter Valid Email';
                                        }else{
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(height: 16,),
                                    TextFormField(
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
                                                AppColorUtils.LTdarkgrey)),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color:
                                                AppColorUtils.LTdarkgrey)),
                                      ),
                                      validator: (value){

                                        if( confirmPassword.text.isEmpty || value ==null || confirmPassword.text.length < 6){
                                          return 'Please Enter Valid Email';
                                        }else if(newPassword.text != confirmPassword.text){
                                          return 'password Mismatch';
                                        }else{
                                          return null;
                                        }
                                      },
                                    ),

                                    const SizedBox(height: 28,),
                                    /// Reset Firebase Function
                                    InkWell(
                                      onTap: () async {

                                        if(forgetPassword.currentState!.validate()){
                                          setState(() {
                                            loading=true;
                                          });

                                          try {
                                            await FirebaseAuth.instance.currentUser!
                                                .updatePassword(
                                                confirmPassword.text).then((value) {
                                                  Fluttertoast.showToast(msg: 'Password Changed');
                                                  Navigator.pop(context);
                                              // ResetSuccessBottomSheet(context);
                                              // print('dsfd${value}');
                                            } );


                                          }catch(e){
                                            print('rerererer${e}');

                                          }
                                          setState(() {
                                            loading=false;
                                          });

                                        }


                                      },
                                      child: Container(
                                        height: 40,
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: AppColorUtils.buttons,
                                            borderRadius: BorderRadius.circular(8)),
                                        child:

                                        /// Continue text
                                        Text_Widget(
                                            textAlign: TextAlign.center,
                                            color:
                                            // theme
                                            //     ? AppColorUtils.white:
                                            AppColorUtils.DTgrey,
                                            fontWeight: TextFontWeight.semibold,
                                            fontSize: TextFontSize.px14,
                                             (verify==true && loading) ? 'PleaseWait...' :
                                            'Confirm Password' ),
                                      ),
                                    ),
                                    const SizedBox(height: 35,)
                                  ],
                                ),
                              ),
                            ),
                          ),


                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Future<bool> Validate(String password) async{
    try {
      final user = FirebaseAuth.instance.currentUser;
      final credential = EmailAuthProvider.credential(
        email: FirebaseAuth.instance.currentUser?.email?? '',
        password: password,
      );
      await user?.reauthenticateWithCredential(credential);
      return true;

    } on Exception catch (e) {

      print('${e}');
      return false;
      // Handle exceptions
    }
  }


  /// Bottom sheet for success message

  ResetSuccessBottomSheet(BuildContext context) {
    showModalBottomSheet(

        isDismissible: false,
        backgroundColor: Colors.transparent,

        context: context,
        builder: (BuildContext context) {


          return StatefulBuilder(
            builder: (context, setState) {
              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                child: Container(
                  decoration: BoxDecoration(
                      color:

                      AppColorUtils.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12))),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),

                          // Container(
                          //   height: 132,
                          //   width: 154,
                          //   decoration: BoxDecoration(
                          //     image: DecorationImage(
                          //       // image: Utilsimage.resetPassword,
                          //       fit: BoxFit.cover,
                          //     ),
                          //   ),
                          // ),

                          const SizedBox(
                            height: 15,
                          ),

                          RichText(
                            text: TextSpan(
                              style: const TextStyle(fontWeight: FontWeight.bold),
                              children: <TextSpan>[
                                TextSpan(
                                    text:'New Password Creation Success',
                                    style: TextStyle(
                                        color:
                                        Colors.black,
                                        fontSize: TextFontSize.px15,
                                        fontWeight: TextFontWeight.medium)),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          InkWell(
                            onTap: () async {
                              // FirebaseAuth.instance.signOut();
                              // final GoogleSignIn googleSignIn =
                              // GoogleSignIn();
                              // googleSignIn.signOut();
                              // await SharedPrefService.pref.clear();
                              // SharedPreferences pref = await SharedPreferences.getInstance();
                              // await pref.setBool('theme', false);
                              // context.read<ThemeCubit>().changeTheme(false);
                              // Navigator.pushAndRemoveUntil(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) =>
                              //       const LoginScreen(),
                              //     ),
                              //         (route) => false);
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
                                  isLocal: true,
                                  color: AppColorUtils.white,
                                  fontWeight: TextFontWeight.semibold,
                                  fontSize: TextFontSize.px12,
                                   'ok'),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          const SizedBox(
                            height: 20,
                          ),

                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        } );

    // Navigator.pop(context);

  }





}
