part of project.gui;

class CommentsCell extends cl_form.RowDataCell<Map> {
  cl_app.Application<auth.Client> ap;

  CommentsCell(this.ap, grid, row, cell, object)
      : super(grid, row, cell, object);

  void render() {
    final but = new cl_action.Button()
      ..setTip(intl.Comments())
      ..setIcon(cl.Icon.message);
    final m = column.grid.getRowMap(row);
    final taskId = m['task_id'];
    if (object != null) {
      final room = new auth.ChatRoomDTO.fromMap(object);
      but
        ..setTitle('${room.unseen}/${room.messages}')
        ..addAction((e) async {
          e.stopPropagation();
          ap.client.ch.renderChat();
          if (ap.client.ch.focused)
            ap.client.ch.renderRoom(new chat.Room.fromMap(room.toJson())
              ..title = '${intl.Task()} #$taskId');
        });
    } else {
      but.addAction((e) async {
        e.stopPropagation();
        ap.client.ch.renderChat();
        if (ap.client.ch.focused) {
          final room = new chat.Room(
              title: '${intl.Task()} #$taskId',
              context: 'task$taskId',
              members: [
                new chat.Member()
                  ..user_id = ap.client.userId
                  ..picture = ap.client.picture
                  ..name = ap.client.name
              ]);
          ap.client.ch.renderRoom(room);
        }
      });
    }
    cell.append(but.dom);
  }
}
