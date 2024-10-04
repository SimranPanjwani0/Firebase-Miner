import 'package:chat_app/appRoutes/app_routes.dart';
import 'package:chat_app/controllers/data_controller.dart';
import 'package:chat_app/helpers/auth_helper.dart';
import 'package:chat_app/helpers/todo_helper.dart';
import 'package:chat_app/modals/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    DataController listenable = Provider.of<DataController>(context);
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                  AuthHelper.instance.auth.currentUser!.displayName ?? "Guest"),
              accountEmail: Text(
                  AuthHelper.instance.auth.currentUser!.email ?? "Undefined"),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.instance.allUser,
              );
            },
            icon: const Icon(
              Icons.people_alt_rounded,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.instance.allFriends,
              );
            },
            icon: const Icon(
              Icons.chat_rounded,
            ),
          ),
          IconButton(
            onPressed: () {
              AuthHelper.instance.logOut().then((value) {
                Navigator.of(context).pushReplacementNamed(
                  AppRoutes.instance.logIn,
                );
              });
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: listenable.allTodo.length,
          itemBuilder: (context, index) => ListTile(
            leading: Text(listenable.allTodo[index].id),
            title: Text(listenable.allTodo[index].title),
            trailing: IconButton(
              onPressed: () {
                TodoHelper.tHelper.deleteTodo(todo: listenable.allTodo[index]);
              },
              icon: const Icon(Icons.delete),
            ),
          ),
        ),
      ),
      floatingActionButton: ElevatedButton.icon(
        onPressed: () {
          TodoHelper.tHelper.addTodo(
            todo: Todo("102", "Learn New Thing", false, "18665423"),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text(
          "Add Todo",
        ),
      ),
    );
  }
}
