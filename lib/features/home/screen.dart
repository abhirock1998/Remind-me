import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notify/bloc/app_bloc.dart';
import 'package:notify/components/components.dart';
import 'package:notify/utils/colors.dart';

import './widget/list.dart';
import './widget/timer.dart';
import './widget/welcome.dart';

class Home extends StatefulWidget {
  static String screenId = 'home_screen';
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AppBloc>(context).onGetMyIssue(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColor.bgColor,
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: AppColor.bgColor,
        leading: GestureDetector(
          onTap: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          child: Icon(
            Icons.menu,
            size: 40,
            color: AppColor.inputHintColor,
          ),
        ),
        title: const Text(
          'Remind me',
          style: TextStyle(fontSize: 16),
        ),
        actions: const [DebugButton()],
      ),
      body: SafeArea(
        child: ScreenWrapper(
          bottom: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const WelcomeText(),
              const MyPomodoro(),
              Divider(
                color: AppColor.inputHintColor,
                thickness: 1,
              ),
              const RedmineIssuesList()
            ],
          ),
        ),
      ),
    );
  }
}
