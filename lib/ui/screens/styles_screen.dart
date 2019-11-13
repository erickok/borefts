import 'package:borefts2020/data/models/styles.dart';
import 'package:borefts2020/data/repository.dart';
import 'package:borefts2020/ui/screens/style_bloc.dart';
import 'package:borefts2020/ui/screens/style_screen.dart';
import 'package:borefts2020/ui/screens/styles_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'events.dart';

class StylesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StylesBloc, StylesState>(
      builder: (BuildContext context, StylesState styles) {
        return Scaffold(
          body: _buildScreen(styles),
        );
      },
    );
  }

  Widget _buildScreen(StylesState styles) {
    if (styles is StylesLoaded) {
      return _buildList(styles.styles);
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget _buildList(List<Style> styles) {
    return ListView.builder(
        itemCount: styles.length,
        itemBuilder: (BuildContext context, int i) {
          return _buildRow(context, styles[i]);
        });
  }

  Widget _buildRow(BuildContext context, Style style) {
    return ListTile(
      // TODO leading: , // square with color?
      title: Text(style.name),
      onTap: () {
        _openBrewer(context, style);
      },
    );
  }

  void _openBrewer(BuildContext outerContext, Style brewer) {
    Navigator.of(outerContext)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return BlocProvider<StyleBloc>(
        builder: (_) =>
        StyleBloc(RepositoryProvider.of<Repository>(outerContext), brewer)
          ..add(BeersLoadEvent()),
        child: StyleScreen(),
      );
    }));
  }

}
