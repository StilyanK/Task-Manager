part of project.gui;

class ProjectCell extends cl_form.RowDataCell<List> {
  cl_app.Application ap;

  ProjectCell(this.ap, grid, row, cell, object)
      : super(grid, row, cell, object);

  void render() {
    if (object != null) {
      final key = object[0];
      final picture = object[1];
      final title = object[2];
      if (picture != null) {
        final r = cl_gui.ImageContainer(
            null, null, () => '${ap.baseurl}media/image50x50/project/$key')
          ..addClass('small round')
          ..setValue(picture);
        cell
          ..title = title
          ..append(r.dom);
      } else {
        cell.append(new SpanElement()
          ..classes.add('project-profile')
          ..title = title
          ..text = title.substring(0, 1));
      }
    }
  }
}
