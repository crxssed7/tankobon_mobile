import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import 'package:tankobon_mobile/src/views/page/discover.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List screens = [
    const DiscoverPage(),
    const Text("Page 2"),
    const Text("Page 3"),
  ];
  int currentScreen = 0;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color.fromARGB(255, 8, 8, 8),
        backgroundColor: const Color.fromARGB(255, 15, 15, 15),
        fontFamily: 'Montserrat',
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Colors.black,
          onPrimary: Colors.white,
          secondary: Colors.white,
          onSecondary: Colors.black,
          error: Colors.red,
          onError: Colors.white,
          background: Colors.white,
          onBackground: Colors.black,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 82, 185, 185),
                  Color.fromARGB(255, 82, 218, 171)
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: GNav(
                tabs: const [
                  GButton(icon: LineIcons.book, text: "Discover"),
                  GButton(icon: LineIcons.star, text: "Favourites"),
                  GButton(icon: LineIcons.cog, text: "Settings"),
                ],
                onTabChange: (int value) => {
                  setState(() {
                    currentScreen = value;
                  })
                },
                selectedIndex: currentScreen,
                activeColor: const Color.fromARGB(255, 33, 37, 41),
                color: const Color.fromARGB(255, 33, 37, 41),
                rippleColor: const Color.fromARGB(255, 82, 185, 185),
                duration: const Duration(milliseconds: 250),
                tabActiveBorder: Border.all(
                  color: const Color.fromARGB(255, 33, 37, 41),
                  width: 2,
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                gap: 10,
                hoverColor: const Color.fromARGB(255, 82, 185, 185),
              ),
            ),
          ),
        ),
        body: screens[currentScreen],
      ),
    );
  }
}
