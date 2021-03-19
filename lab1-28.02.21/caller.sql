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

CREATE OR REPLACE FUNCTION is_schema_exist(sch IN VARCHAR2) RETURN BOOLEAN AS
        accepted_schemas_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO accepted_schemas_count FROM dba_users WHERE username = sch;
        IF accepted_schemas_count = 0 THEN RETURN FALSE;
        ELSE RETURN TRUE;
        END IF;
    END;
/

CREATE OR REPLACE FUNCTION is_table_exist(tbl IN VARCHAR2) RETURN BOOLEAN AS
    accepted_tables_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO accepted_tables_count FROM dba_tables WHERE table_name = tbl;
    IF accepted_tables_count = 0 THEN RETURN FALSE;
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
    schema_didnt_exist_exception EXCEPTION;
    table_didnt_exist_exception EXCEPTION;
BEGIN
    IF scheme_name IS NULL THEN RAISE scheme_input_exception; END IF;
    IF table_name IS NULL THEN RAISE table_input_exception; END IF;
    IF is_schema_exist(scheme_name) = TRUE THEN
       IF is_table_exist(table_name) = TRUE THEN
           triggers_util.get_filtered(table_name, scheme_name, result_cursor);
           triggers_util.print_format(result_cursor);
        ELSE RAISE table_didnt_exist_exception;
        END IF;
    ELSE RAISE schema_didnt_exist_exception;
    END IF;
EXCEPTION
    WHEN scheme_input_exception THEN DBMS_OUTPUT.PUT_LINE('Typed schema name is empty');
    WHEN table_input_exception THEN DBMS_OUTPUT.PUT_LINE('Typed table name is empty');
    WHEN schema_didnt_exist_exception THEN DBMS_OUTPUT.PUT_LINE('Typed schema didnt exist in database');
    WHEN table_didnt_exist_exception THEN DBMS_OUTPUT.PUT_LINE('Typed table didnt exist in database');
END;
/