import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../pages/home_page.dart';
import '../pages/login.dart';
import '../repository/user_repo.dart' as repo;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigateToHome();
  }

  void navigateToHome() async {
    await Future.delayed(Duration(seconds: 2));
    if (repo.currentUser.value.token != null) {
      Navigator.of(context).pop();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
      print(repo.currentUser.value);
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Login()));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.dotsTriangle(
          color: Colors.blue,
          size: 50,
        ),
      ),
    );
  }
}
