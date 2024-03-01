# README

# Deployment Guide for Sealant-On-Rails

Welcome to the deployment guide for the "Sealant-On-Rails" application. This document provides comprehensive 
instructions for deploying the application both locally and on Heroku.

## Prerequisites
- Git
- Ruby 3.2.2
- Rails 7.1.1
- Heroku CLI
- Google Cloud Console account

## Local System Setup
Install the following dependencies on your local machine:

### Ruby
Install Ruby 3.2.2 using Ruby version manager
```bash
rvm install 3.2.2
```

### Rails
Install Rails 7.1.1
```bash
gem install rails -v 7.1.1
```

## Local Deployment

### Step 1: Fork the Repository
Fork the repository to your GitHub account.

### Step 2: Clone the new Forked Repository
Clone the Forked repository to your local machine:

```bash
git clone [forked-repository-url]
```

### Step 3: Install Dependencies
Install the dependencies for the application:

```bash
bundle install
```

**You will face an error here regarding Rails not being able to decrypt the credentials file.
The reason is because you have cloned the repository and the master key is not the same as the one used to encrypt the credentials file.
Follow the next steps to resolve it.**

### Step 4: Generate a New Master Key
```bash
rails credentials:edit
```
This will generate a new master key and open the credentials file in the editor.

### Step 5: Delete the Old credentials.yml.enc File
```bash
rm config/credentials.yml.enc
```

### Step 6: Edit the Credentials For MAC
```bash
EDITOR="vim" rails credentials:edit
```
**OR**
### Step 6: Edit the Credentials For Linux
```bash
 $env:EDITOR="code --wait"
 rails credentials:edit
```

## Setup Google OAuth On Google's End

This section walks you through setting up Google OAuth for the application in the Google Developer Console.
Here are the steps and important information:

