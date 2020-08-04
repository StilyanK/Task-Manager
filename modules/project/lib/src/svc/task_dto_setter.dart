part of project.svc;

class TaskCardDTOSetter {
  mapper.Task ent;

  TaskCardDTOSetter(this.ent);

  TaskDTO setDto() {
    final dto = new TaskDTO()
      ..id = ent.task_id
      ..status = ent.status
      ..title = ent.title
      ..description = ent.description
      ..assignedTo = ent.assigned_to
      ..createdBy = ent.created_by
      ..createdTime = ent.date_created
      ..modifiedBy = ent.modified_by
      ..deadLine = ent.deadline
      ..progress = ent.progress ?? 0
      ..priority = ent.priority;
    return dto;
  }
}
