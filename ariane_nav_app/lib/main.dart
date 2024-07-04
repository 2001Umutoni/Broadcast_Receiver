import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Register.dart';
import 'Signin.dart';
import 'Mycalculators.dart';
import 'my_drawer_header.dart';
import 'auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = DrawerSections.Register;
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    Widget container;
    switch (currentPage) {
      case DrawerSections.Register:
        container = SignUpScreen(authService: _authService);
        break;
      case DrawerSections.Signin:
        container = SignInScreen(authService: _authService);
        break;
      case DrawerSections.MyCalculators:
        container = CalculatorHomePage();
        break;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: Text("Ange Tech"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _authService.signOut();
              setState(() {
                currentPage = DrawerSections.Signin;
              });
            },
          ),
        ],
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyHeaderDrawer(),
              MyDrawerList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        children: [
          menuItem(1, "Register", Icons.dashboard_outlined,
              currentPage == DrawerSections.Register),
          menuItem(2, "Signin", Icons.people_alt_outlined,
              currentPage == DrawerSections.Signin),
          menuItem(3, "My Calculators", Icons.calculate,
              currentPage == DrawerSections.MyCalculators),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            switch (id) {
              case 1:
                currentPage = DrawerSections.Register;
                break;
              case 2:
                currentPage = DrawerSections.Signin;
                break;
              case 3:
                currentPage = DrawerSections.MyCalculators;
                break;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  Register,
  Signin,
  MyCalculators,
}
