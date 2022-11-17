package DBjaja;

import java.io.IOException;
import java.nio.file.Paths;
// import JDBC package
import java.sql.Connection;
import java.sql.DriverManager;
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
		int res = 0;
		try {
			conn.setAutoCommit(false); // auto-commit disabled
			// Create a statement object
			stmt = conn.createStatement();
			// Let's execute an SQL statement.

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
			Scanner input = new Scanner(
					Paths.get("C:\\Users\\hyejj\\eclipse-workspace\\labs\\bin\\DBjaja\\create.txt"));
			sql = "";
			int flag=0;
			while (input.hasNext()) {
				String str = input.nextLine();
				if (str.toUpperCase().contains("ALTER")) {
					sql = str.substring(0, str.length() - 1);
					stmt.addBatch(sql);
				}
				else if (str.toUpperCase().contains("INSERT")) {
					if (flag==0)
					{
						flag=1;
						try {
							int[] count = stmt.executeBatch();
							System.out.println("create table 완료!");
							// Make the changes permanent
							conn.commit();
						} catch (SQLException ex3) {
							System.err.println("sql error = " + ex3.getMessage());
							System.exit(1);
						}
					}
					sql = str.substring(0, str.length() - 1);
					stmt.addBatch(sql);
				}
				else if (str.contains(";")) {
					sql += ")";
					res = stmt.executeUpdate(sql);
					if (res == 0)
						System.out.println("Table was successfully created.");
					sql = "";
				} else {
					sql += str;
				}
			}
			try {
				int[] count = stmt.executeBatch();
				System.out.println("insert 완료!");
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

		/* 메뉴 */
		try {
			Scanner scanner = new Scanner(System.in);
			String inputData;

			while (true) {
				System.out.println("사용할 기능의 번호를 입력하세요.");
				System.out.println("1. 회원가입");
				System.out.println("2. 그룹생성");
				System.out.println("3. 회원탈퇴");
				System.out.println("4. 특정 그룹의 멤버 조회");
				System.out.println("5. 내가 속한 그룹명 조희");
				System.out.println("6. 특정 기간의 질문 출력");
				System.out.println("7. 2가지 그룹에 모두 속한 멤버의 이름 출력");
				System.out.println("8. 현재 투표상황 확인");
				System.out.println("9. 답변자가 특정 수 이상인 질문 조희");
				System.out.println("10. 특정 그룹의 특정투표 항목을 선택한 사람 수 출력");
				System.out.println("11. 일기를 많이 작성한 그룹 랭킹 확인");
				System.out.println("12. 2 그룹 중 하나 이상에 속한 멤버이름 출력");
				System.out.println("종료 : q");

				inputData = scanner.nextLine();
				if (inputData.equals("q")) {
					break;
				}

				switch (inputData) {
				case "1":
					String id;
					String password;
					String birthday;
					String name;
					String profile_photo;

					System.out.println("id를 입력하세요.");
					id = String.valueOf(scanner.nextLine());
					System.out.println("비밀번호를 입력하세요.");
					password = scanner.nextLine();
					System.out.println("생년월일을 xxxx-xx-xx양식으로 입력하세요.");
					birthday = scanner.nextLine();
					System.out.println("이름을 입력하세요.");
					name = scanner.nextLine();
					System.out.println("프로필사진 파일경로를 입력하세요.");
					profile_photo = scanner.nextLine();

					sql = "INSERT INTO USERS VALUES ('" + id + "', '" + password + "', To_date('" + birthday
							+ "', 'yyyy-mm-dd'), '" + name + "', '" + profile_photo + "')";
					res = stmt.executeUpdate(sql);
					if (res == 0)
						System.out.println("insert was successfully created.");
					break;
				case "2":
					String group_id;
					String createdAt;

					System.out.println("group id를 입력하세요.");
					group_id = scanner.nextLine();
					System.out.println("오늘의 날짜를 xxxx-xx-xx양식으로 입력하세요.");
					createdAt = scanner.nextLine();
					System.out.println("캘린더의 비밀번호를 입력하세요.");
					password = scanner.nextLine();

					sql = "INSERT INTO USERS VALUES (" + group_id + ", " + createdAt + ", " + password + ")";
					res = stmt.executeUpdate(sql);
					if (res == 0)
						System.out.println("insert was successfully created.");
					break;
				case "3":
					System.out.println("id를 입력하세요.");
					id = scanner.nextLine();

					sql = "DELETE FROM USERS WHERE id = " + id;
					res = stmt.executeUpdate(sql);
					if (res == 0)
						System.out.println("delete was successfully created.");
					break;

				// query
				case "4":
					String group_num;
					System.out.println("그룹의 개수를 지정하세요. ");
					group_num = scanner.nextLine();
					if (group_num.equals("1")) {
						// 입력받는: 그룹명
						doTask1_1(conn, stmt);
					}
					else //그룹이 두개 이상일때
					{
						doTask1_2(conn, stmt);
					}
					break;
				case "5":
					break;
				case "6":
					doTask3(conn, stmt);
					break;
				case "7":
					doTask4(conn,stmt);
					break;
				case "8":
					break;
				case "9":
					break;
				case "10":
					break;
				case "11":
					break;
				case "12":
					break;
				}
				
			}
			conn.commit();

		} catch (SQLException ex2) {
			System.err.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}

	}

		

		// query 1-1
	private static void doTask1_1(Connection conn, Statement stmt) {

		
	}
	//query 1-2
	private static void doTask1_2(Connection conn, Statement stmt) {
		// TODO Auto-generated method stub
			ResultSet rs = null;

			try {
				System.out.println("조회할 그룹들의 그룹명을 입력하세요.(공백을 기준으로)");
				@SuppressWarnings("resource")
				Scanner scan = new Scanner(System.in);
				String group_name= scan.nextLine();
				group_name=group_name.replaceAll(" ", "','");
				//ArrayList<String> group_name=new ArrayList<String>(Arrays.asList(total_group_name.split(" ")));
				stmt = conn.createStatement();
				// query1-1
				String sql = "Select distinct u.id, u.name " + "from users u, participate p " +
				// 파라미터를 받는 부분
						"where p.group_id in ('"+group_name+ "') and u.id = p.participant ";
				rs = stmt.executeQuery(sql);
				System.out.println("<< query 1-1 result >>");
				System.out.println("User ID    |User Name");
				System.out.println("-----------------------------");
				while (rs.next()) {
					String id = rs.getString(1);
					String name = rs.getString(2);
					System.out.println(String.format("%-10s|%s", id, name));
				}
				rs.close();

				System.out.println();

			} catch (SQLException e) {
				e.printStackTrace();
			}

	}
	// query 3
	private static void doTask3(Connection conn, Statement stmt) {
		ResultSet rs = null;

		try {
			stmt = conn.createStatement();
			// 특정 기간의 질문 출력
			System.out.println("조회하고 싶은 기간을 입력하세요.");
			System.out.print("조회시작일(YYYYMMDD): ");
			Scanner scan = new Scanner(System.in);
			String startSearch= scan.nextLine();
			System.out.print("조회끝일(YYYYMMDD): ");
			String endSearch= scan.nextLine();
			String sql = "Select question_key, question_content" +
			// from을 이렇게 길게 쓴 이유는??
					" from (select question_key, question_content from question)"
					+ "where question_key between '"+startSearch+"' and '"+endSearch+"' order by question_key";
			rs = stmt.executeQuery(sql);
			System.out.println("<< query 3 result >>");
			System.out.println("question_date | question_content");
			System.out.println("-----------------------------");
			while (rs.next()) {
				String date = rs.getString(1);
				String content = rs.getString(2);
				System.out.println(String.format("%-14s| %s", date, content));
			}
			rs.close();

			System.out.println();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}
	
	//query 4
	private static void doTask4(Connection conn, Statement stmt) {

		ResultSet rs = null;

		try {
			@SuppressWarnings("resource")
			Scanner scan = new Scanner(System.in);
			String[] group_id = new String[2];

			System.out.println("두 그룹 다 속해있는 이름을 알려드리겠습니다.  그룹의 이름을 입력하세요.");
			group_id[0] = scan.nextLine();
			System.out.println("두번째 그룹의 이름을 입력하세요.");
			group_id[1] = scan.nextLine();

			stmt = conn.createStatement();
			// query1-1
			String sql = "Select u.id, u.name from users u, participate p, calendar c" 
					+" where p.group_id = '" + group_id[0] + "'and p.group_id = c.group_id "
					+ "and u.id = p.participant intersect select u.id, u.name "
					+ "from users u, participate p, calendar c where p.group_id = '" + group_id[1] 
					+ "'and p.group_id = c.group_id and u.id = p.participant";

			rs = stmt.executeQuery(sql);
			System.out.println("<< query 4 result >>");
			System.out.println("User ID    |User Name");
			System.out.println("-----------------------------");
			while (rs.next()) {
				String id = rs.getString(1);
				String name = rs.getString(2);
				System.out.println(String.format("%-11s|%-11s", id, name));
			}
			rs.close();

			System.out.println();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}
	
	//query 9 -union
    	private static void doTask9(Connection conn, Statement stmt) {

		ResultSet rs = null;

		try {
			@SuppressWarnings("resource")
			Scanner scan = new Scanner(System.in);
			String[] group_id = new String[2];

			System.out.println("두 그룹 중 한 그룹에 속한 멤버의 이름과 생일을 출력하겠습니다.");
            		System.out.println("첫번째 그룹의 이름을 입력하세요.");
			group_id[0] = scan.nextLine();
			System.out.println("두번째 그룹의 이름을 입력하세요.");
			group_id[1] = scan.nextLine();

			stmt = conn.createStatement();
			
			String sql = "select u.birthday u.name" 
                    			+"from users u, participate p, calendar c" 
					+" where p.group_id = '" + group_id[0] + "'and p.group_id = c.group_id "
					+ "and u.id = p.participant union select u.id, u.name "
					+ "from users u, participate p, calendar c where p.group_id = '" + group_id[1] 
					+ "'and p.group_id = c.group_id and u.id = p.participant";

			rs = stmt.executeQuery(sql);
			System.out.println("<< query 9 result >>");
			System.out.println("User Name    |User Birthday");
			System.out.println("------------------------------");
			while (rs.next()) {
				String name = rs.getString(1);
				String date = rs.getString(2);
				System.out.println(String.format("%-11s|%-11s", name, date));
			}
			rs.close();

			System.out.println();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

}
