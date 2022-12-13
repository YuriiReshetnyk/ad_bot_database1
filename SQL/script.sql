DROP TABLE IF EXISTS "message";
DROP TABLE IF EXISTS "admin_chat";
DROP TABLE IF EXISTS "user_chat";
DROP TABLE IF EXISTS "chat";
DROP TABLE IF EXISTS "group";
DROP TABLE IF EXISTS "admin";
DROP TABLE IF EXISTS "user";


CREATE TABLE public."chat"
(
    chat_id BIGINT PRIMARY KEY
    , title VARCHAR(50) NOT NULL
);

CREATE TABLE public."group"
(
    group_id BIGINT PRIMARY KEY
    , "name" VARCHAR(50) NOT NULL
);

CREATE TABLE public."user"
(
    user_id BIGINT PRIMARY KEY
  , is_bot BOOLEAN DEFAULT FALSE
    , username VARCHAR(50) NULL
);

CREATE TABLE public."message"
(
  message_id SERIAL PRIMARY KEY
  , message_body TEXT NOT NULL
  , is_ad BOOLEAN DEFAULT FALSE
  , send_date TIMESTAMP DEFAULT NOW()
  , sender_id INT NOT NULL
  , group_id INT NOT NULL
);

CREATE TABLE public."admin"
(
  admin_id BIGINT PRIMARY KEY
);

CREATE TABLE public."admin_chat"
(
  admin_id BIGINT
  ,chat_id BIGINT
  , PRIMARY KEY(admin_id, chat_id)
);

CREATE TABLE public."user_chat"
(
  user_id BIGINT
  ,chat_id BIGINT
  , PRIMARY KEY(user_id, chat_id)
);

ALTER TABLE public."user_chat"
   ADD CONSTRAINT fk_user_chat_user1
    FOREIGN KEY (user_id)
        REFERENCES public."user" (user_id),
    ADD CONSTRAINT fk_user_chat_chat1
    FOREIGN KEY (chat_id)
        REFERENCES public."chat" (chat_id);

ALTER TABLE public."message"
   ADD CONSTRAINT fk_message_sender1
    FOREIGN KEY (sender_id)
        REFERENCES "user" (user_id),
    ADD CONSTRAINT fk_message_chat1
    FOREIGN KEY (group_id)
        REFERENCES "group" (group_id);

ALTER TABLE public."admin_chat"
   ADD CONSTRAINT fk_admin_chat_admin1
    FOREIGN KEY (admin_id)
        REFERENCES public."admin" (admin_id),
    ADD CONSTRAINT fk_admin_chat_chat1
    FOREIGN KEY (chat_id)
        REFERENCES public."chat" (chat_id);