import 'package:node_app/utils/app_routers.dart';
import 'package:node_app/utils/my_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:node_app/utils/utility.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MyPreferences.init();
  runApp(MultiRepositoryProvider(
    providers: Utility.getAllRepository(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: Utility.getAllProviders(context),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ),
          useMaterial3: true,
        ),
        onGenerateRoute: AppRoutes.generateRoute,
        initialRoute: AppRoutes.initialScreenRoute,
      ),
    );
  }
}
