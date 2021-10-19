import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valuation_tool_web/bloc/folder/folder_bloc.dart';
import 'package:valuation_tool_web/bloc/upload_image/upload_image_bloc.dart';
import 'package:valuation_tool_web/repository/black_book_vehicle_repository.dart';
import 'Routes.dart';
import 'bloc/black_book_bloc.dart';
import 'bloc/vehicle_list/vehicle_list_bloc.dart';

List<String> pages = [
  'vehicles',
  'folders',
  'details',
  'profile',
  'settings',
  'help',
  'vin',
];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: 'alex.ayso04@gmail.com', password: 'Password123!');
  runApp(MultiBlocProvider(providers: <BlocProvider<dynamic>>[
    BlocProvider<BlackBookBloc>(
        create: (BuildContext context) =>
            BlackBookBloc(blackBookRepository: BlackBookRepositoryImpl())),
    BlocProvider<VehicleListBloc>(
        create: (BuildContext context) => VehicleListBloc()),
    BlocProvider<FolderBloc>(create: (BuildContext context) => FolderBloc()),
    BlocProvider<UploadImageBloc>(
        create: (BuildContext context) => UploadImageBloc()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Flurorouter.setupRouter();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: Flurorouter.router.generator,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
    );
  }
}
