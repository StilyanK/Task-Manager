library project.shared;

abstract class TaskStatus {
  static const int ToDo = 0;
  static const int Done = 1;
  static const int Test = 2;
  static const int InProgress = 3;
  static const int ForDiscussion = 4;
  static const int Canceled = 5;
  static const int Postponed = 6;
}

abstract class TaskPriority {
  static const int Low = 0;
  static const int Medium = 1;
  static const int High = 2;
  static const int Urgent = 3;
}
