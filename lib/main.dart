import 'package:assessment_swavalambanam/features/newspaper/presentation/bloc/newspaper_bloc.dart';
import 'package:assessment_swavalambanam/features/newspaper/presentation/pages/newspaper.dart';
import 'package:assessment_swavalambanam/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<NewspaperBloc>(),
        ),
      ],
      child: MaterialApp(
          title: 'Newspaper',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const NewspaperPage()),
    );
  }
}
