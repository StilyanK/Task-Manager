part of project;

class AppChecks {
  static const int Ensured = 1;
  static const int Home_treat = 2;
  static const int Protocol_comply = 4;
  static const int All_docs_present = 8;
  static const int All_requirements = 16;
  static const int Scheme = 32;
  static const int Common_requirements = 64;

  static const String $Ensured = 'ensured';
  static const String $Home_treat = 'home_treat';
  static const String $Protocol_comply = 'protocol_comply';
  static const String $All_docs_present = 'all_docs_present';
  static const String $All_requirements = 'all_requirements';
  static const String $Scheme = 'scheme';
  static const String $Common_requirements = 'common_requirements';

  bool ensured;
  bool home_treat;
  bool protocol_comply;
  bool all_docs_present;
  bool all_requirements;
  bool scheme;
  bool common_requirements;

  int toInt() {
    int res = 0;
    if (ensured) res |= Ensured;
    if (home_treat) res |= Home_treat;
    if (protocol_comply) res |= Protocol_comply;
    if (all_docs_present) res |= All_docs_present;
    if (all_requirements) res |= All_requirements;
    if (scheme) res |= Scheme;
    if (common_requirements) res |= Common_requirements;
    return res;
  }

  AppChecks();
  factory AppChecks.fromInt(int inp) => AppChecks()
    ..ensured = inp & Ensured == Ensured
    ..home_treat = inp & Home_treat == Home_treat
    ..protocol_comply = inp & Protocol_comply == Protocol_comply
    ..all_docs_present = inp & All_docs_present == All_docs_present
    ..all_requirements = inp & All_requirements == All_requirements
    ..scheme = inp & Scheme == Scheme
    ..common_requirements = inp & Common_requirements == Common_requirements;
}
