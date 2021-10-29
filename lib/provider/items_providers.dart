import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_crud/data/dummy_items.dart';
import 'package:flutter_crud/models/items.dart';

class ItemsProvider with ChangeNotifier{
  final Map<String, Items> _items = {...DUMMY_ITEMS};

  List<Items> get all{
    return [..._items.values];
  }

  int get count{
    return _items.length;
  }

  Items byIndex(int i){
    return _items.values.elementAt(i);
  }

  void put(Items items){
    if(items == null){
      return;
    }

    //alterar
    if(items.id != null && items.id.trim().isNotEmpty && _items.containsKey(items.id)){
      _items.update(items.id, (_) => Items(
          items.id,
          items.titulo,
          items.subtitulo,
          items.movieUrl,
          items.dateTime));
    } else {//adicionar
      final id = Random().nextInt(100).toString();
      _items.putIfAbsent(id, () => Items(
          id, items.titulo, items.subtitulo, items.movieUrl, items.dateTime
      ));
    }
    notifyListeners();
  }

  void remove(Items items){
    if(items != null && items.id != null){
      _items.remove(items.id);
      notifyListeners();
    }
  }
}