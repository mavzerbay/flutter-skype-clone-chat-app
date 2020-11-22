import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skype_clone/provider/image_upload_provider.dart';
import 'package:skype_clone/provider/user_provider.dart';
import 'package:skype_clone/resources/resources.dart';
import 'package:skype_clone/screens/search_screen.dart';
import 'package:skype_clone/screens/screens.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthMethods _repository = AuthMethods();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ImageUploadProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: "Mav Chat",
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          "/search_screen": (context) => SearchScreen(),
        },
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        home: FutureBuilder(
            future: _repository.getCurrentUser(),
            builder:
                (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
              if (snapshot.hasData) {
                return HomeScreen();
              } else {
                return LoginScreen();
              }
            }),
      ),
    );
  }
}
