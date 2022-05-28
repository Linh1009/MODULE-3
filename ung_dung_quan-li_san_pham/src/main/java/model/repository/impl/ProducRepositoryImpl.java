package model.repository.impl;

import model.bean.Product;
import model.repository.ProductRepository;

import java.util.ArrayList;
import java.util.List;

public class ProducRepositoryImpl implements ProductRepository {
    public static List<Product> productList = new ArrayList<>();
    static {
        productList.add(new Product(1, "May giac", 200, "mau cam", "NhaSX A"));
        productList.add(new Product(2, "Ti vi", 300, "mau den", "NhaSX A"));
        productList.add(new Product(3, "May tinh", 200, "mau cam", "NhaSX B"));
        productList.add(new Product(4, "Tu lanh", 200, "mau xam", "NhaSX C"));
        productList.add(new Product(5, "Dien thoai", 200, "mau hong", "NhaSX C"));

    }
    @Override
    public List<Product> findAll() {
        return productList;
    }

    @Override
    public void save(Product product) {

    }

    @Override
    public void update(int id, Product product) {

    }

    @Override
    public void delete(int id) {

    }

    @Override
    public Product findByName(String name) {
        return null;
    }

}
