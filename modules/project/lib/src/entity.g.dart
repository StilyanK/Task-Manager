// GENERATED CODE - DO NOT MODIFY BY HAND

part of project;

// **************************************************************************
// EntitySerializableGenerator
// **************************************************************************

abstract class $ApprovalStatus {
  static const String user_id = 'user_id';
  static const String record_id = 'record_id';
  static const String stamp = 'stamp';
  static const String comment = 'comment';
  static const String state = 'state';
  static const String checks = 'checks';
}

void _$ApprovalStatusFromMap(ApprovalStatus obj, Map data) => obj
  ..user_id = data[$ApprovalStatus.user_id]
  ..record_id = data[$ApprovalStatus.record_id]
  ..stamp = data[$ApprovalStatus.stamp] is String
      ? DateTime.tryParse(data[$ApprovalStatus.stamp])
      : data[$ApprovalStatus.stamp]
  ..comment = data[$ApprovalStatus.comment]
  ..state = data[$ApprovalStatus.state]
  ..checks = data[$ApprovalStatus.checks];

Map<String, dynamic> _$ApprovalStatusToMap(ApprovalStatus obj,
        [asJson = false]) =>
    <String, dynamic>{
      $ApprovalStatus.user_id: obj.user_id,
      $ApprovalStatus.record_id: obj.record_id,
      $ApprovalStatus.stamp: asJson ? obj.stamp?.toIso8601String() : obj.stamp,
      $ApprovalStatus.comment: obj.comment,
      $ApprovalStatus.state: obj.state,
      $ApprovalStatus.checks: obj.checks
    };

abstract class $Doctor {
  static const String doctor_id = 'doctor_id';
  static const String name = 'name';
  static const String com_id = 'com_id';
  static const String user_id = 'user_id';
  static const String type = 'type';
}

void _$DoctorFromMap(Doctor obj, Map data) => obj
  ..doctor_id = data[$Doctor.doctor_id]
  ..name = data[$Doctor.name]
  ..com_id = data[$Doctor.com_id]
  ..user_id = data[$Doctor.user_id]
  ..type = data[$Doctor.type];

Map<String, dynamic> _$DoctorToMap(Doctor obj, [asJson = false]) =>
    <String, dynamic>{
      $Doctor.doctor_id: obj.doctor_id,
      $Doctor.name: obj.name,
      $Doctor.com_id: obj.com_id,
      $Doctor.user_id: obj.user_id,
      $Doctor.type: obj.type
    };

abstract class $Patient {
  static const String patient_id = 'patient_id';
  static const String name = 'name';
  static const String egn = 'egn';
  static const String rzi = 'rzi';
  static const String user_id = 'user_id';
}

void _$PatientFromMap(Patient obj, Map data) => obj
  ..patient_id = data[$Patient.patient_id]
  ..name = data[$Patient.name]
  ..egn = data[$Patient.egn]
  ..rzi = data[$Patient.rzi]
  ..user_id = data[$Patient.user_id];

Map<String, dynamic> _$PatientToMap(Patient obj, [asJson = false]) =>
    <String, dynamic>{
      $Patient.patient_id: obj.patient_id,
      $Patient.name: obj.name,
      $Patient.egn: obj.egn,
      $Patient.rzi: obj.rzi,
      $Patient.user_id: obj.user_id
    };

abstract class $PatientDocument {
  static const String doc_id = 'doc_id';
  static const String rec_id = 'rec_id';
  static const String source = 'source';
  static const String comment = 'comment';
  static const String valid = 'valid';
}

void _$PatientDocumentFromMap(PatientDocument obj, Map data) => obj
  ..doc_id = data[$PatientDocument.doc_id]
  ..rec_id = data[$PatientDocument.rec_id]
  ..source = data[$PatientDocument.source]
  ..comment = data[$PatientDocument.comment]
  ..valid = data[$PatientDocument.valid];

Map<String, dynamic> _$PatientDocumentToMap(PatientDocument obj,
        [asJson = false]) =>
    <String, dynamic>{
      $PatientDocument.doc_id: obj.doc_id,
      $PatientDocument.rec_id: obj.rec_id,
      $PatientDocument.source: obj.source,
      $PatientDocument.comment: obj.comment,
      $PatientDocument.valid: obj.valid
    };

abstract class $PatientRecord {
  static const String rec_id = 'rec_id';
  static const String patient_id = 'patient_id';
  static const String status = 'status';
  static const String com_id = 'com_id';
  static const String stamp = 'stamp';
  static const String doctor_ids = 'doctor_ids';
  static const String disease_id = 'disease_id';
  static const String missing_docs = 'missing_docs';
  static const String pat_relation = 'pat_relation';
}

void _$PatientRecordFromMap(PatientRecord obj, Map data) => obj
  ..rec_id = data[$PatientRecord.rec_id]
  ..patient_id = data[$PatientRecord.patient_id]
  ..status = data[$PatientRecord.status]
  ..com_id = data[$PatientRecord.com_id]
  ..stamp = data[$PatientRecord.stamp] is String
      ? DateTime.tryParse(data[$PatientRecord.stamp])
      : data[$PatientRecord.stamp]
  ..doctor_ids = data[$PatientRecord.doctor_ids]?.cast<dynamic>()
  ..disease_id = data[$PatientRecord.disease_id]
  ..missing_docs = data[$PatientRecord.missing_docs]
  ..pat_relation = data[$PatientRecord.pat_relation];

