package model;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.Iterator;

public class TokenStorage {

    // Lưu token tạm thời với email và thời gian tạo
    public static class TokenEntry {
    public String email;
    public String fullName;
    public String gender;
    public String mobile;
    public String password;
    public long createdAt;

    public TokenEntry(String email, String fullName, String gender, String mobile, String password) {
        this.email = email;
        this.fullName = fullName;
        this.gender = gender;
        this.mobile = mobile;
        this.password = password;
        this.createdAt = System.currentTimeMillis();
    }
}


    // Token được lưu vào Map dạng: token -> TokenEntry
    public static Map<String, TokenEntry> tokenMap = new ConcurrentHashMap<>();

    // Xoá token quá hạn (ví dụ > 10 phút)
    public static void cleanUpExpiredTokens() {
        long now = System.currentTimeMillis();
        long expiration = 10 * 60 * 1000; // 10 phút

        Iterator<Map.Entry<String, TokenEntry>> iterator = tokenMap.entrySet().iterator();
        while (iterator.hasNext()) {
            Map.Entry<String, TokenEntry> entry = iterator.next();
            if (now - entry.getValue().createdAt > expiration) {
                iterator.remove();
            }
        }
    }
}
