part of auth.entity;

@MSerializable()
class ChatAttachment {
  int chat_attachment_id;

  int chat_message_id;

  String source;

  String name;

  ChatAttachment();

  void init(Map data) => _$ChatAttachmentFromMap(this, data);

  Map<String, dynamic> toMap() => _$ChatAttachmentToMap(this);

  Map<String, dynamic> toJson() => _$ChatAttachmentToMap(this, true);
}

class ChatAttachmentCollection<E extends ChatAttachment> extends Collection<E> {
}
