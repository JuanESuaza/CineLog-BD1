package co.edu.unbosque.cinelog_backend.security;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import org.springframework.stereotype.Component;

import java.security.Key;
import java.util.Date;

@Component
public class JwtUtil {

	private static final String SECRET_KEY = "cinelog_super_secret_key_para_jwt_debe_ser_larga_2026";
	private static final long EXPIRATION_TIME = 1000 * 60 * 60 * 24;

	private Key getSigningKey() {
		return Keys.hmacShaKeyFor(SECRET_KEY.getBytes());
	}

	public String generateToken(Integer idUsuario, String correoElectronico) {
		return Jwts.builder().setSubject(correoElectronico).claim("id_usuario", idUsuario)
				.claim("correo_electronico", correoElectronico).setIssuedAt(new Date())
				.setExpiration(new Date(System.currentTimeMillis() + EXPIRATION_TIME))
				.signWith(getSigningKey(), SignatureAlgorithm.HS256).compact();
	}

	public Claims validateToken(String token) {
		return Jwts.parserBuilder().setSigningKey(getSigningKey()).build().parseClaimsJws(token).getBody();
	}

	public Integer getIdUsuarioFromToken(String token) {
		Claims claims = validateToken(token);
		return claims.get("id_usuario", Integer.class);
	}

	public String getCorreoFromToken(String token) {
		Claims claims = validateToken(token);
		return claims.get("correo_electronico", String.class);
	}

	public String extractTokenFromHeader(String authorizationHeader) {
		if (authorizationHeader == null || !authorizationHeader.startsWith("Bearer ")) {
			throw new RuntimeException("Token no proporcionado o inválido");
		}

		return authorizationHeader.substring(7);
	}
}