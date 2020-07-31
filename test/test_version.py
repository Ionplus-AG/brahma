
def test_schema_version_is_set(db_cursor):
    db_cursor.execute('select max(version) from schema_change')
    assert db_cursor.fetchall() == [(1,)]
