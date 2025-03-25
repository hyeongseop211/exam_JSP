<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    table {
    	border: 1px solid black;
        width: 100%;
    }
    th, td {
        border: 1px solid black;
        text-align: left;
    }
</style>
</head>
<body>
<table>
    <tr>
        <th>사원번호</th>
        <th>사원명</th>
        <th>직급</th>
        <th>상관번호</th>
        <th>입사일자</th>
        <th>급여</th>
        <th>커미션</th>
        <th>부서번호</th>
    </tr>
<%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        String url = "jdbc:oracle:thin:@localhost:1521:XE";
        String user = "scott";
        String password = "tiger";
        
        conn = DriverManager.getConnection(url, user, password);
        stmt = conn.createStatement();
        String sql = "SELECT * FROM EMP";
        rs = stmt.executeQuery(sql);

        while(rs.next()) {
%>
    <tr>
        <td><%= rs.getInt("EMPNO") %></td>
        <td><%= rs.getString("ENAME") %></td>
        <td><%= rs.getString("JOB") %></td>
        <td><%= rs.getInt("MGR") == 0 ? "null" : rs.getInt("MGR") %></td>
        <td><%= rs.getDate("HIREDATE") %> 00:00:00</td>
        <td><%= rs.getDouble("SAL") %></td>
        <td><%= rs.getObject("COMM") == null ? "null" : rs.getInt("COMM") %></td>
        <td><%= rs.getInt("DEPTNO") %></td>
    </tr>
<%
        }
    } catch(Exception e) {
        out.println("오류 발생: " + e.getMessage());
    } finally {
        if(rs != null) try { rs.close(); } catch(SQLException e) {}
        if(stmt != null) try { stmt.close(); } catch(SQLException e) {}
        if(conn != null) try { conn.close(); } catch(SQLException e) {}
    }
%>
</table>
</body>
</html>
