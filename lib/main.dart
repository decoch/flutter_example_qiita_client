import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qiita_client/models/item.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
                final item = itemModel.items[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemDetail(title: item.title, url: item.url),
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    child: Text('Entry ${item.title}'),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class ItemDetail extends StatelessWidget {
  final String title;
  final String url;

  const ItemDetail({
    Key key,
    this.title,
    this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: WebView(
        initialUrl: url,
      ),
    );
  }
}
