ALTER TABLE payment
  RENAME TO payment_method;
ALTER TABLE payment_method
  RENAME COLUMN payment_id TO payment_method_id;