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
			Scanner filepath = new Scanner(System.in);
			System.out.println("이미 db가 구축되었다면 0을, 구축되어있지 않다면 create파일의 경로를 입력하세요. table 생성과 insert를 도와드리겠습니다.");
			System.out.println("\t(create파일의 경로의 예 : C:\\Users\\create.txt)");
			System.out.print("입력하세요(0 or create파일경로): ");
			String fpath = filepath.next();
			if (!(fpath.equals("0"))) {

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
						Paths.get(fpath));
				sql = "";
				int flag = 0;
				while (input.hasNext()) {
					String str = input.nextLine();
					if (str.toUpperCase().contains("ALTER")) {
						sql = str.substring(0, str.length() - 1);
						stmt.addBatch(sql);
					} else if (str.toUpperCase().contains("INSERT")) {
						if (flag == 0) {
							flag = 1;
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
					} else if (str.contains(";")) {
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
				conn.commit();
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

					sql = "INSERT INTO CALENDAR VALUES ('" + group_id + "', '" + createdAt + "', '" + password + "')";
					res = stmt.executeUpdate(sql);
					if (res == 0)
						System.out.println("insert was successfully created.");
					break;
				case "3":
					System.out.println("id를 입력하세요.");
					id = scanner.nextLine();

					sql = "DELETE FROM USERS WHERE id = '" + id+"'";
					res = stmt.executeUpdate(sql);
					if (res == 0)
						System.out.println("delete was successfully created.");
					break;

				// query
				case "4":
					String group_num;
					System.out.println("그룹의 개수를 지정하세요. 1개라면 1, 그 이상이라면 2를 입력하세요");
					group_num = scanner.nextLine();
					if (group_num.equals("1")) {
						// 입력받는: 그룹명
						doTask1_1(conn, stmt);
					} else // 그룹이 두개 이상일때
					{
						doTask1_2(conn, stmt);
					}
					break;
				case "5":
					doTask2(conn, stmt);
					break;
				case "6":
					doTask3(conn, stmt);
					break;
				case "7":
					doTask4(conn, stmt);
					break;
				case "8":
					doTask5(conn, stmt);
					break;
				case "9":
					doTask6(conn, stmt);
					break;
				case "10":
					doTask7(conn, stmt);
					break;
				case "11":
					doTask8(conn, stmt);
					break;
				case "12":
					doTask9(conn, stmt);
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
    private static void doTask1_1(Connection conn, Statement stmt){
   
        ResultSet rs = null;

        try{
		
        	@SuppressWarnings("resource")
		Scanner scan = new Scanner(System.in);
        	System.out.println("조회할 그룹의 그룹명을 입력하세요.");
            	String group_name = scan.nextLine();
            	stmt = conn.createStatement();
            	//query1-1
           	 String sql = "Select u.id, u.name" +
                         	" from users u, participate p"+
                         	// 파라미터를 받는 부분
                         	" where p.group_id = '" +group_name+ "' " +
                         	" and u.id = p.participant ";
            	rs = stmt.executeQuery(sql);
            	System.out.println("<< query 1-1 result >>");
            	System.out.println("User ID    |User Name");
            	System.out.println("-----------------------------");
            	while(rs.next()){
                	String id = rs.getString(1);
                	String name = rs.getString(2);
                	System.out.println(String.format("%-10s|%s", id, name));
            	}
            	rs.close();

            	System.out.println();
        	}catch (SQLException e) {
        		e.printStackTrace();
        	}

    	}

	// query 1-2
	private static void doTask1_2(Connection conn, Statement stmt) {
		// TODO Auto-generated method stub
		ResultSet rs = null;

		try {
			System.out.println("조회할 그룹들의 그룹명을 입력하세요.(공백을 기준)");
			@SuppressWarnings("resource")
			Scanner scan = new Scanner(System.in);
			String group_name = scan.nextLine();
			group_name = group_name.replaceAll(" ", "','");
			// ArrayList<String> group_name=new
			// ArrayList<String>(Arrays.asList(total_group_name.split(" ")));
			stmt = conn.createStatement();
			
			String sql = "Select distinct u.id, u.name " + "from users u, participate p " +
			// 파라미터를 받는 부분
					"where p.group_id in ('" + group_name + "') and u.id = p.participant ";
			rs = stmt.executeQuery(sql);
			System.out.println("<< query 1-2 result >>");
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
	
	//query 2
	private static void doTask2(Connection conn, Statement stmt) {
      // TODO Auto-generated method stub
      		ResultSet rs = null;

      		try {
         		System.out.println("아이디를 입력하세요. 당신이 속해있는 그룹들의 이름을 알려드립니다.");
         		System.out.print("아이디 : ");
         		@SuppressWarnings("resource")
         		Scanner scan = new Scanner(System.in);
         		String myid = scan.nextLine();
         		stmt = conn.createStatement();
         
         		String sql = "select group_id from users join participate on id=participant"
               				+ " where users.id='" + myid + "'";
         		rs = stmt.executeQuery(sql);
         		System.out.println("<< query 2 result >>");
         		System.out.println("Group ID");
         		System.out.println("------------------");
         		while (rs.next()) {
            			String id = rs.getString(1);
            			System.out.println(String.format("%-10s", id));
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
			System.out.print("조회 시작일(YYYYMMDD): ");
			Scanner scan = new Scanner(System.in);
			String startSearch = scan.nextLine();
			System.out.print("조회 마지막일(YYYYMMDD): ");
			String endSearch = scan.nextLine();
			String sql = "Select question_key, question_content" +
					" from (select question_key, question_content from question)" + "where question_key between '"
					+ startSearch + "' and '" + endSearch + "' order by question_key";
			rs = stmt.executeQuery(sql);
			System.out.println("<< query 3 result >>");
			System.out.println("question_date | question_content");
			System.out.println("----------------------------------");
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

	// query 4
	private static void doTask4(Connection conn, Statement stmt) {

		ResultSet rs = null;

		try {
			@SuppressWarnings("resource")
			Scanner scan = new Scanner(System.in);
			String[] group_id = new String[2];

			System.out.println("두 그룹 다 속해있는 이름을 알려드리겠습니다. 첫번째 그룹의 이름을 입력하세요.");
			group_id[0] = scan.nextLine();
			System.out.println("두번째 그룹의 이름을 입력하세요.");
			group_id[1] = scan.nextLine();

			stmt = conn.createStatement();
			// query1-1
			String sql = "Select u.id, u.name from users u, participate p, calendar c" + " where p.group_id = '"
					+ group_id[0] + "'and p.group_id = c.group_id "
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
	
	
	//query 8
    	private static void doTask8(Connection conn, Statement stmt) {

		ResultSet rs = null;

		try {
			@SuppressWarnings("resource")

			String sql = "select c.group_id, count(diary_key)" 
                    			+" from diary d, calendar c, day_record da" 
					+" where d.date_key = da.date_key AND c.group_id = da.group_id "
					+" GROUP BY c.GROUP_ID"
					+" ORDER BY COUNT(DIARY_KEY) DESC";

			rs = stmt.executeQuery(sql);
			System.out.println("<< query 8 result >>");
			System.out.println("Group ID    |Num of diary");
			System.out.println("------------------------------");
			while (rs.next()) {
				String ID = rs.getString(1);
				int num = rs.getInt(2);
				System.out.println(String.format("%-4s|%-11s", ID, num));
			}
			rs.close();

			System.out.println();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	// query 9 -union
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

			String sql = "select u.birthday, u.name from users u, participate p, calendar c"
					+ " where p.group_id = '" + group_id[0] + "' and p.group_id = c.group_id "
					+ "and u.id = p.participant union select u.birthday, u.name "
					+ "from users u, participate p, calendar c where p.group_id = '" + group_id[1]
					+ "' and p.group_id = c.group_id and u.id = p.participant";

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
	
	//query 5
	private static void doTask5(Connection conn, Statement stmt) {
      
      		ResultSet rs = null;

     		try {
         		stmt = conn.createStatement();
         // 특정 기간의 질문 출력
         		System.out.println("당신의 아이디를 입력하세요.");
         		Scanner scan = new Scanner(System.in);
         		String idinput = scan.nextLine();
        		String sql = "select vote_key, vote_name, group_id from vote"
               			   + " where group_id in(select group_id from participate where participant='"+idinput+"')";
         		rs = stmt.executeQuery(sql);
         		System.out.println("현재 당신이 참여중인 그룹에서 진행중인 투표는 다음과 같습니다.");
         		System.out.println("VOTE_KEY | VOTE_NAME | GROUP_ID");
         		System.out.println("-----------------------------");
         		while (rs.next()) {
            			String vkey = rs.getString(1);
            			String vname = rs.getString(2);
            			String gid = rs.getString(3);
            			System.out.println(String.format("%8s| %-15s| %s", vkey,vname,gid));
         		}
         		rs.close();
         		ResultSet rs1 = null;
         		System.out.println("투표의 키(VOTE_KEY)를 입력하시면 투표현황을 보여드립니다.");
         		String vkey = scan.nextLine();
         		sql = "select item_name as 항목 ,count(*) as 득표수 "
               			+ "from item natural join pick "
               			+ "group by vote_key, item_key, item_name "
               			+ "having vote_key="+vkey
               			+ "order by count(*) DESC";
         		rs1 = stmt.executeQuery(sql);
         		System.out.println(vkey+"의 결과는 다음과 같습니다.");
         		System.out.println("항목           | 득표수");
         		System.out.println("-----------------------------");
         		while (rs1.next()) {
            			String iname = rs1.getString(1);
            			String count = rs1.getString(2);
            			System.out.println(String.format("%-10s|%s", iname,count));
         		}
         		rs1.close();

         		System.out.println();
      		} catch (SQLException e) {
         		e.printStackTrace();
      		}
   	}

	// query 6
   private static void doTask6(Connection conn, Statement stmt) {

      ResultSet rs = null;

      try {
         @SuppressWarnings("resource")
         Scanner scan = new Scanner(System.in);
         String n;

         System.out.println("답변자가 n명 이상인 질문을 출력하겠습니다.");
         System.out.println("숫자 n을 입력하세요.");
         n = scan.nextLine();

         stmt = conn.createStatement();

         String sql = "select q.question_key as q_key, COUNT(*) as 답변자 " + "from question q, answer a "
               + " where q.question_key=a.question_key "
               + "group by q.question_key "
               + "Having Count(*) >= " + n;

         rs = stmt.executeQuery(sql);
         System.out.println("<< query 6 result >>");
         System.out.println("질문 key    | 답변자");
         System.out.println("-----------------------------");
         while (rs.next()) {
            String q = rs.getString(1);
            String p = rs.getString(2);
            System.out.println(String.format("%-11s|%-11s", q, p));
         }
         rs.close();

         System.out.println();
      } catch (SQLException e) {
         e.printStackTrace();
      }

   }
	
   // query 7
   // -- 특정그룹의 특정 key(투표번호)인 투표의 각 항목을 선택한 사람의 수를 추출함
   // -- 입력받을 것: 그룹이름, 투표이름
   private static void doTask7(Connection conn, Statement stmt) {

      ResultSet rs = null;

      try {
         @SuppressWarnings("resource")
         Scanner scan = new Scanner(System.in);
         String[] ary = new String[2];

         System.out.println("원하는 그룹의 한 투표에 대한 항목 별 득표 수를 출력하겠습니다.");
         System.out.println("group id를 입력하세요.");
         ary[0] = scan.nextLine();
         System.out.println("투표 key를 입력하세요.");
         ary[1] = scan.nextLine();

         stmt = conn.createStatement();

         String sql = "select i.item_name as 투표항목, count(*) as 득표수 " + "from item i, vote v, pick p "
               + "where v.group_id = '" + ary[0] + "'AND v.vote_key =  "+ ary[1]
               + " AND v.vote_key = i.vote_key AND p.item_key = i.item_key "
               + "group by i.item_name "
               + "ORDER BY COUNT(*) DESC";

         rs = stmt.executeQuery(sql);
         System.out.println("<< query 7 result >>");
         System.out.println("투표항목    |득표수");
         System.out.println("------------------------------");
         while (rs.next()) {
            String item = rs.getString(1);
            String cnt = rs.getString(2);
            System.out.println(String.format("%-11s|%-11s", item, cnt));
         }
         rs.close();

         System.out.println();
      } catch (SQLException e) {
         e.printStackTrace();
      }


   }

}
