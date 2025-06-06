<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, org.json.JSONObject, org.json.JSONArray, java.io.*, java.util.*, java.util.stream.Collectors" %>
<%
    response.setContentType("application/json; charset=UTF-8");
    JSONObject result = new JSONObject();

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // 讀取前端發送的 JSON 資料
        BufferedReader reader = request.getReader();
        StringBuilder jsonInput = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            jsonInput.append(line);
        }
        JSONObject requestData = new JSONObject(jsonInput.toString());
        JSONObject user = requestData.getJSONObject("user");
        JSONArray items = requestData.getJSONArray("items");

        // 資料庫連線
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/your_database?useSSL=false&serverTimezone=UTC", "username", "password");
        conn.setAutoCommit(false); // 開啟事務

        // 檢查並鎖定庫存 (使用 FOR UPDATE 防止並發問題)
        String productIds = String.join(",", items.toList().stream()
            .map(item -> ((JSONObject)item).getInt("id") + "")
            .collect(Collectors.toList()));
        pstmt = conn.prepareStatement("SELECT product_id, name, stock FROM products WHERE product_id IN (" + productIds + ") FOR UPDATE");
        rs = pstmt.executeQuery();
        Map<Integer, Integer> productStocks = new HashMap<>();
        Map<Integer, String> productNames = new HashMap<>();
        while (rs.next()) {
            productStocks.put(rs.getInt("product_id"), rs.getInt("stock"));
            productNames.put(rs.getInt("product_id"), rs.getString("name"));
        }
        rs.close();
        pstmt.close();

        // 檢查庫存是否足夠
        for (int i = 0; i < items.length(); i++) {
            JSONObject item = items.getJSONObject(i);
            int productId = item.getInt("id");
            int quantity = item.getInt("quantity");

            if (!productStocks.containsKey(productId)) {
                throw new Exception("商品不存在，商品 ID: " + productId);
            }
            int currentStock = productStocks.get(productId);
            if (currentStock < quantity) {
                throw new Exception("庫存不足，商品: " + productNames.get(productId) + "，剩餘庫存: " + currentStock);
            }
        }

        // 更新庫存並記錄訂單
        for (int i = 0; i < items.length(); i++) {
            JSONObject item = items.getJSONObject(i);
            int productId = item.getInt("id");
            int quantity = item.getInt("quantity");

            // 更新庫存
            pstmt = conn.prepareStatement("UPDATE products SET stock = stock - ? WHERE product_id = ? AND stock >= ?");
            pstmt.setInt(1, quantity);
            pstmt.setInt(2, productId);
            pstmt.setInt(3, quantity); // 確保庫存不會變成負數
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected == 0) {
                throw new Exception("更新庫存失敗，商品 ID: " + productId + "，可能庫存不足或商品不存在");
            }
            pstmt.close();

            // 記錄訂單
            pstmt = conn.prepareStatement(
                "INSERT INTO orders (recipient_name, recipient_phone, recipient_email, recipient_address, product_id, quantity, order_date) " +
                "VALUES (?, ?, ?, ?, ?, ?, NOW())"
            );
            pstmt.setString(1, user.getString("name"));
            pstmt.setString(2, user.getString("phone"));
            pstmt.setString(3, user.getString("email"));
            pstmt.setString(4, user.getString("address"));
            pstmt.setInt(5, productId);
            pstmt.setInt(6, quantity);
            pstmt.executeUpdate();
            pstmt.close();
        }

        conn.commit(); // 提交事務
        result.put("success", true);
        result.put("message", "訂單完成，庫存已更新");

    } catch (Exception e) {
        if (conn != null) {
            try {
                conn.rollback(); // 回滾事務
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        result.put("success", false);
        result.put("message", "訂單處理失敗: " + e.getMessage());
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    out.print(result.toString());
    out.flush();
%>