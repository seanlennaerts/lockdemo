-- creating the tables

CREATE TABLE home (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(20)
);

CREATE TABLE lock (
    sn VARCHAR(7) PRIMARY KEY,
    model VARCHAR(10),
    pin INT,
    locked BIT,
    home_id INT,
    FOREIGN KEY(home_id) REFERENCES home(id) ON DELETE SET NULL
);

CREATE TABLE users (
    uid INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(20)
);

CREATE TABLE access (
    user_id INT,
    lock_id VARCHAR(7),
    start_date DATE,
    end_date DATE,
    PRIMARY KEY(user_id, lock_id),
    FOREIGN KEY(user_id) REFERENCES users(uid) ON DELETE CASCADE,
    FOREIGN KEY(lock_id) REFERENCES lock(sn) ON DELETE CASCADE
);

-- inserting some rows

INSERT INTO home(name) VALUES('Demo home');
INSERT INTO home(name) VALUES('Demo hotel');

INSERT INTO lock VALUES('8Y34K38', 'Nest', 1234, 1, 1);
INSERT INTO lock VALUES('1KHL4J3', 'Nest', 1234, 1, 1);
INSERT INTO lock VALUES('A97S8DF', 'Nest', 1234, 1, 1);

INSERT INTO lock VALUES('464HJK3', 'August', 1234, 1, 2);
INSERT INTO lock VALUES('29J0785', 'August', 1234, 1, 2);
INSERT INTO lock VALUES('IFUWYE9', 'August', 1234, 1, 2);
INSERT INTO lock VALUES('234KH5D', 'August', 1234, 1, 2);
INSERT INTO lock VALUES('798FUWE', 'August', 1234, 1, 2);
INSERT INTO lock VALUES('VEW86Q8', 'August', 1234, 1, 2);

INSERT INTO users(first_name, last_name) VALUES('Sean', 'Lennaerts');
INSERT INTO users(first_name, last_name) VALUES('Jason', 'Lam');

INSERT INTO access VALUES(1, '8Y34K38', '2019-04-20', '2019-04-27');

