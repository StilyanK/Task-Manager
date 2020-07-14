part of auth.mapper;

class ChatAttachmentMapper
    extends Mapper<ChatAttachment, ChatAttachmentCollection, App> {
  String table = 'chat_attachment';

  ChatAttachmentMapper(m) : super(m);
}

class ChatAttachment extends entity.ChatAttachment with Entity<App> {}

class ChatAttachmentCollection
    extends entity.ChatAttachmentCollection<ChatAttachment> {}
