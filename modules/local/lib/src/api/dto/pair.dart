part of local.api;

@DTOSerializable()
class PairDTO {
  int k;
  String v;

  PairDTO();

  factory PairDTO.fromMap(data) => _$PairDTOFromMap(data);

  Map toMap() => _$PairDTOToMap(this);
}
