import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_sample/model.dart';
import 'package:sqflite_sample/myprovider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController name = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<MyProvider>(context, listen: false);
    provider.getAllData();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        label: Text('Enter name'),
                      ),
                      controller: name,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        provider
                            .add(
                          ModelClass(
                            name: name.text.trim(),
                          ),
                        )
                            .then(
                          (value) {
                            Navigator.pop(context);
                            name.clear();
                          },
                        );
                      },
                      child: Text('Add'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      body: Consumer<MyProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.list.length,
            itemBuilder: (BuildContext context, int index) {
              final data = value.list[index];
              return ListTile(
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        value.delete(data.id);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: name,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      value.update(
                                        ModelClass(
                                          name: name.text.trim(),
                                          id: data.id,
                                        ),
                                      );
                                    },
                                    child: Text('update'),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                title: Text(value.list[index].name),
              );
            },
          );
        },
      ),
    );
  }
}
