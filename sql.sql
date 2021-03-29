SELECT id, tn, title FROM `ticket` WHERE id not in (select ticket_id from ticket_flag)



CREATE TABLE temp (id BIGINT(20), tn VARCHAR(50), title VARCHAR(255), queue_id INT(11), customer_id VARCHAR(150), create_time DATETIME) ENGINE=MEMORY MAX_ROWS=500;
ALTER TABLE `temp` ADD UNIQUE(`id`);

DELIMITER $$
CREATE TRIGGER tg1 AFTER INSERT ON `ticket`
    FOR EACH ROW

BEGIN
    INSERT INTO temp (id, tn, title, queue_id, customer_id, create_time)
    values (new.id, new.tn, new.title, new.queue_id, new.customer_id, new.create_time);


END $$
DELIMITER ;