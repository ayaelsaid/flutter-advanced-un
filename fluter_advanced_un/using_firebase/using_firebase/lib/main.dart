import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:using_firebase/bloc/courses/courses_bloc.dart';
import 'package:using_firebase/bloc/lectures/lecture_bloc.dart';
import 'package:using_firebase/cubit/auth_cubit.dart';
import 'package:using_firebase/firebase_options.dart';
import 'package:using_firebase/pages/course_details.dart';
// import 'package:using_firebase/pages/forget_password.dart';
import 'package:using_firebase/pages/home_page.dart';
import 'package:using_firebase/pages/login.dart';
import 'package:using_firebase/pages/onboarding_page.dart';
import 'package:using_firebase/pages/rest_page.dart';
import 'package:using_firebase/pages/sign_up.dart';
import 'package:using_firebase/pages/splash.dart';
// import 'package:using_firebase/pages/login.dart';
// import 'package:using_firebase/pages/rest_page.dart';
// import 'package:using_firebase/pages/sign_up.dart';
import 'package:using_firebase/service/pref.service.dart';
import 'package:using_firebase/utilis/color_utilis.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesService.init();

  try {
<<<<<<< HEAD
=======
  // note i use allow read, write: if true in firebase;
>>>>>>> 77aa48a81dcd59148a69b8d231ebe8b26f2c9c1c

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Failed to initialize Firebase: $e');
  }
  // await dotenv.load(fileName: ".env");
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (ctx) => AuthCubit()),
        BlocProvider(create: (ctx) => CourseBloc()),
        BlocProvider(create: (ctx) => LectureBloc()),
      ],
      child: DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: _CustomScrollBehaviour(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: ColorUtility.gbScaffold,
        fontFamily: ' PlusJakartaSans',
        colorScheme: ColorScheme.fromSeed(seedColor: ColorUtility.main),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) {
        final String routeName = settings.name ?? '';
        final dynamic data = settings.arguments;
        switch (routeName) {
          case LoginPage.id:
            return MaterialPageRoute(builder: (context) => LoginPage());
          case SignUpPage.id:
            return MaterialPageRoute(builder: (context) => SignUpPage());
          case ResetPasswordPage.id:
            return MaterialPageRoute(builder: (context) => ResetPasswordPage());
          case OnBoardingPage.id:
            return MaterialPageRoute(builder: (context) => OnBoardingPage());
          case HomePage.id:
            return MaterialPageRoute(builder: (context) => HomePage());
          case CourseDetailsPage.id:
            return MaterialPageRoute(
                builder: (context) => CourseDetailsPage(
                      course: data,
                    ));

          default:
            return MaterialPageRoute(builder: (context) => SplashPage());
        }
      },
      initialRoute: SplashPage.id,
    );
  }
}

class _CustomScrollBehaviour extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.mouse,
        PointerDeviceKind.touch,
      };
}