import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_app/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app/responsive/mobilescreen_layout.dart';
import 'package:instagram_app/responsive/responsive_screen_layout.dart';
import 'package:instagram_app/responsive/webscreen_layout.dart';
import 'package:instagram_app/screens/login_screen.dart';
import 'package:instagram_app/screens/signup_screen.dart';
import 'package:instagram_app/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyD04TYwgaJ9TMccQWQWXV0xYiSBxn-lBrs",
      appId: "1:7238091765:web:6c9fb905f5ea075c3616bc",
      messagingSenderId: "7238091765",
      projectId: "instagram-clone-8acc8",
      storageBucket: "instagram-clone-8acc8.appspot.com",
    ));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram App',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackground,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  webScreenLayout: WebScreenLayout(),
                  mobileScreenLayout: MobileScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: blueColor,
                ),
              );
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
