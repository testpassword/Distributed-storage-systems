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
            LOOP
                FETCH rc INTO names, triggers;
                EXIT WHEN rc%NOTFOUND;
                DBMS_OUTPUT.PUT_LINE(RPAD(names, 23) || ' ' || RPAD(triggers, 23));
            END LOOP;
        END;
END;
/

SET SERVEROUTPUT ON;
ACCEPT t CHAR PROMPT 'Type table name: '
ACCEPT s CHAR PROMPT 'Type scheme name: '
DECLARE
    result_cursor SYS_REFCURSOR;
    table_name VARCHAR2(32) := '&t';
    scheme_name VARCHAR2(32) := '&s';
BEGIN
    triggers_util.get_filtered(table_name, scheme_name, result_cursor);
    IF result_cursor%NOTFOUND THEN DBMS_OUTPUT.PUT_LINE('triggers for requested table and schema combination are did not exists');
    ELSE triggers_util.print_format(result_cursor);
    END IF;
END;
/