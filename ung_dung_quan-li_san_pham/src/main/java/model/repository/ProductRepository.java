package model.repository;

import model.bean.Product;

import java.util.List;

public interface ProductRepository {
    List<Product> findAll();

    void save(Product product);

    void update(int id, Product product);

    void delete(int id);

    Product findByName(String name);


}
