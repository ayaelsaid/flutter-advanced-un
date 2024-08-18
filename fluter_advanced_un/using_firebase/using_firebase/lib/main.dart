import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:using_firebase/bloc/courses/courses_bloc.dart';
import 'package:using_firebase/bloc/lectures/lecture_bloc.dart';
import 'package:using_firebase/cubit/auth_cubit.dart';
import 'package:using_firebase/firebase_options.dart';
import 'package:using_firebase/pages/course_details.dart';
// import 'package:using_firebase/pages/forget_password.dart';
import 'package:using_firebase/pages/home_page.dart';
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
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Failed to initialize Firebase: $e');
  }
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: _CustomScrollBehaviour(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: ColorUtility.gbScaffold,
        colorScheme: ColorScheme.fromSeed(seedColor: ColorUtility.main),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) {
        final String routeName = settings.name ?? '';
        final dynamic data = settings.arguments;

        switch (routeName) {
          case HomePage.id:
            return MaterialPageRoute(
              builder: (context) => const HomePage(),
            );
          case CourseDetailsPage.id:
            return MaterialPageRoute(
              builder: (context) => CourseDetailsPage(course: data),
            );
          default:
            return MaterialPageRoute(
              builder: (context) => const Scaffold(
                body: Center(child: Text('Page not found')),
              ),
            );
        }
      },
      initialRoute: HomePage.id,
    );
  }
}

// initialRoute: LoginPage.id,
// onGenerateRoute: (settings) {
//   final String routeName = settings.name ?? '';
//   switch (routeName) {
//     case LoginPage.id:
//       return MaterialPageRoute(builder: (context) => const LoginPage());
//     case SignUpPage.id:
//       return MaterialPageRoute(builder: (context) => const SignUpPage());
//     case ResetPasswordPage.id:
//       return MaterialPageRoute(
//           builder: (context) => const ResetPasswordPage());
//     case HomePage.id:
//       return MaterialPageRoute(builder: (context) => const HomePage());
//     case ForgotPasswordPage.id:
//       return MaterialPageRoute(
//           builder: (context) => const ForgotPasswordPage());

//     default:
//       return MaterialPageRoute(
//         builder: (context) => const Scaffold(
//     body: Center(child: Text('Page not found')),
//   ),
// );
//   }
// },

class _CustomScrollBehaviour extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.mouse,
        PointerDeviceKind.touch,
      };
}
