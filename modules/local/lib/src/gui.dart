library hms_local.gui;

import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:cl/action.dart' as cl_action;
import 'package:cl/app.dart' as cl_app;
import 'package:cl/base.dart' as cl;
import 'package:cl/forms.dart' as cl_form;
import 'package:cl/gui.dart' as cl_gui;
import 'package:cl/utils.dart' as cl_util;
import 'package:cl_base/client.dart';
import 'package:cl_base/shared.dart' as base_shared;
import 'package:codemirror/codemirror.dart' as codemirror;
import 'package:communicator/client.dart';
import 'package:auth/client.dart' as auth;
import 'package:icon/icon.dart' as hms_icon;
import 'package:intl/intl.dart';

import '../intl/client.dart' as intl;
import 'entity.dart' as entity;
import 'path.dart';
import 'shared.dart' as shared;
import 'svc/server/timezone/src/zone.dart';

part 'gui/country.dart';

part 'gui/country_list.dart';

part 'gui/country_list_choose.dart';

part 'gui/currency.dart';

part 'gui/currency_list.dart';

part 'gui/dictionary.dart';

part 'gui/dictionary_list.dart';

part 'gui/element/card_list.dart';

part 'gui/element/check_cell.dart';

part 'gui/element/date_client.dart';

part 'gui/element/discount_button.dart';

part 'gui/element/input_country.dart';

part 'gui/element/input_drug.dart';

part 'gui/element/input_lab_unit.dart';

part 'gui/element/input_mod.dart';

part 'gui/element/input_place.dart';

part 'gui/element/input_price.dart';

part 'gui/element/input_quantity.dart';

part 'gui/element/input_timezone.dart';

part 'gui/element/input_weight.dart';

part 'gui/element/lab_unit_cell.dart';

part 'gui/element/lab_unit_editor_cell.dart';

part 'gui/element/listing_inner.dart';

part 'gui/element/price.dart';

part 'gui/element/quantity_cell.dart';

part 'gui/element/quantity_editor_cell.dart';

part 'gui/element/quantity_sumator.dart';

part 'gui/element/report_components.dart';

part 'gui/element/select_country.dart';

part 'gui/element/select_country_codes.dart';

part 'gui/element/select_currency.dart';

part 'gui/element/select_gender.dart';

part 'gui/element/select_laboratory_unit.dart';

part 'gui/element/select_language.dart';

part 'gui/element/select_month.dart';

part 'gui/element/select_payment_method.dart';

part 'gui/element/select_place.dart';

part 'gui/element/select_quantity.dart';

part 'gui/element/select_region.dart';

part 'gui/element/select_region_code.dart';

part 'gui/element/select_rhif.dart';

part 'gui/element/select_rhif_code.dart';

part 'gui/element/select_tax.dart';

part 'gui/element/select_year.dart';

part 'gui/element/select_zone.dart';

part 'gui/element/tax.dart';

part 'gui/element/wrn_cell.dart';

part 'gui/laboratory_unit.dart';

part 'gui/laboratory_unit_list.dart';

part 'gui/language.dart';

part 'gui/language_list.dart';

part 'gui/payment_method.dart';

part 'gui/payment_method_list.dart';

part 'gui/place.dart';

part 'gui/place_list.dart';

part 'gui/place_list_choose.dart';

part 'gui/quantity_unit.dart';

part 'gui/report_list.dart';

part 'gui/rhif.dart';

part 'gui/rhif_list.dart';

part 'gui/rhif_list_choose.dart';

part 'gui/tax.dart';

part 'gui/weight.dart';

part 'gui/zone.dart';

