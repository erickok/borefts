import 'package:borefts2020/data/repository.dart';
import 'package:borefts2020/ui/identity/color.dart';
import 'package:borefts2020/ui/screens/brewers_bloc.dart';
import 'package:borefts2020/ui/screens/events.dart';
import 'package:borefts2020/ui/screens/styles_bloc.dart';
import 'package:borefts2020/ui/screens/styles_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'brewers_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TabsScreenState();
}

class TabsScreenState extends State<TabsScreen> {
  int _currentIndex = 0;
  List<Widget> _tabs = [
    Center(child: Text("INFO")),
    BrewersScreen(),
    StylesScreen(),
    Center(child: Text("FAVS"))
  ];

  void _selectTab(int selected) {
    setState(() {
      _currentIndex = selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BrewersBloc>(
          builder: (_) =>
          BrewersBloc(RepositoryProvider.of<Repository>(context))
            ..add(LoadEvent()),
        ),
        BlocProvider<StylesBloc>(
          builder: (_) =>
          StylesBloc(RepositoryProvider.of<Repository>(context))
            ..add(LoadEvent()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Borefts 2020'),
        ),
        body: Container(
          color: greyBack,
          child: _tabs[_currentIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _selectTab,
          items: [
            const BottomNavigationBarItem(
              icon: const Icon(Icons.info),
              title: const Text("Info"),
              backgroundColor: redVeryDark,
            ),
            const BottomNavigationBarItem(
              icon: const Icon(Icons.local_drink),
              title: const Text("Brewers"),
              backgroundColor: redVeryDark,
            ),
            const BottomNavigationBarItem(
              icon: const Icon(Icons.style),
              title: const Text("Styles"),
              backgroundColor: redVeryDark,
            ),
            const BottomNavigationBarItem(
              icon: const Icon(Icons.favorite),
              title: const Text("Favs"),
              backgroundColor: redVeryDark,
            )
          ],
        ),
      ),
    );
  }
}
