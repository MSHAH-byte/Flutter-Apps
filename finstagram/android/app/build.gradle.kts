// android/app/build.gradle.kts
plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    // START: Firebase Configuration
    // Apply the Google services Gradle plugin to enable Firebase services
    id("com.google.gms.google-services") // <-- ADD THIS LINE
    // END: Firebase Configuration
}

android {
    namespace = "com.example.finstagram"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.finstagram"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 23
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

// START: Firebase Dependencies
// THIS IS THE DEPENDENCY SECTION YOUR INSTRUCTOR WAS LIKELY REFERRING TO
dependencies {
    // Import the Firebase BoM (Bill of Materials) to manage Firebase library versions
    // Always use the latest BOM version for compatibility.
    implementation(platform("com.google.firebase:firebase-bom:34.0.0")) // <-- ADD THIS LINE, USE LATEST VERSION

    // Add the dependencies for the Firebase products you want to use in your app.
    // When using the BoM, you do NOT specify versions for individual Firebase libraries.
    implementation("com.google.firebase:firebase-auth")       // For Firebase Authentication
    implementation("com.google.firebase:firebase-firestore")  // For Cloud Firestore
    implementation("com.google.firebase:firebase-storage")    // For Firebase Storage
    implementation("com.google.firebase:firebase-analytics")  // Recommended for all Firebase projects

    // Other existing Flutter dependencies (if any, typically not here by default)
    // For example:
    // testImplementation("junit:junit:4.13.2")
    // androidTestImplementation("androidx.test.ext:junit:1.1.5")
    // androidTestImplementation("androidx.test.espresso:espresso-core:3.5.1")
}
// END: Firebase Dependencies