abstract class Icon {
  static const String Localization = hms_icon.Icon.language;
  static const String Country = hms_icon.Icon.public;
  static const String Zone = cl.Icon.person;
  static const String Place = hms_icon.Icon.place;
  static const String Currency = hms_icon.Icon.euro;
  static const String PaymentMethod = hms_icon.Icon.account_balance_wallet;
  static const String Tax = hms_icon.Icon.euro;
  static const String TaxClient = cl.Icon.person;
  static const String TaxProduct = cl.Icon.folder;
  static const String TaxRate = hms_icon.Icon.show_chart;
  static const String TaxRule = cl.Icon.settings;
  static const String Language = hms_icon.Icon.flag;
  static const String Dictionary = hms_icon.Icon.library_books;
  static const String Quantity = hms_icon.Icon.units;
  static const String Weight = hms_icon.Icon.weight;
  static const String Rhif = hms_icon.Icon.place;
  static const String LabUnit = hms_icon.Icon.units;
}

void initCurrencies(dynamic cr) {
  final c = new entity.CurrencyDataCollection.fromJson(cr);
  new shared.CurrencyService(c);
}

void initQuantityUnits(dynamic q) {
  final c = new entity.QuantityUnitCollection();
  q.forEach((qty) => c.add(new entity.QuantityUnit()..init(qty)));
  new shared.QuantityService(c);
}

void initWeightUnits(dynamic w) {
  final c = new entity.WeightUnitCollection();
  w.forEach((weight) => c.add(new entity.WeightUnit()..init(weight)));
  new shared.WeightService(c);
}

void initTaxes(dynamic t) {
  new shared.TaxService(
      new entity.TaxRuleCollection()..fromList(t['rule']),
      new entity.TaxClientCollection()..fromList(t['client']),
      new entity.TaxProductCollection()..fromList(t['product']),
      new entity.TaxRateCollection()..fromList(t['rate']));
}

void initLanguages(dynamic l) {
  final c = new entity.LanguageCollection();
  l.forEach((language) => c.add(new entity.Language()..init(language)));
  new shared.LanguageService(c);
}

void initPaymentMethods(dynamic l) {
  final c = new entity.PaymentMethodCollection();
  l.forEach((payment) => c.add(new entity.PaymentMethod()..init(payment)));
  new shared.PaymentMethodService(c);
}

void initLabUnits(dynamic l) {
  final c = new entity.LaboratoryUnitCollection();
  l.forEach((unit) => c.add(new entity.LaboratoryUnit()..init(unit)));
  new shared.LabUnitService(c);
}

bool validateBirthDate(DateTime date) =>
    date.difference(new DateTime.now()).inDays <= 0 &&
    date.compareTo(new DateTime(1900, 1, 1)) > 0;

bool validateDocumentCreatedDate(DateTime date) =>
    date.difference(new DateTime.now()).inDays <= 0 &&
    date.compareTo(new DateTime(1900, 1, 1)) > 0;

class EditorLayout extends cl.Container {
  cl.Container contLeft,
      contRight,
      contLeftTop,
      contLeftMiddle,
      contRightTop,
      contRightMiddle,
      contRightBottom;

  EditorLayout() : super() {
    contLeft = cl.Container()
      ..addRow(contLeftTop = cl.Container())
      ..addRow(contLeftMiddle = cl.Container()..auto = true);

    contRight = cl.Container()
      ..auto = true
      ..addRow(contRightTop = cl.Container())
      ..addRow(contRightMiddle = cl.Container()..auto = true)
      ..addRow(contRightBottom = cl.Container());

    addCol(contLeft..setStyle({'width': '30%'}));
    addSlider();
    addCol(contRight);
  }
}

class Editor extends cl_gui.FileManagerBase {
  cl_app.WinApp wapi;
  cl_app.WinMeta meta = cl_app.WinMeta()
    ..title = intl.Edit()
    ..icon = cl.Icon.code;
  EditorLayout layout;

  cl_gui.TreeBuilder tree;

  cl_action.Menu menuLeft, menuTop;

  cl_gui.Tree current;
  EditorContext current_context;

  codemirror.CodeMirror editor;

  List contexts = [];

