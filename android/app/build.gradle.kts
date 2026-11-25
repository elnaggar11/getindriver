import java.util.Properties

plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    id("com.google.firebase.crashlytics")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val useDebugSigning = providers.gradleProperty("useDebugSigning").orNull == "true"
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (!useDebugSigning && keystorePropertiesFile.isFile) {
    keystorePropertiesFile.inputStream().use { keystoreProperties.load(it) }
}

val missingSigningProperties = listOf("storeFile", "storePassword", "keyAlias", "keyPassword")
    .filter { keystoreProperties.getProperty(it).isNullOrBlank() }

if (!useDebugSigning && missingSigningProperties.isNotEmpty()) {
    val signingError = "Set ${missingSigningProperties.joinToString()} in android/key.properties " +
        "to sign a release. For local testing, run " +
        "ORG_GRADLE_PROJECT_useDebugSigning=true flutter build apk --release."
    tasks.configureEach {
        if (name == "preReleaseBuild" || name == "validateSigningRelease") {
            doFirst { throw GradleException(signingError) }
        }
    }
}

  android {
              
    namespace = "com.getin.driver"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
      sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
   isCoreLibraryDesugaringEnabled = true

    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.getin.driver"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties.getProperty("keyAlias")
            keyPassword = keystoreProperties.getProperty("keyPassword")
            storeFile = keystoreProperties.getProperty("storeFile")?.takeIf { it.isNotBlank() }?.let { file(it) }
            storePassword = keystoreProperties.getProperty("storePassword")
        }
    }
    buildTypes {
              
        release {
            signingConfig = signingConfigs.getByName(if (useDebugSigning) "debug" else "release")

            
            // Enable R8 code shrinking and optimization
            isMinifyEnabled = true
            // Enable resource shrinking (removes unused resources)
            isShrinkResources = true
            // Use ProGuard rules for optimization
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
    
 
}


flutter {
    source = "../.."
}
dependencies {
    implementation(platform("com.google.firebase:firebase-bom:33.4.0"))
    implementation("com.google.firebase:firebase-messaging")
    implementation("com.google.firebase:firebase-crashlytics")

    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
}
