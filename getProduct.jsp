<%@ page import="java.sql.*, org.json.*, java.io.*" %>
<%
    // 資料庫連線參數設定
    String url = "jdbc:mysql://localhost:3306/your_database"; // 資料庫連結字串（改成你的）
    String user = "your_user"; // 資料庫使用者名稱（改成你的）
    String password = "your_password"; // 資料庫密碼（改成你的）

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    JSONArray products = new JSONArray(); // 用於存放查詢結果的 JSON 陣列

    String idParam = request.getParameter("id"); // 從 URL 取得參數 id，判斷是否查詢單筆商品

    try {
        Class.forName("com.mysql.cj.jdbc.Driver"); // 載入 MySQL JDBC Driver
        conn = DriverManager.getConnection(url, user, password); // 建立資料庫連線

        if (idParam != null) {
            // 如果有提供商品 id，則查詢該筆商品資料
            pstmt = conn.prepareStatement("SELECT * FROM products WHERE product_id = ?");
            pstmt.setInt(1, Integer.parseInt(idParam)); // 將字串轉成整數並設定參數
        } else {
            // 沒有提供 id，則查詢所有商品資料
            pstmt = conn.prepareStatement("SELECT * FROM products");
        }

        rs = pstmt.executeQuery(); // 執行查詢

        // 將查詢結果封裝成 JSON 物件並加入陣列
        while (rs.next()) {
            JSONObject product = new JSONObject();
            product.put("product_id", rs.getInt("product_id"));
            product.put("name", rs.getString("name") == null ? "" : rs.getString("name"));
            product.put("price", rs.getDouble("price"));
            product.put("stock", rs.getInt("stock"));
            product.put("description", rs.getString("description") == null ? "" : rs.getString("description"));
            product.put("image", rs.getString("image") == null ? "" : rs.getString("image"));
            products.put(product);
        }

        // 設定回應格式為 JSON，並使用 UTF-8 編碼
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        // 若查詢單筆商品，回傳第一筆 JSON 物件；否則回傳整個陣列
        if (idParam != null && products.length() > 0) {
            out.print(products.getJSONObject(0).toString());
        } else {
            out.print(products.toString());
        }

    } catch (Exception e) {
        e.printStackTrace(); // 發生例外時，印出錯誤堆疊
    } finally {
        // 關閉資源，避免連線洩漏
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
