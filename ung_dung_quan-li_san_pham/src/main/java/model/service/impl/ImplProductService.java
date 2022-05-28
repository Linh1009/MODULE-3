package model.service.impl;

import model.bean.Product;
import model.repository.impl.ProducRepositoryImpl;
import model.service.IProduct;

import java.util.List;

public class ImplProductService implements IProduct {
    ProducRepositoryImpl producRepositoryImpl = new ProducRepositoryImpl();

    @Override
    public List<Product> findAll() {
        return null;
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


