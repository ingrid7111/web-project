<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    String username = request.getParameter("username");
    String password = request.getParameter("password");

    String dbUrl = "jdbc:mysql://localhost:3306/shop?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC";
    String dbUser = "root";
    String dbPassword = "1234";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
        String sql = "SELECT * FROM merchants WHERE username = ? AND password = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, username);
        pstmt.setString(2, password); // 注意：實際應用中應加密密碼
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            session.setAttribute("merchant", username);
            response.sendRedirect("merchantOrders.jsp");
        } else {
            request.setAttribute("error", "用戶名或密碼錯誤");
            request.getRequestDispatcher("merchantLogin.jsp").forward(request, response);
        }

        rs.close();
        pstmt.close();
        conn.close();
    } catch (Exception e) {
        request.setAttribute("error", "登錄失敗：" + e.getMessage());
        request.getRequestDispatcher("merchantLogin.jsp").forward(request, response);
    }
%>