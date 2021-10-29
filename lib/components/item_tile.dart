import 'package:flutter/material.dart';
import 'package:flutter_crud/models/items.dart';
import 'package:flutter_crud/provider/items_providers.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

class ItemTile extends StatelessWidget {

  final Items items;

  const ItemTile(this.items);

  @override
  Widget build(BuildContext context) {

    final movieImage = items.movieUrl == null || items.movieUrl.isEmpty?
        CircleAvatar(child: Icon(Icons.person))
        :CircleAvatar(backgroundImage: NetworkImage(items.movieUrl));

    return ListTile(
      leading: movieImage,
      title: Text(items.titulo),
      subtitle: Text(items.subtitulo),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
                onPressed: (){
                  Navigator.of(context).pushNamed(
                      AppRoutes.ITEMS_FORM,
                    arguments: items,
                  );
                },
                color: Colors.orangeAccent,
                icon: Icon(Icons.edit)),
            IconButton(
                onPressed: (){
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Excluir Item'),
                        content: Text('Tem certeza?'),
                        actions: [
                          FlatButton(
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                            child: Text('Não'),
                          ),
                          FlatButton(
                              child: Text('Sim'),
                              onPressed: () {
                                Provider.of<ItemsProvider>(context, listen: false).remove(items);
                                Navigator.of(context).pop();
                                },
                          )
                        ],
                      ));
                  },
                color: Colors.red,
                icon: Icon(Icons.delete)),
          ],
        ),
      )
    );
  }
}
