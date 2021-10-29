import 'package:flutter/material.dart';
import 'package:flutter_crud/components/item_tile.dart';
import 'package:flutter_crud/provider/items_providers.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

class ItemsList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    final ItemsProvider items = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Itens'),
        actions: <Widget>[
          IconButton(
              onPressed: (){
                Navigator.of(context).pushNamed(
                    AppRoutes.ITEMS_FORM
                );
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
          itemCount: items.count,
          itemBuilder: (context, i) => ItemTile(items.byIndex(i))),
    );
  }
}