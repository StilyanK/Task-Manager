part of local.mapper;

class AddressMapper extends Mapper<Address, AddressCollection, App> {
  String table = 'address';

  AddressMapper(m) : super(m);

  CollectionBuilder<Address, AddressCollection, App> findAllByBuilder() {
    final cb = collectionBuilder()
      ..filterRule = (new FilterRule()
        ..eq = ['address_id']
        ..llike = ['address']);
    return cb;
  }
}

class Address extends entity.Address with Entity<App> {
  Future<Country> loadCountry() async =>
      country = await manager.app.country.find(country_id);

  Future<Place> loadPlace() async =>
      place = await manager.app.place.find(place_id);

  Future<Region> loadRegion() async =>
      region = await manager.app.region.find(region_id);

  Future<String> toStringAddress() async {
    final buffer = new StringBuffer();

    //place/street/no/residential_complex/bloc/entrance/floor/apartment
    await loadPlace();
    buffer.write('${place.name} Ул. ${street ?? ''} No ${number ?? ''} '
        'Ж.к. ${residential_complex ?? ''} бл. ${bloc ?? ''} ет. ${floor ?? ''}'
        'ап. ${apartment ?? ''}');


    return buffer.toString();
  }
}

class AddressCollection extends entity.AddressCollection<Address> {}
