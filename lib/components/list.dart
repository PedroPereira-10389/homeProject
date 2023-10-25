import 'dart:async';

import 'package:flutter/material.dart';

class ListWidget extends StatefulWidget {
  const ListWidget(
      {super.key,});

  @override
  State<ListWidget> createState() => _ListWidget();
}

class _ListWidget extends State<ListWidget> {
  @override
  Widget build(BuildContext context) {
    return  
    ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: const <Widget>[
        ListTile(
          leading: CircleAvatar(child: Text('A')),
          title: Text('Headline'),
          subtitle: Text('Supporting text'),
          trailing: Icon(Icons.favorite_rounded),
        ),
        Divider(height: 0),
        ListTile(
          leading: CircleAvatar(child: Text('B')),
          title: Text('Headline'),
          subtitle: Text(
              'Longer supporting text to demonstrate how the text wraps and how the leading and trailing widgets are centered vertically with the text.'),
          trailing: Icon(Icons.favorite_rounded),
        ),
        Divider(height: 0),
        ListTile(
          leading: CircleAvatar(child: Text('C')),
          title: Text('Headline'),
          subtitle: Text(
              "Longer supporting text to demonstrate how the text wraps and how setting 'ListTile.isThreeLine = true' aligns leading and trailing widgets to the top vertically with the text."),
          trailing: Icon(Icons.favorite_rounded),
          isThreeLine: true,
        ),
        Divider(height: 0),
      ],
    );
  }
}
