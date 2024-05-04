import 'package:flutter/material.dart';
import 'package:my_api/network/api_service.dart';
import 'package:my_api/network/model/task_model.dart';
import 'package:provider/provider.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API Testing"),
      ),
      body: _listenFutureTask(context),
    );
  }

  FutureBuilder _listenFutureTask(BuildContext context) {
    return FutureBuilder<List<TaskModel>>(
      future: Provider.of<ApiService>(context, listen: false).getTask(),
      builder: (BuildContext context, AsyncSnapshot<List<TaskModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Container(
              child: Center(
                child: Text("Loading Erro"),
              ),
            );
          }
          final tasks = snapshot.data;
          return _listTasks(tasks!);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  ListView _listTasks(List<TaskModel> tasks) {
    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Container(
              child: ListTile(
                leading: Image.network(tasks[index].thumbnailUrl.toString()),
                title: Text(tasks[index].title.toString()),
              ),
            ),
          );
        });
  }
}
