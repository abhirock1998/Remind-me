import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:notify/bloc/app_bloc.dart';
import 'package:notify/features/features.dart';
import 'package:notify/repository/repository.dart';
import 'package:notify/repository/services/redmine.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  HydratedBloc.storage = storage;
  runApp(const RedmineTimer());
}

class RedmineTimer extends StatelessWidget {
  const RedmineTimer({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (ctx) => AppRepository(service: RedmineService()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (ctx) => AppBloc(repository: ctx.read<AppRepository>()),
          )
        ],
        child: MaterialApp(
          title: 'Remind me',
          debugShowCheckedModeBanner: false,
          initialRoute: Splash.screenId,
          routes: <String, WidgetBuilder>{
            Home.screenId: (ctx) => const Home(),
            Login.screenId: (ctx) => const Login(),
            Splash.screenId: (ctx) => const Splash(),
          },
        ),
      ),
    );
  }
}
