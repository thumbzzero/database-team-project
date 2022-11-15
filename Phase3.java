package DBjaja;

import java.io.IOException;
import java.nio.file.Paths;
// import JDBC package
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Scanner;

public class Phase3 {
	public static final String URL = "jdbc:oracle:thin:@localhost:1521:orcl";
	public static final String USER_UNIVERSITY = "university";
	public static final String USER_PASSWD = "comp322";

	public static void main(String[] args) {
		Connection conn = null; // Connection object
		Statement stmt = null; // Statement object
		String sql = ""; // an SQL statement
		try {
			// Load a JDBC driver for Oracle DBMS
			Class.forName("oracle.jdbc.driver.OracleDriver");
			// Get a Connection object
			System.out.println("Success!");
		} catch (ClassNotFoundException e) {
			System.err.println("error = " + e.getMessage());
			System.exit(1);
		}

		// Make a connection
		try {
			conn = DriverManager.getConnection(URL, USER_UNIVERSITY, USER_PASSWD);
			System.out.println("Connected.");
		} catch (SQLException ex) {
			ex.printStackTrace();
			System.err.println("Cannot get a connection: " + ex.getLocalizedMessage());
			System.err.println("Cannot get a connection: " + ex.getMessage());
			System.exit(1);
		}
		ArrayList<String> tableName = new ArrayList<>(Arrays.asList("USERS", "DIARY", "ATTACHED_FILE", "DAY_RECORD",
				"CALENDAR", "QUESTION", "VOTE", "ITEM", "PARTICIPATE", "ANSWER", "PICK"));
		// 저장된 db가 있다면 아래의 try는 주석처리해도 됨 Execute an SQL statement for CREATE TABLE
		try {
			conn.setAutoCommit(false); // auto-commit disabled
			// Create a statement object
			stmt = conn.createStatement();
			// Let's execute an SQL statement.
			int res = 0;
			for (String tn : tableName) {
				sql = "DROP TABLE " + tn + " CASCADE CONSTRAINT";
				try {
					 res = stmt.executeUpdate(sql);
				} catch (Exception ex) {
					System.out.println(ex.getMessage());
				}
			}
			if (res == 0)
				System.out.println("Table was successfully dropped.");

			StringBuffer sb = new StringBuffer();
			Scanner input = new Scanner(Paths.get("C:\\Users\\hyejj\\eclipse-workspace\\labs\\bin\\DBjaja\\create.txt"));
			sql = "";
			while (input.hasNext()) {
				String str = input.nextLine();
				if(str.toUpperCase().contains("ALTER")){
					sql=str.substring(0,str.length()-1);
					stmt.addBatch(sql);
				}
				else if (str.contains(";")) {
					sql += ")";
					res = stmt.executeUpdate(sql); 
					if(res == 0) 
						System.out.println("Table was successfully created.");
					sql = "";
				}
				else {
					sql += str;
				}
			}
			try {
				int[] count = stmt.executeBatch();
				System.out.println("create table 완료!");
				// Make the changes permanent
				conn.commit();
			} catch (SQLException ex3) {
				System.err.println("sql error = " + ex3.getMessage());
				System.exit(1);
			}

		} catch (SQLException | IOException ex2) {
			System.err.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}

		
		
		
		/*
		// Execute an SQL statement for INSERT
		try {
			// Let's execute an SQL statement.
			sql = "INSERT INTO TEST VALUES (40, 'Ryu', 'Los Angeles')";
			// Add above SQL statement in the batch.
			stmt.addBatch(sql);
			// Create an int[] to hold returned values
			int[] count = stmt.executeBatch();
			System.out.println(count.length + " row inserted.");
			// Make the changes permanent
			conn.commit();
		} catch (SQLException ex2) {
			System.err.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}

		
		
		// Execute an SELECT statement
		try {
			// Let's execute an SQL statement.
			sql = "SELECT * from TEST";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				// no impedance mismatch in JDBC
				int id = rs.getInt(1);
				String name = rs.getString(2);
				String addr = rs.getString(3);
				System.out.println("ID = " + id + ", Name = " + name + ", Address = " + addr);
			}
			conn.commit();
		} catch (SQLException ex2) {
			System.err.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}

		// Execute an SQL statement for INSERT
		try {
			// Let's execute an SQL statement.
			sql = "UPDATE TEST SET Name = 'Oh' WHERE Id = 40";
			// Try 'UPDATE ...' for the first time
			int res = stmt.executeUpdate(sql);
			System.out.println(res + " row updated.");
			// Let's do DELETE.
			sql = "DELETE FROM TEST WHERE Id = 30";
			// Add above SQL statement in the batch.
			stmt.addBatch(sql);
			int[] count = stmt.executeBatch();
			System.out.println(count.length + " row deleted.");
			// Make the changes permanent
			conn.commit();
		} catch (SQLException ex2) {
			System.err.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}

		// Execute the same SELECT statement with a PreparedStatement
		// to confirm the modification
		try {
			// Let's execute an SQL statement.
			sql = "SELECT * from TEST WHERE Id = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			// ResultSet rs = stmt.executeQuery(sql);
			ps.setInt(1, 40);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				// no impedance mismatch in JDBC
				int id = rs.getInt(1);
				String name = rs.getString(2);
				String addr = rs.getString(3);
				System.out.println("ID = " + id + ", Name = " + name + ", Address = " + addr);
			}
			ps.close();
			rs.close();
			conn.commit();
		} catch (SQLException ex2) {
			System.err.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}

		// Release database resources.
		try {
			// Close the Statement object.
			stmt.close();
			// Close the Connection object.
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
	}
}

