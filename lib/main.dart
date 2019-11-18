import 'package:borefts2020/data/beers_repository.dart';
import 'package:borefts2020/data/data_bloc.dart';
import 'package:borefts2020/data/star_repository.dart';
import 'package:borefts2020/ui/identity/color.dart';
import 'package:borefts2020/ui/identity/theme.dart';
import 'package:borefts2020/ui/screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/api.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: redVeryDark));

    final StarRepository starRepository = StarRepository();
    final BeersRepository beersRepository = BeersRepository(Api());
    return MaterialApp(
      title: 'Borefts 2020',
      theme: boreftsLightTheme(),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<DataBloc>(
            builder: (_) => DataBloc(beersRepository, starRepository),
          )
        ],
        child: TabsScreen(),
      ),
    );
  }
}
