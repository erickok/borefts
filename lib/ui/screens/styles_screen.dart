import 'package:borefts2020/data/models/styles.dart';
import 'package:borefts2020/data/repository.dart';
import 'package:borefts2020/ui/screens/style_screen.dart';
import 'package:flutter/material.dart';

class StylesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StylesScreenState();
}

class StylesScreenState extends State<StylesScreen> {
  Future<List<Style>> _styles;

  @override
  void initState() {
    super.initState();
    _styles = Repository.styles();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Style>>(
      future: _styles,
      builder: (context, styles) {
        if (styles.hasData) {
          return ListView.builder(
              itemCount: styles.data.length,
              itemBuilder: (BuildContext context, int i) {
                return _buildRow(styles.data[i]);
              });
        } else if (styles.hasError) {
          return Center(
            child: Text("Error: " + styles.error.toString()),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildRow(Style style) {
    return ListTile(
      // TODO leading: , // square with color?
      title: Text(style.name),
      onTap: () {
        _openBrewer(context, style);
      },
    );
  }

  void _openBrewer(BuildContext context, Style style) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return StyleScreen(style);
    }));
  }
}
