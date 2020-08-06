part of project.mapper;

class ProjectMapper extends Mapper<Project, ProjectCollection, App> {
  String table = 'project';
  dynamic pkey = 'project_id';

  ProjectMapper(m) : super(m);

  CollectionBuilder<Project, ProjectCollection, App> findAllByBuilder() {
    final cb = collectionBuilder(selectBuilder());
    return cb;
  }

//  Future<ProjectCollection> findByAllToDo(int user) =>
//      loadC(selectBuilder()
//        ..where('${entity.$Task.status} != @p1')
//        ..andWhere('${entity.$Task.assigned_to} = @p2')
//        ..setParameter('p1', TaskStatus.Done)
//        ..setParameter('p2', user));

  Future<ProjectCollection> findBySuggestion(String title) {
    final q = selectBuilder('project.*')
      ..where('title ILIKE @p1')
      ..setParameter('p1', '%$title%');

    return loadC(q);
  }

}

class Project extends entity.Project with Entity<App> {}

class ProjectCollection extends entity.ProjectCollection<Project> {}
