abstract class Group {
  static const String Document = 'document';
  static const String Task = 'document';
}

abstract class Scope {
  static const String Doctor = 'doctor';
  static const String Patient = 'patient';
  static const String PatientRecord = 'patient_record';
  static const String Commission = 'commission';
  static const String Disease = 'disease';
  static const String Task = 'task';
}

abstract class Right {
  static const String document_check = 'doc_check';
  static const String commission_check = 'commission_check';
  static const String file_comment = 'file_comment';
  static const String make_decision = 'make_decision';
  static const String see_all = 'see_all';
}
