ALTER TABLE chat_membership
    ADD CONSTRAINT chat_membership_chat_room_id_user_id_key UNIQUE ("chat_room_id", "user_id");
ALTER TABLE chat_room
    ADD CONSTRAINT chat_room_context_key UNIQUE ("context");