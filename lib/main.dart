import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_with_firebase/cart_logic.dart';
import 'package:flutter_with_firebase/connectivity/noInternetScreen.dart';
import 'package:flutter_with_firebase/firebase_options.dart';
import 'package:flutter_with_firebase/firestore_service.dart';
import 'package:flutter_with_firebase/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'auth_wrapper.dart';
import 'connectivity/connection_provider.dart';
import 'language/app_localizations.dart';
import 'product_provider.dart';
import 'language/language_provider.dart';

void main() async {
 
  WidgetsFlutterBinding.ensureInitialized();
    try {
    await dotenv.load(fileName: ".env");
    print("Successfully loaded .env file");
  } catch (e) {
    print("Error loading .env file: $e");
  }
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartLogic()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        Provider(create: (_) => FirestoreService()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
      ],
      child: const MyApp(),
    ),
  );
}




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<ThemeProvider, LanguageProvider, ConnectivityProvider>(
      builder: (context, themeProvider, languageProvider, connectivityProvider, child) {
        return MaterialApp(
          title: 'E-commerce App',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.values[themeProvider.themeIndex],
          home: connectivityProvider.isOnline
              ? const AuthWrapper()
              : const NoInternetScreen(),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
            Locale('zh', ''),
            Locale('km', ''),
          ],
          locale: languageProvider.locale,
        );
      },
    );
  }
}