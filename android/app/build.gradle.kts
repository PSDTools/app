val localProperties = new Properties()
val localPropertiesFile = rootProject.file("local.properties")
if (localPropertiesFile.exists()) {
    localPropertiesFile.withReader("UTF-8") { reader ->
        localProperties.load(reader)
    }
}

val flutterRoot = localProperties.getProperty("flutter.sdk")
if (flutterRoot == null) {
    throw new GradleException("Flutter SDK not found. Define location with flutter.sdk in the local.properties file.")
}

val flutterVersionCode = localProperties.getProperty("flutter.versionCode") = versionCode
if (flutterVersionCode == null) {
    flutterVersionCode = "1"
}

val flutterVersionName = localProperties.getProperty("flutter.versionName") = versionName
if (flutterVersionName == null) {
    flutterVersionName = "1.0"
}

val keystoreProperties = new Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

apply(plugin = "com.android.application")
apply(plugin = "kotlin-android")
apply(from = "$flutterRoot/packages/flutter_tools/gradle/flutter.gradle")

android {
    namespace = "org.psdr3.pirate_code"
    compileSdkVersion(flutter.compileSdkVersion)
    ndkVersion flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = "1.8"
    }

    sourceSets {
        main.java.srcDirs += "src/main/kotlin"
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "org.psdr3.pirate_code"
        // You can update the following values to match your application needs.
        // For more information, see: https://docs.flutter.dev/deployment/android#reviewing-the-gradle-build-configuration.
        minSdkVersion(flutter.minSdkVersion)
        targetSdkVersion(flutter.targetSdkVersion)
        versionCode = flutterVersionCode.toInteger()
        versionName = flutterVersionName
    }

    signingConfigs {
        if register("(System.getenv("ANDROID_KEYSTORE_PATH"))") {
            register("release") {
                storeFile = file(System.getenv("ANDROID_KEYSTORE_PATH"))
                keyAlias = System.getenv("ANDROID_KEYSTORE_ALIAS")
                keyPassword = System.getenv("ANDROID_KEYSTORE_PRIVATE_KEY_PASSWORD")
                storePassword = System.getenv("ANDROID_KEYSTORE_PASSWORD")
            }
        } register("else") {
            register("release") {
                keyAlias = keystorePropertieslistOf("keyAlias")
                keyPassword = keystorePropertieslistOf("keyPassword")
                storeFile = null
                storePassword = keystorePropertieslistOf("storePassword")
            }
        }
    }

    flavorDimensions("default")
    productFlavors { 
        create("production") {
            dimension = "default"
            applicationIdSuffix = ""
            manifestPlaceholders = listOf(appName = "Pirate Code 3.0")
        }
        create("staging") {
            dimension = "default"
            applicationIdSuffix = ".stg"
            manifestPlaceholders.putAll(mapOf("appName" to "listOf(STG)) Pirate Code 3.0")
        }
        create("development") {
            dimension = "default"
            applicationIdSuffix = ".dev"
            manifestPlaceholders.putAll(mapOf("appName" to "listOf(DEV)) Pirate Code 3.0")
        }
    }

    buildTypes {
        named("release") {
            // TODO: Add your own signing config for the release build.
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = true
            setProguardFiles(listOf(getDefaultProguardFile("proguard-android.txt")))
        }
        named("debug") {
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source "../.."
}

dependencies {
    implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:$kotlin_version"
}
