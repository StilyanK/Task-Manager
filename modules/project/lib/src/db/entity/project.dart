part of project.entity;

@MSerializable()
class Project {
  int project_id;
  String title;
  int manager_id;
  String picture;
  DateTime from;
  DateTime to;

  Project();

  List getPictureView() => [project_id, picture, title];

  void init(Map data) => _$ProjectFromMap(this, data);

  Map<String, dynamic> toJson() => _$ProjectToMap(this, true);

  Map<String, dynamic> toMap() => _$ProjectToMap(this);
}

class ProjectCollection<E extends Project> extends Collection<E> {
  List<Map> pair() =>
      map((p) => {'k': p.project_id, 'v': p.title}).toList();
}

