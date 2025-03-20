CREATE OR REPLACE FUNCTION update_total_amount()
RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'INSERT' OR TG_OP = 'UPDATE') THEN
        UPDATE Orders
        SET total_amount = (
            SELECT COALESCE(SUM(quantity * price), 0)
            FROM OrderDetails
            WHERE order_id = NEW.order_id
        )
        WHERE order_id = NEW.order_id;
    ELSIF (TG_OP = 'DELETE') THEN
        UPDATE Orders
        SET total_amount = (
            SELECT COALESCE(SUM(quantity * price), 0)
            FROM OrderDetails
            WHERE order_id = OLD.order_id
        )
        WHERE order_id = OLD.order_id;
    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER order_total_trigger
AFTER INSERT OR UPDATE OR DELETE ON OrderDetails
FOR EACH ROW
EXECUTE FUNCTION update_total_amount();