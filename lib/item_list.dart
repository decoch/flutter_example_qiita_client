import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qiita_client/models/item.dart';

import 'item_detail_screen.dart';

class ItemListScreen extends StatelessWidget {
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
                return ItemDetailRow(item: item);
              },
            ),
          )
        ],
      ),
    );
  }
}

class ItemDetailRow extends StatelessWidget {
  final Item item;

  const ItemDetailRow({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ItemDetailScreen(title: item.title, url: item.url),
          ),
        );
      },
      child: Container(
        height: 60,
        child: Row(
          children: [
            Container(
              height: 44,
              width: 44,
              padding: const EdgeInsets.only(right: 8),
              child: Image.network(item.user.profileImageUrl),
            ),
            Expanded(
              child: Text('Entry ${item.title}'),
            ),
          ],
        ),
      ),
    );
  }
}
