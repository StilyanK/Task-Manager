part of project.ctrl;

class ITask extends base.Item<App, Task, int> {
  final String group = Group.Document;
  final String scope = Scope.Commission;

  ITask(req) : super(req, new App());

  Future<Map> doGet(int id) async {
    final task = await manager.app.task.find(id);
    final taskMedia = await manager.app.taskMedia.findByAllByTaskId(id);
    final ret = task.toJson();
    final modifiedBy = await manager.app.user.find(task.modified_by);
    final createdBy = await manager.app.user.find(task.created_by);
    if (modifiedBy != null) {
      ret['doc_stamp_modified'] = {
        'by': modifiedBy.getRepresentation(),
        'date':
            DateFormat('dd/MM/yyyy HH:mm').format(task.date_modified.toLocal())
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
    print(data);
    final task = await manager.app.task.prepare(id, data);
    final user_id = req.session['client']['user_id'];
    if (id != null) {
      task
        ..modified_by = user_id
        ..date_modified = DateTime.now();
      manager.addDirty(task);
    }
    final gridData = data['files'];
    final insert = gridData['insert'];
    final update = gridData['update'];
    final delete = gridData['delete'];

    if (insert != null) {
      for (final r in insert) {
        await manager.persist();
        await manager.app.taskMedia.prepare(null, r)
          ..task_id = task.task_id;
      }
    }
    if (update != null) {
      for (final u in update) {
        await manager.app.taskMedia.update(u);
      }
    }
    if (delete != null) {
      for (final r in delete) {
        await manager.app.taskMedia.deleteById(r['task_media_id']);
      }
    }

    await manager.commit();
    return task.task_id;
  }

  Future updateTaskCard() async {
    final data = await getData();
    final taskId = data['id'];
    final userId = data['user_id'];
    manager = await new Database().init(new App());
    if (taskId == null) return response(null);
    final task = await manager.app.task.find(taskId);
    if (task != null) {
      if (task.assigned_to == userId) {
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
