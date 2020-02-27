import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qiita_client/item_list.dart';
import 'package:qiita_client/models/item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ItemModel>(
          create: (_) => ItemModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Qiita client app',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: ItemListScreen(),
      ),
    );
  }
}
