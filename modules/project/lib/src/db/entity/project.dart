part of project.entity;

@MSerializable()
class Project {
  int project_id;
  String title;
  DateTime from;
  DateTime to;

  Project();

  void init(Map data) => _$ProjectFromMap(this, data);

  Map<String, dynamic> toJson() => _$ProjectToMap(this, true);

  Map<String, dynamic> toMap() => _$ProjectToMap(this);
}

class ProjectCollection<E extends Project> extends Collection<E> {
  List<Map> pair() =>
      map((p) => {'k': p.project_id, 'v': p.title}).toList();
}

