SELECT id, tn, title FROM `ticket` WHERE id not in (select ticket_id from ticket_flag)



CREATE TABLE temp (id BIGINT(20), tn VARCHAR(50), title VARCHAR(255), queue_id INT(11), customer_id VARCHAR(150), create_time DATETIME) ENGINE=MEMORY MAX_ROWS=500;
ALTER TABLE `temp` ADD UNIQUE(`id`);
ALTER TABLE `temp` ADD UNIQUE(`tn`);

DELIMITER $$
CREATE TRIGGER tg1 AFTER INSERT ON `ticket`
    FOR EACH ROW

BEGIN
    INSERT INTO temp (id, tn, title, queue_id, customer_id, create_time)
    values (new.id, new.tn, new.title, new.queue_id, new.customer_id, new.create_time);


END $$
DELIMITER ;
#CREATE TRIGGER tg1 AFTER INSERT ON `ticket` FOR EACH ROW BEGIN INSERT INTO temp (id, tn, title, queue_id, customer_id, create_time) values (new.id, new.tn, new.title, new.queue_id, new.customer_id, new.create_time); END
#

DELIMITER $$
CREATE TRIGGER tg2 AFTER INSERT ON `ticket`
    FOR EACH ROW

BEGIN

    IF (SELECT COUNT(*) FROM `ticket` where NEW.queue_id = 7) != 0 THEN

        INSERT INTO temp (id, tn, title, queue_id, customer_id, create_time)
        values (NEW.id, NEW.tn, NEW.title, NEW.queue_id, NEW.customer_id, NEW.create_time);

    END IF;
END $$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER tg3 AFTER INSERT ON `ticket`
    FOR EACH ROW

BEGIN

    IF ( NEW.queue_id = 7) THEN

        INSERT INTO temp (id, tn, title, queue_id, customer_id, create_time)
        values (NEW.id, NEW.tn, NEW.title, NEW.queue_id, NEW.customer_id, NEW.create_time);

    END IF;
END $$
DELIMITER ;