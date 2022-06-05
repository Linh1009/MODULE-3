package model.service.impl;

import model.bean.User;
import model.repository.impl.ImplUserRepository;
import model.service.IUserService;

import java.sql.SQLException;
import java.util.List;

public class ImplUserService implements IUserService {
    ImplUserRepository userRepository = new ImplUserRepository();


    @Override
    public void insertUser(User user) throws SQLException {

    }

    @Override
    public User selectUser(int id) {
        return null;
    }

    @Override
    public List<User> selectAllUsers() {
        return null;
    }

    @Override
    public boolean deleteUser(int id) throws SQLException {
        return false;
    }

    @Override
    public boolean updateUser(User user) throws SQLException {
        return false;
    }

    @Override
    public User selectUserCountry(String country) {
        return null;
    }

}