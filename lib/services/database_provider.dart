import 'package:reminder_app/modals/importAll.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tuple/tuple.dart';

class DatabaseProvider {
  static const String _dbname = "reminder.db";
  static const int _dbver = 1;

  static const String HEALTH_TABLE = "health";
  static const String HEALTH_PRIMARY_ID = "health_id";
  static const String MEDICINE_NAME = "medicine_name";
  static const String MEDICINE_DESCRIPTION = "medicine_description";
  static const String MOR_TIME = "mor_time";
  static const String AFT_TIME = "aft_time";
  static const String NYT_TIME = "nyt_time";

  static const String WORK_TABLE = "work";
  static const String WORK_PRIMARY_ID = "work_id";
  static const String WORK_TITLE = "work_title";
  static const String WORK_DESCRIPTION = "work_description";
  static const String STR_DATE = "str_date";
  static const String STR_TIME = "str_time";
  static const String STP_DATE = "stp_date";
  static const String STP_TIME = "stp_time";
  static const String IS_STOP = "till_stop";

  static const String DATE_TABLE = "date";
  static const String DATE_PRIMARY_ID = "date_id";
  static const String DATE_TITLE = "date_title";
  static const String DATE_DESCRIPTION = "date_description";
  static const String DATE_ = "date_";
  static const String TIME_ = "time_";

  static int health_primary_key = 0;
  static int work_primary_key = 0;
  static int date_primary_key = 0;

  static int health_length = 0;
  static int work_length = 0;
  static int date_length = 0;

  DatabaseProvider();
  static final DatabaseProvider db = DatabaseProvider();

  Database _database;

  Future get database async {
    if (_database != null) {
      return _database;
    }

    _database = await createDatabase();
    return _database;
  }

  //Delete whole database

  Future deleteDatabasefile() async {
    var dbclient = await database;
    String dbPath = await getDatabasesPath();
    await dbclient.execute('DROP TABLE $HEALTH_TABLE');
    await dbclient.execute('DROP TABLE $WORK_TABLE');
    await dbclient.execute('DROP TABLE $DATE_TABLE');
    await deleteDatabase(join(dbPath, _dbname));
    print("database deleted");
  }

  //Create database

