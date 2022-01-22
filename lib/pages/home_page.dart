import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/extension/priority_extension.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/pages/create_task_page.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<TodoModel> todos = [];
  List<TodoModel> filterTask = [];
  @override
  void initState() {
    super.initState();
    filterTask = todos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CupertinoSearchTextField(
          padding: const EdgeInsets.all(10),
          prefixInsets: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
          onSuffixTap: () {
            setState(() {
              filterTask = todos;
            });
          },
          onChanged: (value) {},
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.color_filter,
            ),
          ),
        ],
      ),
      drawer: const Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final TodoModel todo = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreatTaskPage(),
            ),
          );
          if (todo != null) {
            setState(() {
              todos.add(todo);
              // filterTask.add(todo);
            });
          }
        },
        child: const Icon(CupertinoIcons.add),
      ),
      body: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (context, index) {
          final TodoModel todo = filterTask[index];
          return TaskCard(todo: todo);
        },
        separatorBuilder: (context, index) => const SizedBox(
          height: 1,
        ),
        itemCount: filterTask.length,
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  const TaskCard({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final TodoModel todo;

  dateTimeParse(DateTime time) {
    return DateFormat('yyyy-MM-dd – kk:mm').format(time);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 80,
        child: Center(
          child: ListTile(
            dense: true,
            leading: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                border: Border.all(
                    color: PriorityColor.pColor[todo.priority]!, width: 3),
                shape: BoxShape.circle,
              ),
            ),
            title: Text(todo.title),
            subtitle: Text(todo.tasks.map((e) => "$e \n").toList().toString() +
                "\n${dateTimeParse(todo.startTime)}\n${dateTimeParse(todo.endTime)}"),
            trailing: const Icon(
              CupertinoIcons.arrow_right_square_fill,
            ),
          ),
        ),
      ),
    );
  }
}
