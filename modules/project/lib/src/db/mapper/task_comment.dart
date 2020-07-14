part of project.mapper;

class PatientDocumentMapper
    extends Mapper<PatientDocument, PatientDocumentCollection, App> {
  String table = e.PatientDocument.$table;
  dynamic pkey = e.$PatientDocument.doc_id;

  PatientDocumentMapper(m) : super(m);

  Future<PatientDocumentCollection> findAllByRecord(int rec_id) =>
      loadC(selectBuilder()
        ..where('${e.$PatientDocument.rec_id} = @rec')
        ..setParameter('rec', rec_id));

  Future<PatientDocument> insert(PatientDocument object) => base
          .copyFileCheck(
              '${base.path}/tmp',
              joinAll(['${base.path}/media', e.PatientRecord.$table, object.rec_id.toString()]),
              object.source)
          .then((source) {
        object.source = source;
        return super.insert(object);
      });

  Future<bool> delete(PatientDocument object) async {
    try {
      File(joinAll([
        '${base.path}/media',
        e.PatientRecord.$table,
        object.rec_id.toString(),
        object.source
      ]));
    } catch (err) {
      base.log.info('Patient document delete: $err');
    }
    return super.delete(object);
  }
}

class PatientDocument extends e.PatientDocument with Entity<App> {}

class PatientDocumentCollection
    extends e.PatientDocumentCollection<PatientDocument> {}
