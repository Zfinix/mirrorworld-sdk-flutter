# Mirror World Flutter SDK

A Mirror World UnOfficial Flutter SDK that combines offical [android](https://github.com/mirrorworld-universe/mirrorworld-sdk-android) and [ios](https://github.com/mirrorworld-universe/mirrorworld-sdk-android) SDKs

## Getting started

Create a developer account on the [Developer dashboard](https://app.mirrorworld.fun). Create project and create an API Key.

## Android setup

- Config CustomTab!
   If you want to use CustomTab to show content to users (Recommended), you need to configure the following on your AndroidManifest.xml:

**Add permission for internet**
```xml
<uses-permission android:name="android.permission.INTERNET" />
```

**Register this activity**
```xml
<activity
    android:name="com.mirror.sdk.activities.RedirectActivity"
    android:exported="true">

    <intent-filter>
        <action android:name="android.intent.action.VIEW"/>
        <category android:name="android.intent.category.DEFAULT"/>
        <category android:name="android.intent.category.BROWSABLE"/>
        <data android:scheme="mwsdk"/>
    </intent-filter>
</activity>
```

The final file would look like this:
```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    package="com.mirror.mirrorworld_sdk_android">

    <uses-permission android:name="android.permission.INTERNET" />

    <application
        android:allowBackup="true"
        android:dataExtractionRules="@xml/data_extraction_rules"
        android:fullBackupContent="@xml/backup_rules"
        android:icon="@mipmap/ic_launcher"
        android:label="@string/app_name"
        android:networkSecurityConfig="@xml/network_security_config"

        android:roundIcon="@mipmap/ic_launcher_round"
        android:supportsRtl="true"
        android:theme="@style/Theme.Mirrorworldsdkandroid"
        tools:targetApi="31">
        <activity
            android:name=".MainActivity"
            android:launchMode="singleTask"
            android:exported="true">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>


        <activity
            android:name="com.mirror.sdk.activities.RedirectActivity"
            android:exported="true">

            <intent-filter>
                <action android:name="android.intent.action.VIEW"/>
                <category android:name="android.intent.category.DEFAULT"/>
                <category android:name="android.intent.category.BROWSABLE"/>
                <data android:scheme="mwsdk"/>
            </intent-filter>
        </activity>
    </application>

</manifest>
```

You should now see CustomTab when you try to open our prepared web page.

>*Tips: If you want your app to have only one task, you can set your own activity to SingTast:*
>```xml
>android:launchMode="singleTask"
>```
And finally,your activity config may like this:
```xml
<activity
    android:name=".MainActivity"
    android:launchMode="singleTask"
    android:exported="true">
    <intent-filter>
        <action android:name="android.intent.action.MAIN" />
        <category android:name="android.intent.category.LAUNCHER" />
    </intent-filter>
</activity>
```

## Usage


## Import SDK
