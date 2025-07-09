import 'package:mysql_client/mysql_client.dart';

class DatabaseService {
  static Future<MySQLConnection> connect() async {
    try {
      var conn = await MySQLConnection.createConnection(
        host: "192.168.1.13",
        port: 3306,
        userName: "root",
        password: "123456",
        databaseName: "posta",
        secure: true,
      );

      await conn.connect();
      return conn;
    } catch (e) {
      return Future.error("Error connecting to the database: $e");
    }
  }
}
