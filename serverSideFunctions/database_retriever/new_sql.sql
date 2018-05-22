/*Sessions*/
CREATE TABLE session
(
    sid character varying COLLATE pg_catalog."default" NOT NULL,
    sess json NOT NULL,
    expire timestamp(6) without time zone NOT NULL,
    CONSTRAINT session_pkey PRIMARY KEY (sid)
)
WITH (
    OIDS = FALSE
);

/*User Information*/

CREATE TABLE users
(
    user_id serial,
    username character varying(20) COLLATE pg_catalog."default" NOT NULL,
    password character varying(20) COLLATE pg_catalog."default" NOT NULL,
    fname character varying(20) COLLATE pg_catalog."default" NOT NULL,
    lname character varying(20) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT users_pkey PRIMARY KEY (user_id),
    CONSTRAINT users_password_key UNIQUE (password),
    CONSTRAINT users_username_key UNIQUE (username)
)
WITH (
    OIDS = FALSE
);

CREATE TABLE user_phone
(
    user_id integer NOT NULL,
    p_index serial,
    p_number character varying(15) COLLATE pg_catalog."default",
    CONSTRAINT user_phone_pkey PRIMARY KEY (user_id, p_index),
    CONSTRAINT user_phone_user_id_fkey FOREIGN KEY (user_id)
        REFERENCES public.users (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)
WITH (
    OIDS = FALSE
);

CREATE TABLE user_address
(
    user_id integer NOT NULL,
    addr_index serial,
    address character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT user_address_pkey PRIMARY KEY (user_id, addr_index),
    CONSTRAINT user_address_user_id_fkey FOREIGN KEY (user_id)
        REFERENCES public.users (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)
WITH (
    OIDS = FALSE
);

/*Contact Information */
CREATE TABLE contacts
(
    cont_id serial,
    user_id integer NOT NULL,
    firstname character varying(20) COLLATE pg_catalog."default" NOT NULL,
    lastname character varying(20) COLLATE pg_catalog."default" NOT NULL,
    with_account boolean NOT NULL,
	acct_num integer,
    CONSTRAINT contacts_pkey PRIMARY KEY (cont_id, user_id),
    CONSTRAINT contacts_user_id_fkey FOREIGN KEY (user_id)
        REFERENCES public.users (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
);

CREATE TABLE contact_phone
(
    cont_id integer NOT NULL,
    user_id integer NOT NULL,
    p_index serial,
    p_number character varying(15) COLLATE pg_catalog."default",
    CONSTRAINT contact_phone_pkey PRIMARY KEY (cont_id, user_id, p_index),
    CONSTRAINT contact_phone_user_id_fkey FOREIGN KEY (cont_id, user_id)
        REFERENCES public.contacts (cont_id, user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)
WITH (
    OIDS = FALSE
);

CREATE TABLE contact_address
(
    cont_id integer NOT NULL,
    user_id integer NOT NULL,
    addr_index serial,
    address character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT contact_address_pkey PRIMARY KEY (cont_id, user_id, addr_index),
    CONSTRAINT contact_address_user_id_fkey FOREIGN KEY (cont_id, user_id)
        REFERENCES public.contacts (cont_id, user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)
WITH (
    OIDS = FALSE
);
/* Chat Information */

CREATE TABLE chatrooms 
(
	chatr_id serial,
	chatr_name character varying(20) NOT NULL,
	primary key (chatr_id)
	
)

CREATE TABLE chatroom_users 
(
	chatr_id integer not null,
	user_id integer not null,
	primary key (chatr_id, user_id),
	foreign key (chatr_id) references chatrooms(chatr_id),
	foreign key (user_id) references users(user_id)
)

/* Inputs for testing*/
insert into users(username, password, fname, lname) values('Thamy', 'LisiWoo', 'Thaman', 'Woo');
insert into users(username, password, fname, lname) values('poop', 'poop', 'Turd', 'Master');

insert into user_phone(user_id, p_number) values(1,'6044455286');
insert into user_phone(user_id, p_number) values(1,'6047325286');
insert into user_phone(user_id, p_number) values(2,'6341234235');

insert into user_address(user_id, address) values(1,'555 Seymour Street');
insert into user_address(user_id, address) values(1,'Scott Road Station, 110th Ave, Surrey, BC');
insert into user_address(user_id, address) values(2,'Scott Road Station, 110th Ave, Surrey, BC');

insert into contacts(user_id, firstname, lastname, with_account) values(1,'Li', 'Pho', false);
insert into contacts(user_id, firstname, lastname, with_account) values(1,'Sam', 'Pho', false);
insert into contacts(user_id, firstname, lastname, with_account, acct_num) values(1,'Turd', 'Master', true, 2);

insert into contact_phone(cont_id, user_id, p_number) values(1,1,'6044491231');
insert into contact_phone(cont_id, user_id, p_number) values(1,1,'7341230987');
insert into contact_phone(cont_id, user_id, p_number) values(2,1,'1232341232');

insert into contact_address(cont_id, user_id, address) values(1,1,'555 Seymour Street');
insert into contact_address(cont_id, user_id, address) values(2,1,'3766 E 1st Ave, Burnaby');
insert into contact_address(cont_id, user_id, address) values(2,1,'3766 E 1st Ave, Burnaby');

/*
SELECT * FROM session
SELECT * FROM users
SELECT * FROM contacts
SELECT * FROM user_phone
SELECT * FROM user_address
SELECT * FROM contact_phone
SELECT * FROM contact_address
SELECT * FROM chatrooms
SELECT * FROM chatroom_users
*/

/*
DROP TABLE session;
DROP TABLE users;
DROP TABLE contacts;
DROP TABLE user_phone;
DROP TABLE user_address;
DROP TABLE contact_phone;
DROP TABLE contact_address;
*/