part of project;

@MSerializable()
class PatientRecord {
  static const String $pat_record = 'doc_patient_record';
  static String get $table => $pat_record;
  static const String $doctor = 'doc';
  static const String $patient = 'pat';
  static const String $commission = 'com';
  static const String $documents = 'docs';
  static const String $apps = 'apps';
  static const String $rechecks = 'rechecks';
  static const String $denys = 'denys';
  static const String $timings = 'timings';
  static const String $doctors = 'doctors';
  static const String $disease = 'disease';

  static const String $patient_check = 'patient_checked';
  static const String $audit_check = 'audit_checked';
  static const String $commission_check = 'commission_checked';
  static const String $make_decision = 'make_decision';
  static const String $make_decision_false = 'make_decision_false';

  static const int DECLINED = -1;
  static const int SCRATCH = 0;
  static const int REQUEST = 1;
  static const int PROCESSING = 2;
  static const int VALIDATED = 3;
  static const int FINALIZED = 4;

  static String decodeStatus(int st) =>
      (st == DECLINED) ? 'Отказан' :
      (st == SCRATCH) ? 'Чернова' :
      (st == REQUEST) ? 'Молба' :
      (st == PROCESSING) ? 'В обработка' :
      (st == VALIDATED) ? 'Валидиран' :
      (st == FINALIZED) ? 'Завършен' : '';

  static const int PATIENT = 0;
  static const int PARENT = 1;
  static const int GUARDIAN = 2;
  static const int TRUSTEE = 3;
  static const int RESPONSIBLE = 4;
  static const int SOCIAL_HELP = 5;

  static String decodeRelation(int rel) =>
      (rel == PATIENT) ? 'Пациент' :
      (rel == PARENT) ? 'Родител' :
      (rel == GUARDIAN) ? 'Настойник' :
      (rel == TRUSTEE) ? 'Попечител' :
      (rel == RESPONSIBLE) ? 'Отговорно лице' :
      (rel == SOCIAL_HELP) ? 'Социално подпомагане' : '';

  int rec_id;
  int patient_id;
  int status;
  int com_id;
  DateTime stamp;
  List doctor_ids;
  int disease_id;

  bool missing_docs;
  int pat_relation;

  PatientRecord();

  void init(Map data) => _$PatientRecordFromMap(this, data);

  Map<String, dynamic> toMap() => _$PatientRecordToMap(this);

  Map<String, dynamic> toJson() => _$PatientRecordToMap(this, true);
}

class PatientRecordCollection<E extends PatientRecord> extends Collection<E> {
}
