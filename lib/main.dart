import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_app/blocs/auth/auth_bloc.dart';
import 'package:medical_app/blocs/news/news_bloc.dart';
import 'package:medical_app/repositories/auth_repositories.dart';
import 'package:medical_app/repositories/news_repositories.dart';
import 'package:medical_app/views/auth/sign_in_screen.dart';
import 'package:medical_app/widgets/colors.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<AuthRepositories>(
          create: (context) => AuthRepositories(),
        ),
        // RepositoryProvider<NewsRepository>(
        //   create: (context) => NewsRepository(),
        // ),
        BlocProvider(
          create: (context) => NewsBloc(
            NewsRepository(),
          ),
        ),
      ],
      child: BlocProvider(
        create: (context) => AuthBloc(
          authRepository: RepositoryProvider.of<AuthRepositories>(context),
        ),
        child: MaterialApp(
          title: "Medical App",
          theme: ThemeData(
            backgroundColor: AppColors.backgroundColor,
            fontFamily: GoogleFonts.poppins().toString(),
          ),
          debugShowCheckedModeBanner: false,
          home: const SignInScreen(),
        ),
      ),
    );
  }
}
