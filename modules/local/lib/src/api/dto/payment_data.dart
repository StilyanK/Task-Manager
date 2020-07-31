part of hms_local.api;

@DTOSerializable()
class PaymentDataDTO {
  int id;
  String key;
  String title;

  PaymentDataDTO();

  factory PaymentDataDTO.fromMap(Map data) => _$PaymentDataDTOFromMap(data);

  Map toMap() => _$PaymentDataDTOToMap(this);
}
