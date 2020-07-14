part of project;

@MSerializable()
class RecordTime {
  static const String $record_time = 'doc_record_time';

  static String get $table => $record_time;
  static const String $user = 'user';

  static Duration calcTimes(List<RecordTime> rl) {
    ///Sort events chronologically
    if (rl == null || rl.isEmpty) return null;
    rl.sort((a, b) => a.stamp.millisecondsSinceEpoch
        .compareTo(b.stamp.millisecondsSinceEpoch));

    ///Wrong order?
    if (rl.first.status != PatientRecord.REQUEST) return null;
    int i = 0;
    var st = rl[0].stamp;
    var dur = const Duration();
    i++;
    while (i < rl.length) {
      ///Move start if current event is REQUEST
      if (rl[i].status == PatientRecord.REQUEST) st = rl[i].stamp;

      if (rl[i].status == PatientRecord.DECLINED ||
          rl[i].status == PatientRecord.SCRATCH) {
        ///Calculate difference if previous event was REQUEST
        if (st != null) dur += rl[i].stamp.difference(st);
        ///Remove start
        st = null;

        ///Exit here if declined
        if (rl[i].status == PatientRecord.DECLINED) return dur;
      }

      ///Calculate difference and return time elapsed
      if (rl[i].status == PatientRecord.FINALIZED) {
        if (st != null) dur += rl[i].stamp.difference(st);
        return dur;
      }

      i++;
    }

    ///Add now to last start difference if last STATUS was request
    if (st != null) dur += DateTime.now().toUtc().difference(st);
    ///Return calculated duration
    return dur;
  }

  int tim_id;
  int rec_id;
  int user_id;
  DateTime stamp;
  int status;

  RecordTime();

  void init(Map data) => _$RecordTimeFromMap(this, data);

  Map<String, dynamic> toMap() => _$RecordTimeToMap(this);

  Map<String, dynamic> toJson() => _$RecordTimeToMap(this, true);
}

class RecordTimeCollection<E extends RecordTime> extends Collection<E> {}
