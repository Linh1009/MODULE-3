package model.service;

import model.bean.Product;

import java.util.List;

public interface IProduct {
    List<Product> findAll();

    void save(Product product);

    void update(int id, Product product);

    void delete(int id);

    Product findByName(String name);

}