  Future createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(join(dbPath, _dbname), version: _dbver,
        onCreate: (Database database, int version) async {
      await database.execute(
          'CREATE TABLE $HEALTH_TABLE ($HEALTH_PRIMARY_ID INTEGER PRIMARY KEY, $MEDICINE_NAME TEXT, $MEDICINE_DESCRIPTION TEXT, $MOR_TIME TEXT, $AFT_TIME TEXT, $NYT_TIME TEXT)');
      print("health table created");
      await database.execute(
          'CREATE TABLE $WORK_TABLE ($WORK_PRIMARY_ID INTEGER PRIMARY KEY, $WORK_TITLE TEXT, $WORK_DESCRIPTION TEXT, $STR_DATE TEXT, $STR_TIME TEXT, $STP_DATE TEXT, $STP_TIME TEXT, $IS_STOP INTEGER)');
      print("work table created");
      await database.execute(
          'CREATE TABLE $DATE_TABLE ($DATE_PRIMARY_ID INTEGER PRIMARY KEY, $DATE_TITLE TEXT, $DATE_DESCRIPTION TEXT, $DATE_ TEXT, $TIME_ TEXT)');
      print("date table created");
    });
  }

  //Collect ID of all Table from database

  Future getId() async {
    var dbclient = await database;
    health_primary_key =
        Sqflite.firstIntValue(await dbclient.transaction((txn) async {
      var query = "SELECT COUNT(*) FROM $HEALTH_TABLE";
      return await txn.rawQuery(query);
    }));
    health_primary_key++;
    print(health_primary_key);
    work_primary_key =
        Sqflite.firstIntValue(await dbclient.transaction((txn) async {
      var query = "SELECT COUNT(*) FROM $WORK_TABLE";
      return await txn.rawQuery(query);
    }));
    work_primary_key++;
    print(work_primary_key);
    date_primary_key =
        Sqflite.firstIntValue(await dbclient.transaction((txn) async {
      var query = "SELECT COUNT(*) FROM $DATE_TABLE";
      return await txn.rawQuery(query);
    }));
    date_primary_key++;
    print(date_primary_key);
  }

  // Insert entries to table

  Future<Health> insertHealth(Health health) async {
    final dbclient = await database;
    health.health_id = await dbclient.insert(HEALTH_TABLE, health.toMap());
    print("health insert ${health.health_id}");
    return health;
  }

  Future<Work> insertWork(Work work) async {
    final dbclient = await database;
    work.work_id = await dbclient.insert(WORK_TABLE, work.toMap());
    return work;
  }

  Future<Date1> insertDate(Date1 date1) async {
    final dbclient = await database;
    date1.date_id = await dbclient.insert(DATE_TABLE, date1.toMap());
    print("date insert ${date1.date_id}");
    return date1;
  }

  //Collect data from database

  Future<Health> selectHealth(int key) async {
    final dbclient = await database;

    var healths = await dbclient
        .rawQuery('SELECT * FROM ${HEALTH_TABLE} WHERE health_id = ${key}');

    List<Health> healthlist = List<Health>();

    healths.forEach((currentHealth) {
      Health health = Health.fromMap(currentHealth);

      healthlist.add(health);
    });
    return healthlist[0];
  }

  Future<Work> selectWork(int key) async {
    final dbclient = await database;

    var works = await dbclient
        .rawQuery('SELECT * FROM ${WORK_TABLE} WHERE work_id = ${key}');

    List<Work> worklist = List<Work>();

    works.forEach((currentwork) {
      Work work = Work.fromMap(currentwork);

      worklist.add(work);
    });
    return worklist[0];
  }

  Future<Date1> selectDate(int key) async {
    final dbclient = await database;

    var dates = await dbclient
        .rawQuery('SELECT * FROM ${DATE_TABLE} WHERE date_id = ${key}');

    List<Date1> datelist = List<Date1>();

    dates.forEach((currentDate) {
      Date1 date = Date1.fromMap(currentDate);

      datelist.add(date);
    });
    return datelist[0];
  }

  Future<List<Health>> getHealth() async {
    final dbclient = await database;

    var healths = await dbclient.query(HEALTH_TABLE, columns: [
      HEALTH_PRIMARY_ID,
      MEDICINE_NAME,
      MEDICINE_DESCRIPTION,
      MOR_TIME,
      AFT_TIME,
      NYT_TIME
    ]);

    List<Health> healthlist = List<Health>();

    healths.forEach((currentHealth) {
      Health health = Health.fromMap(currentHealth);

      healthlist.add(health);
    });

    health_length = healthlist.length;

    return healthlist;
  }

  getHealthlength() {
    getHealth();
    return health_length;
  }

  Future<List<Work>> getWork() async {
    final dbclient = await database;

    var works = await dbclient.query(WORK_TABLE, columns: [
      WORK_PRIMARY_ID,
      WORK_TITLE,
      WORK_DESCRIPTION,
      STR_DATE,
      STR_TIME,
      STP_DATE,
      STP_TIME,
      IS_STOP
    ]);

    List<Work> worklist = List<Work>();

    works.forEach((currentWork) {
      Work work = Work.fromMap(currentWork);

      worklist.add(work);
    });

    work_length = worklist.length;

    return worklist;
  }

  getWorklength() {
    getWork();
    return work_length;
  }

  Future<List<Date1>> getDate() async {
    final dbclient = await database;

    var dates = await dbclient.query(DATE_TABLE,
        columns: [DATE_PRIMARY_ID, DATE_TITLE, DATE_DESCRIPTION, DATE_, TIME_]);

    List<Date1> datelist = List<Date1>();

    dates.forEach((currentDate) {
      Date1 date1 = Date1.fromMap(currentDate);

      datelist.add(date1);
    });

    date_length = datelist.length;

    return datelist;
  }

  getDatelength() {
    getDate();
    return date_length;
  }

  //Delete entry from database

  Future<int> deleteHealth(int health_id) async {
    final dbclient = await database;

    return await dbclient.delete(
      HEALTH_TABLE,
      where: "health_id = ?",
      whereArgs: [health_id],
    );
  }

  Future<int> deleteWork(int work_id) async {
    final dbclient = await database;

    return await dbclient.delete(
      WORK_TABLE,
      where: "work_id = ?",
      whereArgs: [work_id],
    );
  }

  Future<int> deleteDate(int date_id) async {
    final dbclient = await database;

    return await dbclient.delete(
      DATE_TABLE,
      where: "date_id = ?",
      whereArgs: [date_id],
    );
  }

  //update entries from database

  Future<int> updateHealth(Health health) async {
    final dbclient = await database;

    return await dbclient.update(
      HEALTH_TABLE,
      health.toMap(),
      where: "health_id = ?",
      whereArgs: [health.health_id],
    );
  }

  Future<int> updateWork(Work work) async {
    final dbclient = await database;

    return await dbclient.update(
      WORK_TABLE,
      work.toMap(),
      where: "work_id = ?",
      whereArgs: [work.work_id],
    );
  }

  Future<int> updateDate(Date1 date1) async {
    final dbclient = await database;

    return await dbclient.update(
      DATE_TABLE,
      date1.toMap(),
      where: "date_id = ?",
      whereArgs: [date1.date_id],
    );
  }

  //
  // Future insertHealth({
  //   String medicine_name,
  //   String mor_time,
  //   String aft_time,
  //   String nyt_time,
  // }) async {
  //   var dbclient = await database;
  //   await dbclient.transaction((txn) async{
  //   var query = 'INSERT INTO $HEALTH_TABLE ($HEALTH_PRIMARY_ID, $MEDICINE_NAME,$MEDICINE_DESCRIPTION, $MOR_TIME, $AFT_TIME, $NYT_TIME) VALUES($health_primary_key, "${medicine_name}", "${mor_time}", "${aft_time}", "${nyt_time}")';
  //   await txn.rawInsert(query);
  //   });
  // }
  //
  // Future insertWork({
  //   String work_title,
  //   String str_date,
  //   String str_time,
  //   String stp_date,
  //   String stp_time,
  //   int is_stop,
  // }) async {
  //   var dbclient = await database;
  //   await dbclient.transaction((txn) async {
  //     var query = 'INSERT INTO $WORK_TABLE($WORK_PRIMARY_ID, $WORK_TITLE, $STR_DATE, $STR_TIME, $STP_DATE, $STP_TIME, $IS_STOP) VALUES($work_primary_key, "${work_title}", "${str_date}", "${str_time}", "${stp_date}", "${stp_time}", $is_stop)';
  //     await txn.rawInsert(query);
  //   });
  // }
  //
  // Future insertDate({
  //   String date_title,
  //   String date_,
  //   String time_,
  // }) async {
  //   var dbclient = await database;
  //   await dbclient.transaction((txn) async{
  //     var query = 'INSERT INTO $DATE_TABLE($DATE_PRIMARY_ID, $DATE_TITLE, $DATE_, $TIME_) VALUES ($date_primary_key, "${date_title}", "${date_}", "${time_}")';
  //     await txn.rawInsert(query);
  //   });
  // }
  //
  // Future deleteEntry({String TABLE_NAME, String id_name, int id}) async {
  //   var dbclient = await database;
  //   await dbclient.transaction((txn) async{
  //     var query = 'DELETE FROM ${TABLE_NAME} WHERE ${id_name} = $id';
  //     await txn.rawDelete(query);
  //   });
  // }

  Future displayDatabase() async {
    var dbclient = await database;

    var res1 = await dbclient.transaction((txn) async {
      var query = "SELECT * FROM $HEALTH_TABLE";
      return await txn.rawQuery(query);
    });
    var res2 = await dbclient.transaction((txn) async {
      var query = "SELECT * FROM $WORK_TABLE";
      return await txn.rawQuery(query);
    });
    var res3 = await dbclient.transaction((txn) async {
      var query = "SELECT * FROM $DATE_TABLE";
      return await txn.rawQuery(query);
    });
    print(res1);
    print(res2);
    print(res3);
  }
}