### Step 1: Create a New Project in Google Developer Console
1. Go to the [Google Developer Console](https://console.developers.google.com/).
1. Select or create a project for your application, giving it a name like "Testing-Rails-Application."

### Step 2: Set Up OAuth Consent Screen
1. In your project, navigate to "APIs & Services" and click on "OAuth consent screen."
1. Set the user type to "Internal" for only @tamu.edu accounts or "External" for any @gmail account.
1. Fill out the required information on the consent screen. You need to provide the app name, user support email, and developer contact information.
1. Save your changes.

### Step 3: Add Scopes
1. Add `userinfo.email` and `userinfo.profile`
1. Click "Save and Continue."

### (Optional) Step 4: Add Test Users
You can add test users who are allowed to log in to your application. This means that only the email addresses you add here can access your application.
If you choose to add test users, do so on this page and click "Save and Continue."

### Step 5: Create OAuth Client ID
1. On the dashboard, Click "Credentials" > "Create Credentials" > "OAuth client ID."
2. Select "Web application" type.
3. Give your application a name.
4. Under "Authorized redirect URIs," add the following:
    * `http://localhost:3000/auth/google_oauth2/callback`
    * `http://127.0.0.1:3000/auth/google_oauth2/callback`
    * `https://[heroku-app-name].herokuapp.com/auth/google_oauth2/callback`
5. Click "Create."
6. You will receive a client ID and client secret. **Save this information.**
7. Ensure that your client ID is enabled.

By following these steps, you have set up the necessary configurations in the Google Developer Console
to enable Google OAuth for the application. This allows the app to authenticate users using their Google accounts.

## Add OAuth ID and Secret to Rails Credentials
### Step 7: Add Your Google OAuth Credentials
```bash
google:
  client_id: your_client_id
  client_secret: your_client_secret
```

*Note: Replace `your_client_id` and `your_client_secret` with your own Google OAuth credentials. Do not include any quotes around the actual credentials.*

After adding your credentials, save the changes and exit the editor.

Now, your Google OAuth credentials are securely stored in the Rails credentials file and your application will be able to use them for authentication. Make sure to keep your credentials safe and secret.  **NEVER** commit plaintext credentials and **NEVER NEVER NEVER** commit the `master.key` file (`/config/master.key` is already in the `.gitignore` file for your safety).

### Step 8: Whitelist Tester's Email
In the `seed.rb` file, add your email to the list of whitelisted emails.
Just follow the format of the other emails in the list.
Do not forget to add the role `Admin` to your email.
Otherwise you wont be able to access the admin whitelist email dashboard.
The code is dynamic, so you can add as many emails as you want.

Run the rails db:seed command to seed the database with the whitelisted emails:
```bash
rails db:seed
```

### Step 9: Start the Application
Run the Rails server:
```bash
rails s
```

Your application should now be accessible on your local machine.

## Deployment on Heroku

### Step 1: Create or Find an Organization on Heroku
Ensure you have an organization on Heroku that can access your GitHub repository.

### Step 2: Set Up the Heroku Application
- Create a new app on Heroku.
- Ensure you are using `heroku-22` and `ruby-3.2.2`.
- Add `Heroku Postgres` to your resources for database functionality.

### Step 3: Connect to GitHub
In the Heroku app's deploy tab, select `GitHub CLI connect` and connect to your repository.

### Step 4: Heroku CLI Configuration
Log in to Heroku via the terminal and set up your master key:
```bash
heroku login
heroku config:set RAILS_MASTER_KEY=`cat config/master.key` -a <heroku-app-name>
```

### Step 5: Deploy Your Application
In the deploy section of your Heroku app, click 'Deploy' to start the deployment process.

## Project Details

Revolutionizing dental sealant program: Replace paper-based data with interactive software for Texas A&M School of Dentistry. #HealthTech

Project Name: School Sealant Program Data Management System

Organization: Texas A&M School of Dentistry

Contact (Project Director): Dr. Amal Noureldin (anoureldin@tamu.edu)

Contact (Project Developer 1): Jaydeep (jdr@tamu.edu)

Contact (Project Developer 2): Apurva (apurva.mandalika@tamu.edu)

Contact (Project Developer 3): Manisha (mpanda27@tamu.edu)

Contact (Project Developer 4): Sarah (sgullion@tamu.edu)

Contact (Project Developer 5): Sushant (sushant.shelar@tamu.edu)

Contact (Project Developer 6): Jay (jaynehete@tamu.edu)

Description:

The Texas A&M School of Dentistry oversees a Sealants Program dedicated to providing free dental sealants to elementary school children. Currently, the program relies on paper-based data collection sheets for dental screening and charting, with manual data entry into Excel sheets stored on Microsoft Teams. We are embarking on a project to revolutionize this process with an interactive software application.

Project Goals:

Our primary objectives are as follows:

Efficient Data Capture: Develop a user-friendly software or app that allows faculty and students to digitally capture data during dental screenings and sealant applications. Automated Data Entry: Implement a feature that auto-populates numerical data to eliminate manual data entry errors and streamline the process. Data Analysis: Provide quick and interactive analysis tools to evaluate the effectiveness of our School Sealant Program. Additional Information:

Currently, our faculty and students visit elementary schools to conduct dental screenings and apply sealants to children. Data collected during these visits is recorded on paper forms, creating a cumbersome manual entry process for our program coordinator. The envisioned software or app will simplify this workflow and enhance data security.

Key Features:

User-friendly interface for data capture during dental screenings. Automation of data entry to reduce errors and save time. Robust analysis tools for evaluating program effectiveness. Secure data storage and access control to protect sensitive information. Compliance with best practices in Behavior-Driven Development (BDD) and Test-Driven Development (TDD). Technology Stack:

The project will be developed using Ruby on Rails, as recommended by Prof. Ritchey, to ensure functionality and security. We will focus on designing a system with security as a core element from the outset, safeguarding Personally Identifiable Information (PII) at rest and restricting access to authorized users.

By investing in this School Sealant Program Data Management System, we aim to enhance the efficiency of our program, improve data accuracy, and ultimately provide better dental care to elementary school children. Your support and collaboration are essential to making this project a success.

For further details, including project specifications and outcome measures, please feel free to contact Dr. Amal Noureldin (anoureldin@tamu.edu). We are excited to embark on this journey toward a more effective and secure data management solution for our School Sealant Program.
