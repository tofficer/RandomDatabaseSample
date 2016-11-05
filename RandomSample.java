import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;
import java.util.Random;
import java.lang.StringBuilder;

public class RandomSample {

	String[] user_query;
	double k;
	String new_table_name;
	String psql_url;
	long seed;

	public RandomSample(String[] user_query, double k, long seed, String new_table_name, String psql_url) {
		this.user_query = user_query;
		this.k = k;
		this.new_table_name = new_table_name;
		this.psql_url = psql_url;
		this.seed = seed;
	}
	
	public void execute() throws SQLException {
		Connection conn = DriverManager.getConnection(this.psql_url);
		Statement st = conn.createStatement();

		//create new table on query that is numbered by rows
		//most expensive part of program

		for (int i = 0; i <= this.user_query.length-2; i++) {
			st.executeUpdate(this.user_query[i]);
		}

		st.executeUpdate("CREATE TABLE " + new_table_name + " AS (SELECT row_number() over () as rownum, * FROM (" + this.user_query[user_query.length-1] + ") AS sq1);");

		int n = 0;
		ResultSet rs = st.executeQuery("SELECT count(*) FROM " + new_table_name + ";");
		while (rs.next()) n = rs.getInt(1);

		if (this.k < n) {
			String rowset = getRowSet(n);
			st.executeUpdate("DELETE FROM " + new_table_name + " WHERE rownum NOT IN " + rowset + ";");
		}
		else {
			System.out.println("The sample size you chose is >= the size of the table/query you requested");
		}

		st.executeUpdate("ALTER TABLE " + new_table_name + " DROP COLUMN rownum;");
		
		if (new_table_name.equals("PrintThenDeleteTable")) {
			rs = st.executeQuery("SELECT * FROM PrintThenDeleteTable;");
			printResultSet(rs);
			st.executeUpdate("DROP TABLE IF EXISTS PrintThenDeleteTable;");
		}
		
		rs.close();
		st.close();
		conn.close();
	}
	
	//choose k from n
	public String getRowSet(double n) {
		double m = 0; //number selected so far
		double t = 0; //number seen so far
		Random rand = new Random(this.seed);
		
		StringBuilder sb = new StringBuilder("(");

		while (m < k) {
			double u = rand.nextDouble();

			if ((n-t)*u < (k-m)) {
				m++;
				int row = (int) t+1;
				sb.append(row);
				if (m != k) sb.append(",");
			}
			t++;
		}
		sb.append(")");
		return sb.toString();
	}

	public void printResultSet(ResultSet rs) throws SQLException {
		ResultSetMetaData rsmd = rs.getMetaData();
		int col_count = rsmd.getColumnCount(); 

		while (rs.next()) {
			for (int i = 1; i <= col_count; i++) {
				if (i > 1) System.out.print(", ");
				System.out.print(rsmd.getColumnName(i) + " " + rs.getString(i));
			}
			System.out.println("");
		}
	}
}