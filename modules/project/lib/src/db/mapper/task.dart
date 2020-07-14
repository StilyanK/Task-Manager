part of project.mapper;

class RecordTimeMapper extends Mapper<RecordTime, RecordTimeCollection, App> {
  String table = e.RecordTime.$table;
  dynamic pkey = e.$RecordTime.tim_id;

  RecordTimeMapper(m) : super(m);

  Future<RecordTimeCollection> findAllByRecord(int rec_id) =>
      loadC(selectBuilder()
        ..where('${e.$RecordTime.rec_id} = @rec')
        ..setParameter('rec', rec_id)
        ..orderBy(e.$RecordTime.stamp)
        ..addOrderBy(e.$RecordTime.user_id));
}

class RecordTime extends e.RecordTime with Entity<App> {}

class RecordTimeCollection extends e.RecordTimeCollection<RecordTime> {}
