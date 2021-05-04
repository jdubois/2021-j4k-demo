package com.microsoft.devrel.j4kdemo;

import com.microsoft.devrel.j4kdemo.J4KdemoApp;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
import org.springframework.boot.test.context.SpringBootTest;

/**
 * Base composite annotation for integration tests.
 */
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@SpringBootTest(classes = J4KdemoApp.class)
public @interface IntegrationTest {
}
