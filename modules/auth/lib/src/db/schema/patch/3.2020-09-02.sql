update chat_message set type = 0;
ALTER TABLE chat_message alter column type SET NOT NULL;