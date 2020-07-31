def test_first_dummy(db_cursor, db_connection):
    db_cursor.execute("insert into `dummy` (`title`) values ('Foo again')")
    db_connection.commit()

    db_cursor.execute('select * from `dummy`')
    result = db_cursor.fetchall()
    assert result == [(1, 'Foo again')]
