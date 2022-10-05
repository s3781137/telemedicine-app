package com.sept.doctor.security;

import java.util.Arrays;
import java.util.List;

import org.springframework.http.HttpMethod;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.security.web.util.matcher.OrRequestMatcher;
import org.springframework.security.web.util.matcher.RequestMatcher;

public class SecurityConstant {

        public static final String SIGN_UP_URLS = "/doctor/**";
        public static final String H2_URL = "/h2-console/**";
        public static final String SECRET = "SecretKeyToGenJWTs";
        public static final String TOKEN_PREFIX = "Bearer ";
        public static final String HEADER_STRING = "Authorization";
        public static final long EXPIRATION_TIME = 30000; // 30 seconds

}
