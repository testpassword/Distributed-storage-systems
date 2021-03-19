CREATE OR REPLACE PACKAGE triggers_util AS
    PROCEDURE get_filtered(tbl_name IN VARCHAR2, scheme_name IN VARCHAR2, trg_cursor OUT SYS_REFCURSOR);
    PROCEDURE print_format(rc IN SYS_REFCURSOR);
END;
/

CREATE OR REPLACE PACKAGE BODY triggers_util AS
    -- получить курсор с именами колонок и назначенных на них триггеров для запрошенного сочетания таблицы и схемы
    PROCEDURE get_filtered(tbl_name IN VARCHAR2, scheme_name IN VARCHAR2, trg_cursor OUT SYS_REFCURSOR) AS
    BEGIN
        OPEN trg_cursor FOR
            SELECT column_name, trigger_name FROM dba_trigger_cols
            WHERE table_name LIKE tbl_name AND
                  trigger_owner LIKE scheme_name AND
                  table_owner LIKE scheme_name;
    END;

    -- вывести курсор с колонками и триггерами
    PROCEDURE print_format(rc IN SYS_REFCURSOR) AS
        names VARCHAR2(32);
        triggers VARCHAR2(32);
        BEGIN
            DBMS_OUTPUT.PUT_LINE(RPAD('COLUMN NAME', 23) || ' ' || RPAD('TRIGGER NAME', 23));
            DBMS_OUTPUT.PUT_LINE(RPAD('-', 23, '-') || ' ' || RPAD('-', 23, '-'));
            FETCH rc INTO names, triggers;
            IF rc%FOUND THEN
                LOOP
                    FETCH rc INTO names, triggers;
                    EXIT WHEN rc%NOTFOUND;
                    DBMS_OUTPUT.PUT_LINE(RPAD(names, 23) || ' ' || RPAD(triggers, 23));
                END LOOP;
            ELSE DBMS_OUTPUT.PUT_LINE('triggers for requested table and schema combination are did not exists');
            END IF;
        END;
END;
/

-- проверить, что искомый объект существует в базе данных
CREATE OR REPLACE FUNCTION is_exist(where_ IN VARCHAR2, what_ IN VARCHAR2, field_ IN VARCHAR2) RETURN BOOLEAN AS
    accepted_results NUMBER;
BEGIN
    EXECUTE IMMEDIATE 'SELECT COUNT(*) FROM ' || where_ ||
                      ' WHERE ' || field_ || q'[ = ']' || what_ || q'[']'
        INTO accepted_results;
    IF accepted_results = 0 THEN RETURN FALSE;
    ELSE RETURN TRUE;
    END IF;
END;
/

SET SERVEROUTPUT ON;
SET FEEDBACK OFF;
SET VERIFY OFF;
ACCEPT s CHAR PROMPT 'Type scheme name: '
ACCEPT t CHAR PROMPT 'Type table name: '
DECLARE
    result_cursor SYS_REFCURSOR;
    scheme_name VARCHAR2(32) := '&s';
    table_name VARCHAR2(32) := '&t';
    scheme_input_exception EXCEPTION;
    table_input_exception EXCEPTION;
BEGIN
    IF scheme_name IS NULL THEN RAISE scheme_input_exception; END IF;
    IF table_name IS NULL THEN RAISE table_input_exception; END IF;
    IF is_exist('dba_users', scheme_name, 'username') = TRUE THEN
       IF is_exist('dba_tables', table_name, 'table_name') = TRUE THEN
           triggers_util.get_filtered(table_name, scheme_name, result_cursor);
           triggers_util.print_format(result_cursor);
        ELSE DBMS_OUTPUT.PUT_LINE('Typed table didnt exist in database');
        END IF;
    ELSE DBMS_OUTPUT.PUT_LINE('Typed schema didnt exist in database');
    END IF;
EXCEPTION
    WHEN scheme_input_exception THEN DBMS_OUTPUT.PUT_LINE('Typed schema name is empty');
    WHEN table_input_exception THEN DBMS_OUTPUT.PUT_LINE('Typed table name is empty');
END;
/

SHOW ERRORS;