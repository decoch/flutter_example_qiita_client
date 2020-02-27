import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final itemModel = Provider.of<ItemModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Qiita Client'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: TextField(
              decoration: InputDecoration(labelText: "Search something"),
              onSubmitted: (text) {
                itemModel.search(text);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: itemModel.items.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    child: Text('Entry ${itemModel.items[index].title}'),
                  );
                }),
          )
        ],
      ),
    );
  }
}
