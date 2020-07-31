part of local.api;

@DTOSerializable()
class AddressDTO {
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

  AddressDTO();

  factory AddressDTO.fromAddress(Address addr) => new AddressDTO() //look
    ..street = addr.street
    ..residential_complex = addr.residential_complex
    ..number = addr.number
    ..bloc = addr.bloc
    ..entrance = addr.entrance
    ..floor = addr.floor
    ..apartment = addr.apartment
    ..place_id = addr.place_id
    ..zip = addr.zip
    ..region_id = addr.region_id
    ..city = addr.city
    ..address = addr.address
    ..state = addr.state
    ..state = addr.state
    ..country_id = addr.country_id;

  factory AddressDTO.fromMap(Map data) => _$AddressDTOFromMap(data);

  Map toMap() => _$AddressDTOToMap(this);

  Map toJson() => toMap();
}
