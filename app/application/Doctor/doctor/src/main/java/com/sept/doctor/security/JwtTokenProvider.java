package com.sept.doctor.security;

import com.sept.doctor.model.Doctor;

import io.jsonwebtoken.*;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Component
public class JwtTokenProvider {

    // Generate the token

    public String generateToken(Authentication authentication) {
        Doctor doctor = (Doctor) authentication.getPrincipal();
        Date now = new Date(System.currentTimeMillis());

        Date expiryDate = new Date(now.getTime() + SecurityConstant.EXPIRATION_TIME);

        String userId = Long.toString(doctor.getId());

        Map<String, Object> claims = new HashMap<>();
        claims.put("id", (Long.toString(doctor.getId())));
        claims.put("username", doctor.getUsername());

        return Jwts.builder()
                .setSubject(userId)
                .setClaims(claims)
                .setIssuedAt(now)
                .setExpiration(expiryDate)
                .signWith(SignatureAlgorithm.HS512, SecurityConstant.SECRET)
                .compact();
    }

    // Validate the token
    public boolean validateToken(String token) {
        try {
            Jwts.parser().setSigningKey(SecurityConstant.SECRET).parseClaimsJws(token);
            return true;
        } catch (SignatureException ex) {
            System.out.println("Invalid JWT Signature");
        } catch (MalformedJwtException ex) {
            System.out.println("Invalid JWT Token");
        } catch (ExpiredJwtException ex) {
            System.out.println("Expired JWT token");
        } catch (UnsupportedJwtException ex) {
            System.out.println("Unsupported JWT token");
        } catch (IllegalArgumentException ex) {
            System.out.println("JWT claims string is empty");
        }
        return false;
    }

    // Get user Id from token

    public Long getUserIdFromJWT(String token) {
        Claims claims = Jwts.parser().setSigningKey(SecurityConstant.SECRET).parseClaimsJws(token).getBody();
        String id = (String) claims.get("id");

        return Long.parseLong(id);
    }
}
