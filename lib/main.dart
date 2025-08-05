import 'package:fit_life/view/screen/add_client_screen.dart';
import 'package:fit_life/view/screen/add_session_screen2.dart';
import 'package:fit_life/view/screen/all_client_screen.dart';
import 'package:fit_life/view/screen/auth_screen.dart';
import 'package:fit_life/view/screen/choose_client_screen.dart';
import 'package:fit_life/view/screen/dashboard_screen.dart';
import 'package:fit_life/view/screen/login_screen.dart';
import 'package:fit_life/view/screen/register_screen.dart';
import 'package:fit_life/view/screen/trainer_profile_screen.dart';
import 'package:fit_life/view/theme/app_theme.dart';
import 'package:fit_life/viewModel/auth_viewModel.dart';
import 'package:fit_life/viewModel/client_viewModel.dart';
import 'package:fit_life/viewModel/progress_viewModel.dart';
import 'package:fit_life/viewModel/receipt_viewModel.dart';
import 'package:fit_life/viewModel/session_viewModel.dart';
import 'package:fit_life/viewModel/trainer_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
        ChangeNotifierProvider(create: (context) => TrainerViewModel()),
        ChangeNotifierProvider(create: (context) => ClientViewModel()),
        ChangeNotifierProvider(create: (context) => SessionViewModel()),
        ChangeNotifierProvider(create: (context) => ReceiptViewModel()),
        ChangeNotifierProvider(create: (context) => ProgressViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: AuthScreen(),
      routes: {
        'login': (context) => LoginScreen(),
        'register': (context) => RegisterScreen(),
        'dashboard': (context) => DashboardScreen(),
        'userProfile': (context) => TrainerProfileScreen(),
        'addClient': (context) => AddClientScreen(),
        'chooseClient': (context) => ChooseClientScreen(),
        'allClient': (context) => AllClientScreen(),
        'addSession2': (context) => AddSessionScreen2(),
      },
    );
  }
}