  Editor(ap, String path)
      : super(ap, path, {
          'folder': cl.Icon.folder,
          'file.html': cl.Icon.code,
          'file.xml': cl.Icon.code,
          'file.css': cl.Icon.code,
          'file.scss': cl.Icon.code,
          'file.js': cl.Icon.code,
          'file.jpg': cl.Icon.image,
          'file.png': cl.Icon.code,
          'file.gif': cl.Icon.code
        }) {
    wapi = cl_app.WinApp(ap);
    initInterface();

    layout = EditorLayout();
    layout.contRightTop.addClass('ui-menu');
    wapi.load(meta, this);
    wapi.win.getContent().append(layout);

    initLeftMenuTop();
    initMenuTop();
    initTree(layout.contLeftMiddle, base_shared.Routes.dirListAll.reverse([]));
    layout.onLayout.listen((_) {
      if (current_context != null) current_context.focus();
    });
    wapi.render();
  }

  Future initInterface() async {
    await Future.wait([
      cl_util.Preloader().loadJSSeq([
        '${ap.baseurl}packages/codemirror/codemirror.js',
        '${ap.baseurl}packages/codemirror/addon/scroll/simplescrollbars.js'
      ]),
      cl_util.Preloader().loadCSSSeq([
        '${ap.baseurl}packages/codemirror/codemirror.css',
        '${ap.baseurl}packages/codemirror/addon/scroll/simplescrollbars.css'
      ])
    ]);
  }

  void initLeftMenuTop() {
    final uploader = cl_action.FileUploader(ap)
      ..setName('upload')
      ..setTip(intl.Upload())
      ..setState(false)
      ..setIcon(cl.Icon.file_upload);
    uploader
      ..observer.addHook(cl_action.FileUploader.hookLoaded, (files) {
        current.treeBuilder.refreshTree(current);
        return true;
      })
      ..addAction((e) => uploader.setUpload('$base/${current.node.id}'));
    menuLeft = cl_action.Menu(layout.contLeftTop)
      ..add(cl_action.Button()
        ..setName('folderadd')
        ..setTip(intl.New_folder())
        ..setState(false)
        ..addClass('light')
        ..setIcon(cl.Icon.folder)
        ..addAction(folderAdd))
      ..add(cl_action.Button()
        ..setName('fileadd')
        ..setTip(intl.New_file())
        ..setState(false)
        ..addClass('light')
        ..setIcon(cl.Icon.code)
        ..addAction((e) => window.alert('Not supported yet!')))
      ..add(cl_action.Button()
        ..setName('edit')
        ..setTip(intl.Edit())
        ..setState(false)
        ..addClass('light')
        ..setIcon(cl.Icon.edit)
        ..addAction(edit))
      ..add(cl_action.Button()
        ..setName('move')
        ..setTip(intl.Move())
        ..setState(false)
        ..addClass('light')
        ..setIcon(cl.Icon.redo)
        ..addAction(move))
      ..add(cl_action.Button()
        ..setName('delete')
        ..setTip(intl.Delete())
        ..setState(false)
        ..addClass('light')
        ..setIcon(cl.Icon.delete)
        ..addAction(delete))
      ..add(uploader);
  }

  void initMenuTop() {
    menuTop = cl_action.Menu(layout.contRightBottom);
    wapi.win.addKeyAction(cl_util.KeyAction(cl_util.KeyAction.CTRL_S, save));
    menuTop.add(cl_action.Button()
      ..setName('save')
      ..setTitle('Save')
      ..addClass('important')
      ..setState(false)
      ..setIcon(cl.Icon.save)
      ..addAction((e) => save()));
  }

  FutureOr<bool> clickedNode(cl_gui.Tree object) async {
    current = object;
    _initMenuOptions();
    if (object.node.type == 'folder') return true;
    final exists = contexts.firstWhere(
        (context) => context.path == object.node.id,
        orElse: () => null);
    if (exists != null) {
      setContext(exists);
      return true;
    }
    final node = object.node.type;
    if (node == 'file.html' ||
        node == 'file.css' ||
        node == 'file.scss' ||
        node == 'file.xml' ||
        node == 'file.js') {
      var mode = 'text';
      switch (object.node.id.split('.').last.toLowerCase()) {
        case 'html':
          mode = 'htmlmixed';
          break;
        case 'xml':
          mode = 'htmlmixed';
          break;
        case 'js':
          mode = 'javascript';
          break;
        case 'css':
          mode = 'css';
          break;
        case 'scss':
          mode = 'css';
          break;
      }
      final data = await ap.serverCall(base_shared.Routes.fileRead.reverse([]),
          {'object': object.node.id, 'base': base}, layout.contRightMiddle);
      final context =
          EditorContext(this, object.node.id, data['content'], mode);
      layout.contRightMiddle.append(context.container);
      layout.contRightTop.append(context.tab);
      contexts.add(context);
      setContext(context);
    } else if (node == 'file.jpg' || node == 'file.png' || node == 'file.gif') {
      final context = EditorContext(this, object.node.id, null, null);
      layout
        ..contRightMiddle.append(context.container)
        ..contRightTop.append(context.tab);
      contexts.add(context);
      setContext(context);
    }
    return true;
  }

