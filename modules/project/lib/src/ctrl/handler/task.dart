part of project.ctrl;

class ITask extends base.Item<App, Task, int> {
  final String group = Group.Project;
  final String scope = Scope.Task;

  ITask(req) : super(req, new App());

  Future<Map> doGet(int id) async {
    final task = await manager.app.task.find(id);
    if (task == null || task.is_deleted)
      throw new base.ResourceNotFoundException();
    final taskMedia = await manager.app.taskMedia.findByAllByTaskId(id);
    final ret = task.toJson();
    final modifiedBy = await manager.app.user.find(task.modified_by);
    final createdBy = await manager.app.user.find(task.created_by);
    if (modifiedBy != null) {
      ret['doc_stamp_modified'] = {
        'by': modifiedBy.getRepresentation(),
        'date': task.date_modified.toString()
      };
    }
    ret['doc_stamp_created'] = {
      'by': createdBy.getRepresentation(),
      'date': task.date_created.toString()
    };

    ret['files'] = [];
    for (final el in taskMedia) {
      ret['files']
          .add({'source': el.source, 'task_media_id': el.task_media_id});
    }

    return ret;
  }

  Future<int> doSave(int id, Map data) async {
    final task = await manager.app.task.prepare(id, data);
    final user_id = req.session['client']['user_id'];
    if (id != null) {
      task
        ..modified_by = user_id
        ..date_modified = DateTime.now();
      manager.addDirty(task);
    }
    final gridData = data['files'];
    if (gridData != null) {
      await manager.persist();

      await manager.app.taskMedia.crud(gridData.cast<String, List>(),
          entity.$TaskMedia.task_id, task.task_id);
    }

    await manager.commit();
    return task.task_id;
  }

  Future updateTaskCard() async {
    final data = await getData();
    final taskId = data['id'];
    final userId = data['user_id'];
    final cardDate = DateTime.parse(data['date']);
    manager = await new Database().init(new App());
    if (taskId == null) return response(null);
    final task = await manager.app.task.find(taskId);
    if (task != null && !task.is_deleted) {
      final dateCreated = new DateTime(task.date_created.year,
          task.date_created.month, task.date_created.day);
      final dateCreatedCheck = cardDate.isAfter(dateCreated) ||
          cardDate.isAtSameMomentAs(dateCreated);
      if (task.assigned_to == userId && dateCreatedCheck) {
        final dto = new TaskCardDTOSetter(task).setDto();
        return response(dto);
      } else {
        return response(null);
      }
    }
    return response(null);
  }

  Future<bool> doDelete(int id) => manager.app.task.deleteById(id);
}
