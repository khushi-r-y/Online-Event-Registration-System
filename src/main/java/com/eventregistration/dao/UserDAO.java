
package com.eventregistration.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.security.SecureRandom;
import java.security.spec.KeySpec;
import java.util.Base64;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

import com.eventregistration.model.User;
import com.eventregistration.util.DBConnection;

public class UserDAO {

    private static final int ITERATIONS = 65536;
    private static final int KEY_LENGTH = 256;

    private String hashPassword(String password) throws Exception {
        byte[] salt = new byte[16];
        new SecureRandom().nextBytes(salt);

        KeySpec spec = new PBEKeySpec(
                password.toCharArray(), salt, ITERATIONS, KEY_LENGTH);

        byte[] hash = SecretKeyFactory
                .getInstance("PBKDF2WithHmacSHA256")
                .generateSecret(spec)
                .getEncoded();

        return Base64.getEncoder().encodeToString(salt) + ":"
                + Base64.getEncoder().encodeToString(hash);
    }

    private boolean verifyPassword(String password, String storedValue)
            throws Exception {

        if (storedValue == null) {
            return false;
        }

        String[] parts = storedValue.split(":");

        if (parts.length != 2) {
            return false;
        }

        byte[] salt = Base64.getDecoder().decode(parts[0]);
        byte[] expectedHash = Base64.getDecoder().decode(parts[1]);

        KeySpec spec = new PBEKeySpec(
                password.toCharArray(), salt, ITERATIONS, KEY_LENGTH);

        byte[] actualHash = SecretKeyFactory
                .getInstance("PBKDF2WithHmacSHA256")
                .generateSecret(spec)
                .getEncoded();

        if (actualHash.length != expectedHash.length) {
            return false;
        }

        int difference = 0;

        for (int i = 0; i < actualHash.length; i++) {
            difference |= actualHash[i] ^ expectedHash[i];
        }

        return difference == 0;
    }

    public boolean registerUser(User user) {

        String role = user.getRole();

        // Public registration must not create administrator accounts.
        if (!"USER".equals(role)) {
            return false;
        }

        String sql = "INSERT INTO OERS_USERS "
                + "(USER_ID, FULL_NAME, EMAIL, PASSWORD_HASH, ROLE) "
                + "VALUES (OERS_USERS_SEQ.NEXTVAL, ?, ?, ?, ?)";

        try {
            String hashedPassword = hashPassword(user.getPassword());

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setString(1, user.getFullName());
                ps.setString(2, user.getEmail());
                ps.setString(3, hashedPassword);
                ps.setString(4, role);

                return ps.executeUpdate() > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public User loginUser(String email, String password) {

        String sql = "SELECT USER_ID, FULL_NAME, EMAIL, ROLE, PASSWORD_HASH "
                + "FROM OERS_USERS WHERE EMAIL = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    String storedPassword = rs.getString("PASSWORD_HASH");

                    if (!verifyPassword(password, storedPassword)) {
                        return null;
                    }

                    User user = new User();
                    user.setUserId(rs.getInt("USER_ID"));
                    user.setFullName(rs.getString("FULL_NAME"));
                    user.setEmail(rs.getString("EMAIL"));
                    user.setRole(rs.getString("ROLE"));

                    return user;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}
