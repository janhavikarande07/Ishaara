<img src="https://github.com/user-attachments/assets/cb8e6b1f-61c6-41ef-a015-2077c33d92b3" alt="ishaara_logo" width="100" height="auto">

# Project Overview

This repository contains two folders:

1. **Ishaara app**: The Flutter app for client-side operations.  
2. **Ishaara server**: The Flask server backend for the model.
  

# 🚀 Project Setup Guide  

This guide explains the steps to set up the Flutter project and Flask Server and get the app running.
##

## 📝 Table of Contents  
1. [Flutter Setup](#flutter-setup)  
2. [Server Setup](#server-setup)  
3. [Connecting Flutter to the Server](#connecting-flutter-to-the-server)  
4. [App Installation](#app-installation)  

##

## 🌟 Flutter Setup  
  
### 1. Open the Flutter Project  
- Open the Flutter project in **Android Studio**.  

##

### 2️. Download Dependencies  
<img src="https://github.com/user-attachments/assets/31430918-cf3a-4ea4-9ff8-1cb4554410c8" alt="ishaara_logo" height="300">  

   1. Go to the `pubspec.yaml` file.  
   2. Click on **Pub Get** to download all the dependencies.  
   3. Check for errors in the Dart files.  

##

### 3️. Generate SHA Fingerprints  

 <img src="https://github.com/user-attachments/assets/df67608c-78be-4168-abdb-79f58bfdccfa" alt="ishaara_logo" height="300">    
 
1. Open the terminal in Android Studio.  
  
3. Navigate to the `android` folder:  
   ```bash  
   cd android

4. Run the following command to generate the SHA fingerprints:  
   ```bash
   ./gradlew signingReport
   ```
    <img src="https://github.com/user-attachments/assets/a4cdbfc3-434f-46f6-b789-9e63bce1af2b" alt="ishaara_logo" height="300">  

5. Copy the SHA-1 and SHA-256 fingerprints from the output.  
  
6. Go to your Firebase Console:
   
   i. Select your project.  
    <img src="https://github.com/user-attachments/assets/7e26c006-1103-4fb8-b729-4f640360ea67" alt="ishaara_logo" height="300">
   
   ii. Navigate to Project Settings > General > Your Apps > Android App (Scroll down in General Tab).
   
    <img src="https://github.com/user-attachments/assets/cd6dcc3a-1e35-4134-aced-34a0f4640544" alt="ishaara_logo" height="300">  
    
   iii. Paste the copied SHA-1 and SHA-256 fingerprints in the respective fields.  
   iv. Save the changes.  

## 🌟 Server Setup  

### 1. Open the Flutter Project  
- Open the server folder in VS Code or your preferred editor.  
 <img src="https://github.com/user-attachments/assets/fad113e2-0a53-4b61-b6e5-f3cfae98f842" alt="ishaara_logo" height="300">

- Open a new terminal.

##
### 2. Create a Virtual Environment  
1. Run the following command to create a virtual environment:  

  ```bash
   python -m venv venv
  ```
2. Activate the virtual environment:  
- Windows:
   ```bash
   .\venv\Scripts\activate  
- Mac/Linux:
   ```bash
   source venv/bin/activate  

##
### 3. Install Dependencies  
- Use the requirements.txt file to install the required modules:  
  ```bash
  pip install -r requirements.txt  
##
### 4. Run the Server  
- Run the Flask server using:  
   ```bash
   python app.py  
##
### 5. Wi-Fi Role  
- Ensure your server is running on the same Wi-Fi network as your mobile phone.  
   <img src="https://github.com/user-attachments/assets/4fd6cae0-0589-4e4c-b823-63c6a87177ea" alt="ishaara_logo" height="300">  
- The Flask server will generate a URL with your system's IP address. Copy this URL.  

## 🌟 Connecting Flutter to the Server  
### 1. Update values_.dart  
 <img src="https://github.com/user-attachments/assets/90fe109d-421c-4523-937a-d7e2930a5653" alt="ishaara_logo" height="300">  
1. In the Flutter project, go to the lib folder.  

2. Open the values_.dart file.  
3. Update the ip_address variable with the copied server URL.  

### 2. Connect Your Mobile Device  
- Ensure your mobile phone is connected to the same Wi-Fi network as the server.  

## 🌟 App Installation  
 ### 1. Build the APK  

  <img src="https://github.com/user-attachments/assets/1a9829f7-2239-40cd-94ed-f07fbc07deb3" alt="ishaara_logo" height="300">  
  
1. Once Firebase is set up, go to the Build option in the menu bar.  
Select Build > Flutter > Build apk.  
2. The generated APK will be located in the following subfolder of your flutter project:  
 build/app/outputs/flutter-apk/app-release.apk  
##
 ### 2. Install and Test the App  
1. Transfer the generated APK to your mobile phone and install it.  
2. Launch the app and ensure it communicates with the server correctly.  


