import 'package:flutter/material.dart';

import '../models/todo_model.dart';
import '../widgets/textstyles.dart';

List<String> dynamicAddTasks = [];

List<String> defaultList = [
  "My",
];

class TodoBucketHomepage extends StatefulWidget {
  const TodoBucketHomepage({super.key});

  @override
  State<TodoBucketHomepage> createState() => _TodoBucketHomepageState();
}

class _TodoBucketHomepageState extends State<TodoBucketHomepage> {
  /// addmytasks
  final addmytasksController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    addmytasksController.dispose();
    super.dispose();
  }

  List<TodoBucketModel> todomodel = List.generate(
      defaultList.length,
      (todoindex) => TodoBucketModel(
          todoId: defaultList[todoindex],
          tabName: "MyTasks",
          tablist: dynamicAddTasks,
          dateCreated: DateTime.now()));

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: defaultList.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            // The flexible app bar with the tabs
            SliverAppBar(
              title: const Text('Bucket'),
              centerTitle: true,
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              bottom: TabBar(
                  tabs: List.generate(
                defaultList.length,
                (index) => Tab(text: defaultList[index]),
              )),
            )
          ],
          // The content of each tab
          body: TabBarView(
            children: List.generate(
              defaultList.length,
              (index) => ListView.builder(
                reverse: true,
                scrollDirection: Axis.vertical,
                physics: const ClampingScrollPhysics(),
                itemCount: dynamicAddTasks.length,
                itemBuilder: (context, elementindex) => ListTile(
                  title: Text(dynamicAddTasks[elementindex].toString()),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 8.0,
          shape: const CircularNotchedRectangle(),
          notchMargin: 3.0,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
              FloatingActionButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25.0),
                          ),
                        ),
                        backgroundColor: Colors.white, // <-- SEE HERE
                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                TextField(
                                  controller: addmytasksController,
                                  autofocus: true,
                                  cursorColor: Colors.black,
                                  enableSuggestions: true,
                                  keyboardType: TextInputType.text,
                                  maxLength: null,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(18.0),
                                    alignLabelWithHint: true,
                                    border: InputBorder.none,
                                    hintText: "New Tasks",
                                    hintStyle: TodoTextStyles().textStyles(
                                        false, true, true, 14.0, true),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      dynamicAddTasks.add(
                                          addmytasksController.text.toString());
                                    });
                                    Navigator.pop(context);
                                    addmytasksController.clear();
                                  },
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          right: 20.0, bottom: 15.0),
                                      child: Text("Done",
                                          style: TodoTextStyles().textStyles(
                                              false,
                                              addmytasksController.text.isEmpty
                                                  ? true
                                                  : false,
                                              false,
                                              14.0,
                                              false)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                  },
                  child: const Icon(
                    Icons.add,
                    color: Colors.blue,
                  ),
                  backgroundColor: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