Map<String, dynamic> _$PatientRecordToMap(PatientRecord obj,
        [asJson = false]) =>
    <String, dynamic>{
      $PatientRecord.rec_id: obj.rec_id,
      $PatientRecord.patient_id: obj.patient_id,
      $PatientRecord.status: obj.status,
      $PatientRecord.com_id: obj.com_id,
      $PatientRecord.stamp: asJson ? obj.stamp?.toIso8601String() : obj.stamp,
      $PatientRecord.doctor_ids: obj.doctor_ids == null
          ? null
          : new List.generate(
              obj.doctor_ids.length, (i0) => obj.doctor_ids[i0]),
      $PatientRecord.disease_id: obj.disease_id,
      $PatientRecord.missing_docs: obj.missing_docs,
      $PatientRecord.pat_relation: obj.pat_relation
    };

abstract class $Disease {
  static const String disease_id = 'disease_id';
  static const String name = 'name';
}

void _$DiseaseFromMap(Disease obj, Map data) => obj
  ..disease_id = data[$Disease.disease_id]
  ..name = data[$Disease.name];

Map<String, dynamic> _$DiseaseToMap(Disease obj, [asJson = false]) =>
    <String, dynamic>{
      $Disease.disease_id: obj.disease_id,
      $Disease.name: obj.name
    };

abstract class $Commission {
  static const String com_id = 'com_id';
  static const String disease_id = 'disease_id';
  static const String name = 'name';
}

void _$CommissionFromMap(Commission obj, Map data) => obj
  ..com_id = data[$Commission.com_id]
  ..disease_id = data[$Commission.disease_id]
  ..name = data[$Commission.name];

Map<String, dynamic> _$CommissionToMap(Commission obj, [asJson = false]) =>
    <String, dynamic>{
      $Commission.com_id: obj.com_id,
      $Commission.disease_id: obj.disease_id,
      $Commission.name: obj.name
    };

abstract class $DocComment {
  static const String com_id = 'com_id';
  static const String doc_id = 'doc_id';
  static const String user_id = 'user_id';
  static const String comment = 'comment';
  static const String stamp = 'stamp';
}

void _$DocCommentFromMap(DocComment obj, Map data) => obj
  ..com_id = data[$DocComment.com_id]
  ..doc_id = data[$DocComment.doc_id]
  ..user_id = data[$DocComment.user_id]
  ..comment = data[$DocComment.comment]
  ..stamp = data[$DocComment.stamp] is String
      ? DateTime.tryParse(data[$DocComment.stamp])
      : data[$DocComment.stamp];

Map<String, dynamic> _$DocCommentToMap(DocComment obj, [asJson = false]) =>
    <String, dynamic>{
      $DocComment.com_id: obj.com_id,
      $DocComment.doc_id: obj.doc_id,
      $DocComment.user_id: obj.user_id,
      $DocComment.comment: obj.comment,
      $DocComment.stamp: asJson ? obj.stamp?.toIso8601String() : obj.stamp
    };

abstract class $RecordTime {
  static const String tim_id = 'tim_id';
  static const String rec_id = 'rec_id';
  static const String user_id = 'user_id';
  static const String stamp = 'stamp';
  static const String status = 'status';
}

void _$RecordTimeFromMap(RecordTime obj, Map data) => obj
  ..tim_id = data[$RecordTime.tim_id]
  ..rec_id = data[$RecordTime.rec_id]
  ..user_id = data[$RecordTime.user_id]
  ..stamp = data[$RecordTime.stamp] is String
      ? DateTime.tryParse(data[$RecordTime.stamp])
      : data[$RecordTime.stamp]
  ..status = data[$RecordTime.status];

Map<String, dynamic> _$RecordTimeToMap(RecordTime obj, [asJson = false]) =>
    <String, dynamic>{
      $RecordTime.tim_id: obj.tim_id,
      $RecordTime.rec_id: obj.rec_id,
      $RecordTime.user_id: obj.user_id,
      $RecordTime.stamp: asJson ? obj.stamp?.toIso8601String() : obj.stamp,
      $RecordTime.status: obj.status
    };

abstract class $Motivation {
  static const String rec_id = 'rec_id';
  static const String comment = 'comment';
  static const String signs = 'signs';
}

void _$MotivationFromMap(Motivation obj, Map data) => obj
  ..rec_id = data[$Motivation.rec_id]
  ..comment = data[$Motivation.comment]
  ..signs = data[$Motivation.signs];

Map<String, dynamic> _$MotivationToMap(Motivation obj, [asJson = false]) =>
    <String, dynamic>{
      $Motivation.rec_id: obj.rec_id,
      $Motivation.comment: obj.comment,
      $Motivation.signs: obj.signs
    };
