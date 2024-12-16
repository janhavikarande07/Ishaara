# Ishaara

<img src="https://github.com/user-attachments/assets/cb8e6b1f-61c6-41ef-a015-2077c33d92b3" alt="ishaara_logo" width="100" height="auto">

# Project Overview

This repository contains two folders:

1. **Ishaara app**: The Flutter app for client-side operations.  
2. **Ishaara server**: The Flask server backend for the model.


# 🚀 Project Setup Guide  

This guide explains the steps to set up the Flutter project and Flask Server and get the app running.

---

## 📝 Table of Contents  
1. [Flutter Setup](#flutter-setup)  
2. [Server Setup](#server-setup)  
3. [Connecting Flutter to the Server](#connecting-flutter-to-the-server)  
4. [App Installation](#App Installation)  

---

## 🌟 Flutter Setup  

### 1. Open the Flutter Project  
- Open the Flutter project in **Android Studio**.  

---

### 2️. Download Dependencies  

1. Go to the `pubspec.yaml` file.  
2. Click on **Pub Get** to download all the dependencies.  
3. Check for errors in the Dart files.  

<img src="https://github.com/user-attachments/assets/2d4e1df8-acd7-48aa-81c2-ee9a927f7643" alt="ishaara_logo" width="100" height="auto">  
---

### 3️⃣ Generate SHA Fingerprints  

1. Open the terminal in Android Studio.  
   <img src="https://github.com/user-attachments/assets/62d3539c-d570-4510-87d3-0f183fa3c6f7" alt="ishaara_logo" width="100" height="auto">  
3. Navigate to the `android` folder:  
   ```bash  
   cd android

4. Run the following command to generate the SHA fingerprints:
   ```bash
   ./gradlew signingReport
5. Copy the SHA-1 and SHA-256 fingerprints from the output.  
   <img src="https://github.com/user-attachments/assets/5b57f991-38d4-4758-8852-a8f375100818" alt="ishaara_logo" width="100" height="auto">  
6. Go to your Firebase Console:  
   i. Select your project.  
   ii. Navigate to Project Settings > General > Your Apps > Android App.  
   <img src="https://github.com/user-attachments/assets/f2ca30c3-f5a3-4d8d-87a2-786f7e558ede" alt="ishaara_logo" width="100" height="auto">  
   iii. Paste the copied SHA-1 and SHA-256 fingerprints in the respective fields.  
   <img src="https://github.com/user-attachments/assets/cd6dcc3a-1e35-4134-aced-34a0f4640544" alt="ishaara_logo" width="100" height="auto">  
   iv. Save the changes.  

## 🌟 Server Setup  

### 1. Open the Flutter Project  
- Open the server folder in VS Code or your preferred editor.  
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

3. Install Dependencies  
- Use the requirements.txt file to install the required modules:
  ```bash
  pip install -r requirements.txt  

4. Run the Server  
- Run the Flask server using:
   ```bash
   python app.py  


