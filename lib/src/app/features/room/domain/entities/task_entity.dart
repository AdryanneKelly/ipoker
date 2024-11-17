// ignore_for_file: public_member_api_docs, sort_constructors_first
class TaskEntity {
  final String roomId;
  final String title;
  final String description;
  final int? storyPoints;
  TaskEntity({
    required this.roomId,
    required this.title,
    required this.description,
    this.storyPoints,
  });
}
