class TodoBucketModel {
  String todoId;
  String? tabName;
  List<String>? tablist;
  DateTime dateCreated;
  TodoBucketModel(
      {
      required this.todoId,
      required this.tabName,
      required this.tablist,
      required this.dateCreated});
}
