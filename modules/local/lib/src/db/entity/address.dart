part of hms_local.entity;

@MSerializable()
class Address {
  int address_id;
  String street;
  String residential_complex;
  String number;
  String bloc;
  String entrance;
  String floor;
  String apartment;
  int place_id;
  String zip;
  String region_id;
  String city;
  String address;
  String state;
  int country_id;
  String rhif_id;

  Country country;
  Place place;
  Region region;

  Address();

  void init(Map data) => _$AddressFromMap(this, data);

  Map<String, dynamic> toJson() => _$AddressToMap(this);

  Map<String, dynamic> toMap() => _$AddressToMap(this);

  Future<Country> loadCountry() async => null;

  Future<Place> loadPlace() async => null;

  Future<Region> loadRegion() async => null;

  Future<String> toStringAddress() async => null;

  String getCity() => place?.getRepresentation() ?? city ?? '';

  String getRepresentation() {
    final List<String> parts = [];
    if (country != null) parts.add(country.name);
    final city = getCity();
    if (city.isNotEmpty) parts.add(city);
    if (region != null) parts.add('област ${region.name}');
    if (residential_complex != null) parts.add('Ж.К $residential_complex');
    if (street != null && street.isNotEmpty) parts.add('ул. $street');
    if (number != null && number.isNotEmpty) parts.add('№ $number');
    if (bloc != null && bloc.isNotEmpty) parts.add('бл. $bloc');
    if (entrance != null && entrance.isNotEmpty) parts.add('вх. $entrance');
    if (floor != null && floor.isNotEmpty) parts.add('ет. $floor');
    if (apartment != null && apartment.isNotEmpty) parts.add('ап. $apartment');
    return parts.join(', ');
  }

  String getRepresentationShort() {
    final List<String> parts = [];
    final city = getCity();
    if (city.isNotEmpty) parts.add(city);
    if (region != null) parts.add('област ${region.name}');
    if (street != null && street.isNotEmpty) parts.add('ул. $street');
    if (number != null && number.isNotEmpty) parts.add('№ $number');
    if (bloc != null && bloc.isNotEmpty) parts.add('бл. $bloc');
    if (entrance != null && entrance.isNotEmpty) parts.add('вх. $entrance');
    if (floor != null && floor.isNotEmpty) parts.add('ет. $floor');
    if (apartment != null && apartment.isNotEmpty) parts.add('ап. $apartment');
    return parts.join(', ');
  }
}

class AddressCollection<E extends Address> extends Collection<E> {}
