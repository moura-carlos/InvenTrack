# README

README with instructions for setting up and running the app locally.
# README
---
## Table of contents
* [General info](#general-info)
* [Technologies](#technologies)
* [Setup](#setup)
* [Features](#features)
* [Admin dashboard](#admin-dashboard)
* [Modeling](#modeling)
* [Status](#status)
* [Testing the deployed application](#testing-the-deployed-application)
* [On production](#on-production)
***
## General info
### InvenTrack.
Inventory app for the CTD LABS Ruby on Rails Apprenticeship Application Assignment.
***
---
## Technologies
The project is created with/makes use of:
* Bundler version 2.4.4
* Git
* Ruby on Rails version 7.0.4.2
* Ruby version 3.1.2p20
* Sendinblue mail server.
* Scalingo - Deployment
* PostgreSQL 12 (Production Environment) & Sqlite3 (Development Environment)
---
## Setup
To run this project - locally - on your machine:
```
$ cd your-folder/anotherpin
$ bundle install
$ yarn install
$ rails db:create
$ rails db:migrate
$ rails db:seed
$ rails server
```
If you want to be able to **notify users via email** when an item in their inventory is out of stock:
 * Create an account on the [Sendinblue website](https://www.sendinblue.com/).
 *  On your dashboard, click on [SMTP & API](https://account.sendinblue.com/advanced/api).
 *  Click on the button "Generate a new SMTP key"
    * Then, when prompted, give a name to your `SMTP key`
      * I gave it the same name as the application, `inventrack`
      * Hit `generate/create`
      * Copy the value of your SMTP key
        * Save this key in a secure location, you'll not be able to see it again.
 * Also copy the `username` (likely the email you used to create your account) from your [dashboard](https://app.sendinblue.com/settings/keys/smtp)
   * Save this key in a secure location.
 * Open your credentials file running the following command:
	+  In the example below I used the VS Code editor to edit my credentials, you can replace "code" with your text editor of preference.
	+ ```$ EDITOR="code --wait" rails credentials:edit```
```
	 secret_key_base: this_will_have_a_value_here
	 sendinblue_username: add_your_sendinblue_username_from_dashboard_here
	 sendinblue_password: add_your_sendinblue_secret_password_from_dashboard_here
```
* Replace
  * `add_your_sendinblue_username_from_dashboard_here` with your `username` you just copied.
  * `add_your_sendinblue_secret_password_from_dashboard_here` with your `SMTP key` you just copied.
* Close the `credentials` file.

 [Copy the gmail configuration](https://guides.rubyonrails.org/action_mailer_basics.html#action-mailer-configuration-for-gmail) replacing the necessary parts.
 Make sure to paste it in both development.rb and production.rb files
   ```
   config/environments/development.rb
   config/environments/production.rb
   ```
  * Here is how you can modify the code to use in this application, paste the code at the end of `config/environments/development.rb` and `config/environments/production.rb` files, right before the `end` keyword.
    * Get the value for `port` from the sendinblue website [dashboard](https://app.sendinblue.com/settings/keys/smtp), indicated by the `Port` label.
    * Get the value for `address` from the sendinblue website [dashboard](https://app.sendinblue.com/settings/keys/smtp), indicated by the `SMTP Server` label.
    * ```
      config.action_mailer.delivery_method = :smtp
      config.action_mailer.smtp_settings = {
        address:              'smtp-relay.sendinblue.com',
        port:                 587,
        domain:               'inventrack.com',
        user_name:            Rails.application.credentials[:sendinblue_username],
        password:             Rails.application.credentials[:sendinblue_password],
        authentication:       'plain',
      enable_starttls_auto: true,
        open_timeout:         5,
        read_timeout:         5 }
        ```
  If you want to learn more about custom credentials and how to use them on your code, read more on [this tutorial](https://guides.rubyonrails.org/security.html#custom-credentials).

If you want to be able to **store your image files in the production environment using amazon AWS S3**:
You can follow [this tutorial](https://pragmaticstudio.com/tutorials/using-active-storage-in-rails) or the steps bellow:
 * Go to the [amazon aws website](https://aws.amazon.com/) and create a new account.
 * Once logged in, click on **"IAM"** (Identity Account Management)
	 * Set up a new user - Select **Programmatic Access**
	 * Create a new group - Select **AmazonS3FullAccess**
	 * On the Review Page, click on **Create New User**
		 * This will give you an **Access key ID** and also a **Secret access key**, they are like a username and a password for **S3**
		 * Make sure to copy both and save them somewhere so that we can use them to set up our Rails AWS credentials.
* Now, look for the service **"S3"** and click on it.
	* Click on **Create bucket**, give it a name, leave the region as it is - use the default.
	* Copy and **save the bucket name** where you saved the other two AWS keys/credentials.
	* In manage public permissions, make sure you select **grant public read access to your bucket**
	* Make the bucket public by default.
	* You can follow the instructions on this answer [here](https://stackoverflow.com/a/70603995) to make sure you allow ACLs and AWS S3 can be properly used with your deployed app on Scalingo or Heroku.
* Open the file where you temporarily saved your AWS credentials you copied from the AWS website (**Access key ID**, **Secret access key**, **your bucket's name**) so that we can add them to our Rails application credentials file.
 * Open your credentials file running the following command:
	+  In the example below I used the VS Code editor to edit my credentials, you can replace "code" with your text editor of preference.
	+ ```$ EDITOR="code --wait" rails credentials:edit```
```
	 secret_key_base: this_will_have_a_value_here
		 aws:
			 aws_access_key_id: add_your_aws_access_key_here
			 aws_secret_access_key: add_your_aws_secret_access_key_here
```
 * Save and close your credentials file, now your API keys are safely stored and can be indirectly referenced in your Rails application as explained in the following Rails [documentation](https://guides.rubyonrails.org/security.html#custom-credentials).
Go to `config/storage.yml`
  * Uncomment the Amazon service in the config/storage.yml file
  * Set the region and the name of the bucket where you want uploaded images to be stored
    * Use the information `region` and `name` information from when you created the bucket.
Configure Active Storage to use Amazon S3 in the production environment.
 * Go to `config/environments/production.rb`
  * switch the ActiveStorage service from local to amazon
    *```config.active_storage.service = :amazon```
When running in production, example on Scalingo, the app needs to read the AWS S3 credentials which are encrypted in `config/credentials.yml.enc`. In order to decrypt it we need to do the following:
* Go to [Scalingo dashboard](https://dashboard.scalingo.com/) click to `add new variable`
  * set `name` to `RAILS_MASTER_KEY`
  * set the `value` to the value inside `master.key` file
* install the AWS gem
 * Paste the following into the Gemfile:
  * `gem "aws-sdk-s3", require: false`
 * Run `bundle install`
 * Add and commit changes and then push them to GitHub
 * Here is a [video](https://www.youtube.com/watch?v=p435mSL6kqc) on how to deploy your web-app using Scalingo.
***
## Features
* As an admin, I can
	* Create/Read/Update/Delete admin users.
  * Create/Read/Update/Delete regular users.
	*  Create/Read/Update/Delete all items.
	*  Create/Read/Update/Delete all categories.
* As a regular user, I can
	* Create/Read/Update/Delete a my own account.
	* Create/Read/Update/Delete items authored by myself.
	* Create categories.
---
## Admin dashboard
* To access the admin dashboard you have to type ```/admin``` after the website full domain, for example, **https://example.com/admin**.
* The current crendetials to access the admin dashboard are:
	```
	login: admin@example.com"
	password: password
	```
* If you wish to add more admins to the app, go to ```confi/seeds.rb``` and add your new admin information. After that, save the file and run ```rails db:seed``` ( or ```scalingo run rails db:seed```if you wish to save those changes to the production app ) to add the new admin to the database.
* Remember that before you can push new code to ```scalingo```you have to ```git commit``` and ```git push``` to your GitHub repository first. So, after making those local changes, commit and push your code to GitHub and then you will be able to run ```git push scalingo main```  and the new changes will be present in your production app.
---
## Modeling
* Category -   has_many item_categories, and has many items through item_categories
* ItemCategory - belongs to item, belongs to category
* Item - has many item categories, has many categories through item categories
* User - has many items
***
## Status
* This project is complete, but I am still thinking of features to improve it.
***
## Testing the deployed application
* Go to the website: [InvenTrack](https://inventrack.osc-fr1.scalingo.io/)
* Log in as and admin with:
  ```
  email: user@example.com
  password: password
  ```
## On production
Make sure you set your Rails Master Key value for Scalingo so that it knows how to read your encrypted API keys.
* You can read the following [tutorial](https://doc.scalingo.com/platform/app/environment) to do so.
