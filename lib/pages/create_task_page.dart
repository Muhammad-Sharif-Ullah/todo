import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/extension/priority_extension.dart';
import 'package:todo/model/todo_model.dart';

class CreatTaskPage extends StatefulWidget {
  const CreatTaskPage({Key? key}) : super(key: key);

  @override
  _CreatTaskPageState createState() => _CreatTaskPageState();
}

class _CreatTaskPageState extends State<CreatTaskPage> {
  List<String?> tasks = [""];
  String title = "";
  late DateTime startTime;
  late DateTime endTime;
  bool isCompleted = false;
  String uid = DateTime.now().toString();
  TaskPriority priority = TaskPriority.normal;

  @override
  void initState() {
    super.initState();
    startTime = DateTime.now();
    endTime = DateTime.now().add(const Duration(days: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create a task"),
        actions: [
          IconButton(
            tooltip: "Save Task",
            onPressed: () {
              final TodoModel todo = TodoModel(
                uid: uid,
                title: title,
                tasks: tasks,
                isCompleted: isCompleted,
                startTime: startTime,
                endTime: endTime,
                priority: priority,
              );
              Navigator.pop(context, todo);
            },
            icon: const Icon(CupertinoIcons.plus_square_on_square),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            tasks.add("");
          });
        },
        child: const Icon(CupertinoIcons.square_list),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(CupertinoIcons.tags),
                hintText: "Add Your Task Title",
              ),
              onChanged: (String? title) {
                setState(() {
                  this.title = title!;
                });
              },
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => Dismissible(
                  key: UniqueKey(),
                  // key: ValueKey(tasks.elementAt(index)),
                  direction: index != 0
                      ? DismissDirection.horizontal
                      : DismissDirection.none,
                  onDismissed: (direction) {
                    final message = tasks[index];
                    setState(() {
                      tasks.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('$message dismissed')));
                  },
                  child: TextFormField(
                    maxLines: null,
                    initialValue: tasks[index],
                    onChanged: (String? value) {
                      tasks[index] = value!;
                    },
                    decoration: InputDecoration(
                      label: Text("Task ${index + 1}"),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: tasks.length,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Priority Selection",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Row(
                  children: List.generate(
                    3,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              priority = TaskPriority.values[index];
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color:
                                  PriorityColor.pColor.values.elementAt(index),
                              border: Border.all(
                                  width: priority.index == index ? 4 : 0,
                                  color: Colors.white),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                IconButton(
                  onPressed: () => materialDatePicker(context, true),
                  tooltip: "Start Time",
                  icon: const Icon(
                    CupertinoIcons.timer_fill,
                    size: 40,
                    color: Colors.greenAccent,
                  ),
                ),
                IconButton(
                  tooltip: "End Time",
                  onPressed: () => materialDatePicker(context, false),
                  icon: const Icon(
                    CupertinoIcons.timer_fill,
                    color: Colors.redAccent,
                    size: 40,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Future<void> materialDatePicker(
      BuildContext context, bool isStartDate) async {
    if (startTime.isAfter(endTime)) {
      setState(() {
        endTime = startTime.add(const Duration(days: 1));
      });
    }
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      helpText: "Select Task ${isStartDate ? "Start" : "End"} Date",
      initialDate: isStartDate ? startTime : endTime,
      firstDate: isStartDate ? DateTime.now() : startTime,
      lastDate: DateTime(3000),
    );
    if (pickedDate != null &&
        pickedDate != (isStartDate ? startTime : endTime)) {
      if (isStartDate) {
        setState(() {
          startTime = pickedDate;
        });
      } else {
        setState(() {
          endTime = pickedDate;
        });
      }
    }
  }
}
