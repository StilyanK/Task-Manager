part of project.gui;

class FileContainer
    extends cl_gui.FileContainerBase<cl_gui.FileAttach<FileContainer>> {
  AnchorElement link;
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
    link = new AnchorElement()
      ..target = '_blank'
      ..href = '$p/$source'
      ..title = source;
    container.append(link);
    titleContainer.text = source;

    if (isImage(source)) {
      link.innerHtml = '<img src="${getImageSrc(p, source, 240, 240)}">';
    } else if (isPdf(source)) {
      final CanvasElement canvas = document.createElement('canvas');
      link.append(canvas);
      final ctx = canvas.getContext('2d');
      canvas
        ..width = 240
        ..height = 240;

      new Future(() async {
        final doc = pdfjsLib.getDocument('$p/$source');
        final d = await FutureWrap<PDFDocument>(doc.promise);
        final page = await FutureWrap<Page>(d.getPage(1));
        final v = page.getViewport(new Arguments(
            scale: canvas.width /
                page.getViewport(new Arguments(scale: 1)).width));
        final task =
            page.render(new RenderParameters(viewport: v, canvasContext: ctx));
        await FutureWrap(task.promise);
      });
    } else {
      if (isXls(source))
        link.append(new cl.Icon(cl.Icon.file_excel).dom);
      else if (isDoc(source))
        link.append(new cl.Icon(cl.Icon.file_word).dom);
      else
        link.append(new cl.Icon(cl.Icon.file_unknown).dom);
    }
  }

  bool isImage(String source) =>
      source.toLowerCase().endsWith('.jpg') ||
      source.toLowerCase().endsWith('.jpeg') ||
      source.toLowerCase().endsWith('.png') ||
      source.toLowerCase().endsWith('.svg') ||
      source.toLowerCase().endsWith('.gif');

  bool isPdf(String source) => source.toLowerCase().endsWith('.pdf');

  bool isXls(String source) =>
      source.toLowerCase().endsWith('.xls') ||
      source.toLowerCase().endsWith('.xlsx');

  bool isDoc(String source) =>
      source.toLowerCase().endsWith('.doc') ||
      source.toLowerCase().endsWith('.docx');

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
