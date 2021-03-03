# уроки - http://www.firststeps.ru/sql/oracle/
`sqlplus s265570@orbis` # подключение на гелиос
`jdbc:oracle:thin:@localhost:1521:orbis` # url для внешних подключений
`SQL> @filename.sql`  # выполнить скрипт из файла
`SQL> SET SERVEROUTPUT ON` # включить отображение сообщений
`SQL> EXEC procedure_name` # выполнить процедуру
# возврат курсора из процедуры https://stackoverflow.com/questions/13517952/sys-refcursor-as-out-parameter
# печать курсора в Oracle 11g https://stackoverflow.com/questions/58156461/how-to-print-the-cursor-values-in-oracle (в новых версиях есть PRINT)
# проверка на то, что курсор пуст https://stackoverflow.com/questions/10814111/how-to-check-if-cursor-returns-any-records-in-oracle