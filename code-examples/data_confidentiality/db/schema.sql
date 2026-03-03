CREATE TABLE employees (
  username TEXT PRIMARY KEY,
  password_hash TEXT,
  encrypted_ni_number BLOB,
  encryption_iv BLOB,
  encryption_tag BLOB
);
