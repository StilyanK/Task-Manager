library project.mapper;

import 'dart:async';
import 'dart:io';

import 'package:cl_base/server.dart' as base;
import 'package:protocol_auth/server.dart' as auth;
import 'package:mapper/mapper.dart';
import 'package:path/path.dart';

import 'entity.dart' as e;

part 'db/mapper/task.dart';
part 'db/mapper/task_comment.dart';
part 'db/mapper/task_media.dart';

mixin AppMixin {
  Manager m;

  DoctorMapper get doctor => DoctorMapper(m.convert(App()))
    ..entity = (() => Doctor())
    ..collection = (() => DoctorCollection());

  PatientMapper get patient => PatientMapper(m.convert(App()))
    ..entity = (() => Patient())
    ..collection = (() => PatientCollection());

  PatientRecordMapper get patient_record =>
      PatientRecordMapper(m.convert(App()))
        ..entity = (() => PatientRecord())
        ..collection = (() => PatientRecordCollection());

  PatientDocumentMapper get patient_document =>
      PatientDocumentMapper(m.convert(App()))
        ..entity = (() => PatientDocument())
        ..collection = (() => PatientDocumentCollection());

  ApprovalStatusMapper get approval_status =>
      ApprovalStatusMapper(m.convert(App()))
        ..entity = (() => ApprovalStatus())
        ..collection = (() => ApprovalStatusCollection());

  DiseaseMapper get disease => DiseaseMapper(m.convert(App()))
    ..entity = (() => Disease())
    ..collection = (() => DiseaseCollection());

  CommissionMapper get commission => CommissionMapper(m.convert(App()))
    ..entity = (() => Commission())
    ..collection = (() => CommissionCollection());

  DocCommentMapper get doc_comment => DocCommentMapper(m.convert(App()))
    ..entity = (() => DocComment())
    ..collection = (() => DocCommentCollection());

  RecordTimeMapper get record_time => RecordTimeMapper(m.convert(App()))
    ..entity = (() => RecordTime())
    ..collection = () => RecordTimeCollection();

  MotivationMapper get motivation => MotivationMapper(m.convert(App()))
    ..entity = (() => Motivation())
    ..collection = () => MotivationCollection();
}

class App extends Application with AppMixin, base.AppMixin, auth.AppMixin {}
