part of project.gui;


class StatusCell extends cl_form.RowDataCell<int> {
  StatusCell(this.ap, grid, row, cell, object) : super(grid, row, cell, object);

  cl_app.Application ap;
  List _res;

  void render() {

    final status = object;
    if (status != TaskStatus.InProgress) {
      final clas = getLabStatusColorIndex(status);
      cell.append(new SpanElement()
        ..classes.add('tag')
        ..classes.add('tag$clas')
        ..text = TaskStatus.getTaskTitleByID(status));
    }



//    new cl_app.BubbleVisualizer(new cl.CLElement(cell), () async {
//      _res ??= await ap.serverCall(
//          RoutesLabResult.collectionGetMDD.reverse([]), {'id': id}, null);
//      final c = new DivElement();
//      _res.forEach((title) {
//        c.append(new ParagraphElement()..text = title);
//      });
//      return c;
//    });
  }
}
