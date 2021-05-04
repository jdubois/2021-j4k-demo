package com.microsoft.devrel.j4kdemo;

import static com.tngtech.archunit.lang.syntax.ArchRuleDefinition.noClasses;

import com.tngtech.archunit.core.domain.JavaClasses;
import com.tngtech.archunit.core.importer.ClassFileImporter;
import com.tngtech.archunit.core.importer.ImportOption;
import org.junit.jupiter.api.Test;

class ArchTest {

    @Test
    void servicesAndRepositoriesShouldNotDependOnWebLayer() {
        JavaClasses importedClasses = new ClassFileImporter()
            .withImportOption(ImportOption.Predefined.DO_NOT_INCLUDE_TESTS)
            .importPackages("com.microsoft.devrel.j4kdemo");

        noClasses()
            .that()
            .resideInAnyPackage("com.microsoft.devrel.j4kdemo.service..")
            .or()
            .resideInAnyPackage("com.microsoft.devrel.j4kdemo.repository..")
            .should()
            .dependOnClassesThat()
            .resideInAnyPackage("..com.microsoft.devrel.j4kdemo.web..")
            .because("Services and repositories should not depend on web layer")
            .check(importedClasses);
    }
}
