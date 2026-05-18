package co.edu.unbosque.cinelog_backend.security;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

@Component
public class PasswordUtil {

	private final BCryptPasswordEncoder encoder;

	public PasswordUtil() {
		this.encoder = new BCryptPasswordEncoder();
	}

	public String encryptPassword(String password) {
		return encoder.encode(password);
	}

	public boolean matches(String rawPassword, String encryptedPassword) {
		return encoder.matches(rawPassword, encryptedPassword);
	}
}