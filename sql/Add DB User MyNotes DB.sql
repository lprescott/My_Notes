USE MYNOTES;

#Create a user with access to DB
CREATE USER 'eclipse'@'localhost' IDENTIFIED BY 'csi2019';
GRANT ALL PRIVILEGES ON MYNOTES.* TO 'eclipse'@'localhost';
