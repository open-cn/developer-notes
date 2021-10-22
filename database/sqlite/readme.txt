
ContentValues values = new ContentValues();
db.insert("person", "null"	, values);
insert into person(null) values(null);

ContentValues values = new ContentValues();
db.insert("person", "age"	, values);
insert into person(age) values(null);

事务：一组不可分割的执行单元
SQLiteDatabase db = SQLiteDatabase.openOrCreateDatabase(File file,CursoFactory factory);
File:rom  sdcard
SharedPreferences:xml
SQLiteDatabase:文件

