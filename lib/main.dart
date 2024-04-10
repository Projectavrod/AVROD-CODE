import 'package:avrod/cubits/getUserData/user_cubit.dart';
import 'package:avrod/cubits/searchCubit/search_cubit.dart';
import 'package:avrod/providers/user_provider.dart';
import 'package:avrod/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'Screens/Auth_Screens/splash_screen.dart';
import 'constants/global_variables.dart';

import 'cubits/getAllUsersDetails/getAllUsersdetails_cubit.dart';
import 'cubits/getallpost_cubit/getallpost_cubit.dart';
import 'cubits/getmessages_cubit/getmessages_cubit.dart';
import 'cubits/individualchatvideoview/indiavidul_chat_video_view_cubit.dart';
import 'cubits/sendmessage_cubit/send_message_cubit.dart';
import 'cubits/videoPlayerUpdateCubit/video_player_update_cubit.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
        create: (context) => GetAllUsersDetailsCubit(),lazy: true,),
        BlocProvider(
        create: (context) => SearchCubit(),
          lazy: false,
        ),
        BlocProvider(
        create: (context) => GetmessagesCubit(),
          lazy: false,
        ),
        BlocProvider(
        create: (context) => SendMessageCubit(),
          lazy: false,
        ),BlocProvider(
        create: (context) => VideoPlayerUpdateCubit(),
          lazy: false,
        ),BlocProvider(
        create: (context) => IndiavidulChatVideoViewCubit(),
          lazy: false,
        ),
        BlocProvider(create: (context)=>GetallpostCubit()),
        BlocProvider(
        create: (context) => UserCubit(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'AVROD',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: false,
          scaffoldBackgroundColor: GlobalVariables.backgroundColor,
          colorScheme:
          const ColorScheme.light(primary: GlobalVariables.backgroundColor),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            iconTheme: IconThemeData(color: GlobalVariables.iconColor),
          ),
          inputDecorationTheme: InputDecorationTheme(
          ),
        ),
        onGenerateRoute: (settings) => generateRoute(settings),
        // home: const HomeScreen(),
        home: const SplashScreen(),
      ),
    );
  }
}

