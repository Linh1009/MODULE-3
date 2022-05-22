<%--
  Created by IntelliJ IDEA.
  User: LENOVO
  Date: 5/22/2022
  Time: 12:02 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>$Title$</title>
  </head>
  <body>
  <form method="post" action="result.jsp">
    <div class="product">
      <h2>Product Discount Calculator</h2>
      <label>Product Description:</label>
      <input type="text" name="description"><br>
      <label>List Price:</label>
      <input type="number" name="price"><br>
      <label>Discount Percent:</label>
      <input type="number" name="discount_percent"><br>
      <input type="submit" value="Calculate Discount">
    </div>
  </form>
  </body>
</html>
