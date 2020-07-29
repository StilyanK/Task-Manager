library project.gui;

import 'dart:async';

import 'package:cl/action.dart' as cl_action;
import 'package:cl/app.dart' as cl_app;
import 'package:cl/base.dart' as cl;
import 'package:cl/forms.dart' as cl_form;
import 'package:cl/gui.dart' as cl_gui;
import 'package:cl_base/client.dart' as base;
import 'package:communicator/client.dart';
import 'package:hms_auth/client.dart' as auth;
import 'package:hms_local/client.dart' as hms_local;
import 'package:icon/icon.dart' as icon;

import 'entity.dart' as entity;
import 'path.dart';

part 'gui/gadgets/task_card.dart';
part 'gui/gadgets/task_gadget.dart';
part 'gui/task.dart';
part 'gui/task_list.dart';

abstract class Icon {
  static const String Tasks = cl.Icon.message;
  static const String UserMain = icon.Icon.fingerprint;
  static const String User = cl.Icon.person;
  static const String Settings = cl.Icon.settings;
  static const String UserGroup = icon.Icon.group;

  static const String Commission = icon.Icon.briefcase_doctor;
  static const String Disease = icon.Icon.bacteria;
  static const String Doctor = icon.Icon.briefcase_doctor;
  static const String Patient = icon.Icon.hospital_sign;
  static const String PatientRecord = cl.Icon.format_list_bulleted;

  static const String DocComments = icon.Icon.writing;
}
