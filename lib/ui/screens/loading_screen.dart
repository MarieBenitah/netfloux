import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:netfloux/repositories/data_repository.dart';
import 'package:netfloux/ui/screens/home_screen.dart';
import 'package:netfloux/utils/constant.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    //todo : appel API
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    // on initialise les différents list de movies
    await dataProvider.initData();
    // On va sur HomeScreen
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return HomeScreen();
      }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/netflix_logo_1.png'),
          SpinKitFadingCircle(
            color: kPrimaryColor,
          )
        ],
      ),
    );
  }
}
