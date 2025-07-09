package config;

import java.util.Properties;
import jakarta.mail.Session;
import jakarta.mail.Authenticator;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.io.UnsupportedEncodingException;

public class EmailSender {

    public static void sendEmail(String to, String subject, String content) throws Exception {
        final String username = "thien.phamphuc05@gmail.com";
        final String password = "ktzj ulyt jsfr iacf";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props,
                new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(username));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
        message.setSubject(subject);

        // ✅ Đặt nội dung email với UTF-8
        message.setContent(content, "text/plain; charset=UTF-8");

        Transport.send(message);
    }

    public static void sendPassword(String toEmail, String randPass)
            throws MessagingException, UnsupportedEncodingException {
        final String fromEmail = "sonnhhe189023@fpt.edu.vn";
        final String password = "fest wkvt jcme kxzl";

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(fromEmail, "Nguyen Hoang Son"));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject("Online learing system confirm register");
        String messageText = "Hi,\n\n"
                + "Your account has been created successfully.\n"
                + "Here are your login credentials:\n\n"
                + "Username (email): " + toEmail + "\n"
                + "Temporary password: " + randPass + "\n\n"
                + "Please log in and change your password as soon as possible.\n\n"
                + "Login page: http://localhost:8080/Online_Learning_System/login.jsp\n\n"
                + "Regards,\n"
                + "Group 4 Team, From Sonnh, Online learning system";
        message.setText(messageText);
        Transport.send(message);
    }
}
