library project.shared;

abstract class TaskStatus {
  static const int ToDo = 0;
  static const int Done = 1;
  static const int Test = 2;
  static const int InProgress = 3;
  static const int ForDiscussion = 4;
  static const int Canceled = 5;
  static const int Postponed = 6;

  static const List taskStatus = const [
    const {'v': 'To-Do', 'k': ToDo},
    const {'v': 'Done', 'k': Done},
    const {'v': 'Test', 'k': Test},
    const {'v': 'In Progress', 'k': InProgress},
    const {'v': 'For discussion', 'k': ForDiscussion},
    const {'v': 'Canceled', 'k': Canceled},
    const {'v': 'Postponed', 'k': Postponed},
  ];

  static String getTaskTitleByID(int key) =>
      taskStatus.firstWhere((o) => o['k'] == key, orElse: () => {'v': ''})['v'];

  static String getStatusColor(int status) {
    String statusClass = '';
    if (status == ToDo) {
      statusClass = 'to-do';
    } else if (status == Done) {
      statusClass = 'done';
    } else if (status == Test) {
      statusClass = 'test';
    } else if (status == InProgress) {
      statusClass = 'in-progress';
    } else if (status == ForDiscussion) {
      statusClass = 'for-discussion';
    } else if (status == Canceled) {
      statusClass = 'canceled';
    } else if (status == Postponed) {
      statusClass = 'postponed';
    }
    return statusClass;
  }
}

abstract class TaskPriority {
  static const int Low = 0;
  static const int Medium = 1;
  static const int High = 2;
  static const int Urgent = 3;

  static const List taskPriority = const [
    const {'v': 'Low', 'k': Low},
    const {'v': 'Medium', 'k': Medium},
    const {'v': 'High', 'k': High},
    const {'v': 'Urgent', 'k': Urgent},
  ];

  static String getTaskPriorityByID(int key) => taskPriority
      .firstWhere((o) => o['k'] == key, orElse: () => {'v': ''})['v'];
}
