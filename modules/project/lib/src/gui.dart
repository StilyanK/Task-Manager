library project.gui;

import 'dart:async';
import 'dart:html';

import 'package:pdf/pdf.dart';
import 'package:auth/client.dart' as auth;
import 'package:cl/action.dart' as cl_action;
import 'package:cl/app.dart' as cl_app;
import 'package:cl/base.dart' as cl;
import 'package:cl/chart.dart' as cl_chart;
import 'package:cl/chat.dart' as chat;
import 'package:cl/forms.dart' as cl_form;
import 'package:cl/gui.dart' as cl_gui;
import 'package:cl_base/client.dart' as base;
import 'package:communicator/client.dart';
import 'package:icon/icon.dart' as icon;
import 'package:local/client.dart' as local;

import '../intl/client.dart' as intl;
import 'entity.dart' as entity;
import 'path.dart';
import 'shared.dart';

part 'gui/element/comments_cell.dart';
part 'gui/element/deadline_days.dart';
part 'gui/element/description_ceil.dart';
part 'gui/element/document_stamp.dart';
part 'gui/element/done_days.dart';
part 'gui/element/file_container.dart';
part 'gui/element/input_project.dart';
part 'gui/element/multi_select_priority.dart';
part 'gui/element/multi_select_status.dart';
part 'gui/element/multi_select_user.dart';
part 'gui/element/priority_cell.dart';
part 'gui/element/progress.dart';
part 'gui/element/project_cell.dart';
part 'gui/element/project_select.dart';
part 'gui/element/select_task_priority.dart';
part 'gui/element/select_task_status.dart';
part 'gui/element/select_user.dart';
part 'gui/element/status_cell.dart';
part 'gui/element/task_status_cell.dart';
part 'gui/gadgets/task_card.dart';
part 'gui/gadgets/task_gadget.dart';
part 'gui/project.dart';
part 'gui/project_list.dart';
part 'gui/task.dart';
part 'gui/task_list.dart';

abstract class Icon {
  static const String Task = cl.Icon.message;
  static const String Tasks = cl.Icon.message;
  static const String UserMain = icon.Icon.fingerprint;
  static const String User = cl.Icon.person;
  static const String Settings = cl.Icon.settings;
  static const String UserGroup = icon.Icon.group;
  static const String Project = Icon.DocComments;
  static const String ProjectList = Icon.DocComments;

  static const String Commission = icon.Icon.briefcase_doctor;
  static const String Disease = icon.Icon.bacteria;
  static const String Doctor = icon.Icon.briefcase_doctor;
  static const String Patient = icon.Icon.hospital_sign;
  static const String PatientRecord = cl.Icon.format_list_bulleted;

  static const String DocComments = icon.Icon.writing;
}

String removeHtmlTags(String htmlString) {
  final formattedString = htmlString.replaceAll(new RegExp(r'<[^>]*>'), '');
  return formattedString;
}

String getShortText(String text, [int maxLen = 50]) {
  String shortText = '';
  if (text == null) return shortText;
  if (text.length > maxLen) {
    shortText = '${text.substring(0, maxLen)}...';
  } else {
    shortText = text;
  }
  return shortText;
}
