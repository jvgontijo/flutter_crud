import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_crud/models/items.dart';
import 'package:flutter_crud/provider/items_providers.dart';
import 'package:provider/provider.dart';

class ItemsForm extends StatelessWidget {

  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  void _loadFormData(Items items){
    if(items != null){
      _formData['id'] = items.id;
      _formData['titulo'] = items.titulo;
      _formData['subtitulo'] = items.subtitulo;
      _formData['movieUrl'] = items.movieUrl;
      _formData['dateTime'] = items.dateTime;
    }
  }

  @override
  Widget build(BuildContext context) {

    //O momento que chega nesse modalroute é que acontece o erro.
    // final items = ModalRoute.of(context)!.settings.arguments as Items;
    // _loadFormData(items);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Items'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: (){
                final isValid = _form.currentState!.validate();

                if(isValid){
                  // final id = Random().nextDouble().toString();
                  // print(id);
                  _form.currentState!.save();
                  Provider.of<ItemsProvider>(context, listen: false).
                  put(Items(
                      _formData['id']!,
                      _formData['titulo']!,
                      _formData['subtitulo']!,
                      _formData['movieUrl']!,
                      _formData['dateTime']!)
                  );

                  Navigator.of(context).pop();
                }

              },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _formData['id'],
                decoration: InputDecoration(labelText: 'Id'),
                validator: (value){
                  if(value == null || value.trim().isEmpty) {
                    return 'Id inválido';
                  }
                },
                onSaved: (value) => _formData['id'] = value.toString(),
              ),
              TextFormField(
                initialValue: _formData['titulo'],
                decoration: InputDecoration(labelText: 'Titulo'),
                validator: (value){
                  if(value == null || value.trim().isEmpty) {
                    return 'Titulo inválido';
                  }
                },
                onSaved: (value) => _formData['titulo'] = value.toString(),
              ),
              TextFormField(
                initialValue: _formData['subtitulo'],
                decoration: InputDecoration(labelText: 'Subtitulo'),
                onSaved: (value) => _formData['subtitulo'] = value!,
              ),
              TextFormField(
                initialValue: _formData['movieUrl'],
                decoration: InputDecoration(labelText: 'Imagem URL'),
                onSaved: (value) => _formData['movieUrl'] = value!,
              ),
              TextFormField(
                initialValue: _formData['dateTime'],
                decoration: InputDecoration(labelText: 'Data'),
                onSaved: (value) => _formData['dateTime'] = value!,
              )
            ],
          ),
        ),)
    );
  }
}