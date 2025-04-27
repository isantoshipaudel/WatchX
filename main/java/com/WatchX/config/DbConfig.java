package com.WatchX.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DbConfig is a configuration class for managing database connections. It
 * handles the connection to a MySQL database using JDBC.
 */
public class DbConfig {

	private static final String DB_NAME = "WatchX";
	private static final String url = "jdbc:mysql://localhost:3307/" + DB_NAME;
	private static final String USERNAME = "root";
	private static final String PASSWORD = "";

	public static Connection getDbConnection() throws SQLException, ClassNotFoundException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		return DriverManager.getConnection(url, USERNAME, PASSWORD);
	}
}