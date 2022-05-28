package controller;

import model.bean.Product;
import model.service.IProduct;
import model.service.impl.ImplProductService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductServlet " ,urlPatterns = "/Product")
public class ProductServlet extends HttpServlet {
IProduct implProductService =new ImplProductService();
    private Object Product;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action==null){
            action ="";
        }
        switch (action){
            case "add":
                // lưu dữ liệu
                save(request,response);
                break;
            case "update":
                // chỉnh sửa
                break;
            case "delete":
                // xóa
            case "findByName":
                // Tim kiem boi ten
                break;
            default:


        }

    }
    private void save(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        int gia = Integer.parseInt(request.getParameter("gia"));
        String moTa = request.getParameter("moTa");
        String nhaSX = request.getParameter("nhaSX");

        Product =new Product(id, name, gia, moTa,nhaSX);
        try {
            response.sendRedirect("/Product");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action==null){
            action ="";
        }
        switch (action){
            case "add": 
                showFormCreate(request,response);
                break;
            case "update":
                // chỉnh sửa
                break;
            case "delete":
                // xóa
                break;
            case "findByName":
                // Tim kiem san pham
                break;
            default:
                // trả về trang list
                showListProduct(request,response);


        }

    }

    private void showListProduct(HttpServletRequest request, HttpServletResponse response) {
        List<Product> studentList = ProductServlet.findAll();
        request.setAttribute("productList",ProductList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("view/student/list.jsp");
        try {
            dispatcher.forward(request,response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void showFormCreate(HttpServletRequest request, HttpServletResponse response) {
        RequestDispatcher dispatcher = request.getRequestDispatcher("view/product");
        try {
            dispatcher.forward(request,response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}


