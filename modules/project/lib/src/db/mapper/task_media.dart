part of project.mapper;

class PatientRecordMapper
    extends Mapper<PatientRecord, PatientRecordCollection, App> {
  String table = e.PatientRecord.$table;
  dynamic pkey = e.$PatientRecord.rec_id;

  PatientRecordMapper(m) : super(m);

  CollectionBuilder<PatientRecord, PatientRecordCollection, App>
      findAllByBuilder(int doc_id) {
    final b = selectBuilder();
    if (doc_id != null)
      b.andWhere('${e.$PatientRecord.doctor_ids} @> \'$doc_id\'::jsonb');

    return collectionBuilder(b)
      ..filterRule = (new FilterRule()
        ..eq = [
          pkey,
          e.$PatientRecord.patient_id,
          e.$PatientRecord.status,
          e.$PatientRecord.disease_id
        ]
        ..date = [e.$PatientRecord.stamp]
        ..map = {
          e.PatientRecord.$patient: e.$PatientRecord.patient_id,
          e.PatientRecord.$disease: e.$PatientRecord.disease_id,
        });
  }
}

class PatientRecord extends e.PatientRecord with Entity<App> {}

class PatientRecordCollection extends e.PatientRecordCollection<PatientRecord> {
}
