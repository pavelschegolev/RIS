from typing import Optional

from pymysql import connect
from pymysql.cursors import Cursor
from pymysql.connections import Connection
from pymysql.err import OperationalError, InterfaceError


class UseDatabase:

    def __init__(self, config: dict):
        self.config = config
        self.conn: Optional[Connection] = None
        self.cursor: Optional[Cursor] = None

    def __enter__(self) -> Optional[Cursor]:
        try:
            self.conn = connect(**self.config)
            self.cursor = self.conn.cursor()
            return self.cursor
        except InterfaceError as err:
            print(err)
            return err
        except OperationalError as err:
            if err.args[0] == 1045:
                print('Проверьте логин / пароль')
            elif err.args[0] == 1049:
                print('Проверьте имя базы данных')
            elif err.args[0] == 2003:
                print('Неверное имя хоста\n')
            else:
                print(err)
            return None

    def __exit__(self, exc_type, exc_val, exc_tr) -> bool:
        if self.conn and self.cursor:
            if exc_type:
                self.conn.rollback()
            else:
                self.conn.commit()
            self.conn.close()
            self.cursor.close()
        return True