  void setContext(EditorContext context) {
    contexts.forEach((context) => context
      ..tab.removeClass('active')
      ..container.hide());
    context
      ..tab.addClass('active')
      ..container.show();

    current_context = context..focus();
  }

  void removeContext(EditorContext context) {
    context..tab.remove()..container.remove();
    contexts.remove(context);
    if (contexts.isNotEmpty) setContext(contexts.last);
  }

  void _initMenuOptions() {
    menuLeft.setState('', true);
    if (current.node.type == null || current.node.type == 'folder') {
      if (current.node.type == null ||
          ['js', 'css', 'images', 'templates']
              .contains(current.node.id.split('/').last)) {
        menuLeft['edit'].setState(false);
        menuLeft['move'].setState(false);
        menuLeft['delete'].setState(false);
      } else if (current.node.type == 'folder') {
        menuLeft['edit'].setState(true);
        menuLeft['move'].setState(true);
      } else {
        menuLeft['edit'].setState(false);
        menuLeft['move'].setState(false);
      }
    } else {
      menuLeft['folderadd'].setState(false);
      menuLeft['fileadd'].setState(false);
      menuLeft['upload'].setState(false);
    }
  }

  Future save() async => null;
//      ap
//          .serverCall(
//          RoutesStore.saveFile.reverse([]),
//          {
//            'store_id': store_id,
//            'object': current_context.path,
//            'base': base,
//            'content': current_context.editor.getDoc().getValue()
//          },
//          layout.contRightMiddle)
//          .then((data) {
//        current_context.changed.text = '';
//        menuTop['save'].setState(false);
//      });
}

class EditorContext {
  Editor ed;

  String path;
  String content;
  String mode;

  cl.CLElement container, tab;
  Element changed;

  codemirror.CodeMirror editor;

  EditorContext(ed, this.path, this.content, this.mode) {
    container = cl.Container()..addClass('ui-auto')..addClass('editor-context');
    if (mode != null) {
      final Map options = {
        'theme': cl_app.getCodeMirrorTheme(ed.ap),
        'mode': mode,
        'scrollbarStyle': 'overlay',
        'lineNumbers': true,
        'autoCloseTags': true,
        'autoCloseBrackets': true
      };
      editor =
          codemirror.CodeMirror.fromElement(container.dom, options: options);
      editor.getDoc().setValue(content);
    } else {
      container.setStyle({
        'background-repeat': 'no-repeat',
        'background-image':
            'url(http://dev.${window.location.host}/images/${path.split('/').last})'
      });
    }
    tab = cl.CLElement(DivElement())
      ..addClass('editor-tab')
      ..append(SpanElement()..text = path.split('/').last)
      ..append(changed = Element.tag('em'))
      ..addAction((e) => ed.setContext(this), 'click');

    cl.CLElement(AnchorElement())
      ..append(cl.Icon(cl.Icon.clear).dom)
      ..addAction((e) {
        ed.removeContext(this);
      }, 'click')
      ..appendTo(tab);
    if (editor != null) {
      editor.onChange.listen((_) {
        changed.text = '*';
        ed.menuTop['save'].setState(true);
      });
    }
  }

  void focus() {
    if (editor != null)
      editor
        ..setSize(0, 0)
        ..setSize(container.getWidth(), container.getHeight())
        ..refresh()
        ..focus();
  }
}
