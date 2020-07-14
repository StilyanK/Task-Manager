library project.gui;

import 'dart:async';
import 'dart:html';

import 'package:cl/action.dart' as action;
import 'package:cl/app.dart' as cl_app;
import 'package:cl/base.dart' as cl;

//import 'package:cl/calendar.dart' as cl_calendar;
//import 'package:cl/chat.dart' as chat;
import 'package:cl/forms.dart' as cl_form;
import 'package:cl/gui.dart' as cl_gui;

//import 'package:cl/utils.dart' as cl_util;
import 'package:protocol_auth/client.dart' as auth;
import 'package:cl_base/client.dart';
import 'package:cl_local/client.dart' as local;
import 'package:communicator/client.dart';
import 'package:pdf/pdf.dart';
import 'package:protocol_icon/icon.dart' as icon;

import '../intl/client.dart' as intl;
import '../path.dart';
import 'entity.dart' as e;
import 'path.dart';
import 'permission.dart';

part 'gui/task.dart';

part 'gui/task_list.dart';

abstract class Icon {
  static const String Calendar = cl.Icon.schedule;
  static const String UserMain = icon.Icon.fingerprint;
  static const String User = cl.Icon.person;
  static const String Settings = cl.Icon.settings;
  static const String UserGroup = icon.Icon.group;

  static const String Commission = icon.Icon.briefcase_doctor;
  static const String Disease = icon.Icon.bacteria;
  static const String Doctor = icon.Icon.briefcase_doctor;
  static const String Patient = icon.Icon.hospital_sign;
  static const String PatientRecord = cl.Icon.format_list_bulleted;

  static const String DocComments = cl.Icon.message;
}
