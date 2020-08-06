part of project.gui;

class FileContainer
    extends cl_gui.FileContainerBase<cl_gui.FileAttach<FileContainer>> {
  cl.CLElement<AnchorElement> link;
  DivElement container;
  SpanElement titleContainer;
  cl_action.Button del;

  FileContainer(parent) : super(parent) {
    addClass('file-cont');

    container = new DivElement()..className = 'content';
    dom.append(container);

    final contBottom = new DivElement()
      ..className = 'action'
      ..append(titleContainer = new SpanElement()..className = 'title');
    del = new cl_action.Button()
      ..setIcon(cl.Icon.delete)
      ..addAction((e) => onDelete());
    contBottom.append(del.dom);
    dom.append(contBottom);
  }

  void setData(dynamic path, Map data) {
    this.data = data;
    final p = path is Function ? path() : path;
    final source = data['source'];
    if (isImage(source)) {
      final img = new DivElement()
        ..innerHtml = '<a href="$p/$source" target="_blank">'
            '<img src="${getImageSrc(p, source, 250, 250)}"></a>';
      container.append(img);
      titleContainer.text = source;
      //} else if (isPdf(source)) {
      //TODO
    } else {
      final row = new DivElement();
      link = new cl.CLElement<AnchorElement>(new AnchorElement())
        ..appendTo(row);
      link.dom.target = '_blank';
      container.append(row);
      link.dom.href = '$p/$source';
      link.dom.title = source;
      link.dom.text = source;
    }

    // '<a href="$p/${data['source']}" target="_blank">
    // <img src="${getImageSrc(p, data['source'], 150, 150)}"></a>';
  }

  bool isImage(String source) =>
      source.toLowerCase().endsWith('.jpg') ||
      source.toLowerCase().endsWith('.jpeg') ||
      source.toLowerCase().endsWith('.png') ||
      source.toLowerCase().endsWith('.gif');

  bool isPdf(String source) => source.toLowerCase().endsWith('.pdf');

  String getImageSrc(dynamic base_path, dynamic image, int width, int height) =>
      '$base_path/${Uri.encodeComponent(image)}'
          .replaceFirst('tmp/', 'tmp/image${width}x$height/')
          .replaceFirst('media/', 'media/image${width}x$height/');

  void disable() {
    setState(false);
    del.setState(false);
  }

  void enable() {
    setState(true);
    del.setState(true);
  }

  void onDelete() {
    if (dataState == 1) {
      dataState = 0;
    } else {
      dataState = 3;
      parent.contrValue.add(parent);
    }
    remove();
  }
}

/*
    final fileuploader = new cl_action.FileUploader(ap)
      ..setTitle(intl.Attach_file())
      ..setIcon(cl.Icon.attach_file);

    final fu = new cl_gui.FileAttach<FileContainer>(
        fileuploader,
        () => '${ap.baseurl}tmp',
        () => '${ap.baseurl}media/product/${getId()}',
        (p) => new FileContainer(p))
      ..setName('files');
    formElement.addRow(fileuploader, [fu]);
 */
