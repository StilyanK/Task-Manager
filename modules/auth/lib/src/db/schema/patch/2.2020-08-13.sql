ALTER TABLE "user_notification" DROP CONSTRAINT user_notification_notification_id_fkey;
ALTER TABLE "user_notification" ADD CONSTRAINT user_notification_notification_id_fkey FOREIGN KEY (notification_id) REFERENCES base_notification (notification_id) MATCH SIMPLE ON DELETE CASCADE;
delete from user_notification where notification_id IS NUll;
ALTER TABLE user_notification alter column notification_id SET NOT NULL;
CREATE INDEX ON "user_notification" ("user_id");