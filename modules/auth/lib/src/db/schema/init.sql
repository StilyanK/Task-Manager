--ALTER TABLE "user" ADD CONSTRAINT user_uin_fkey FOREIGN KEY (uin) REFERENCES doctor (uin) MATCH SIMPLE ON DELETE SET NULL;

ALTER TABLE "user_notification" ADD CONSTRAINT user_notification_notification_id_fkey FOREIGN KEY (notification_id) REFERENCES base_notification (notification_id) MATCH SIMPLE ON DELETE RESTRICT;