>>  For setup this project you need to require php 8 version and laravel 9 version.

Step 1 :: 
			git clone https://github.com/tatariyaromil/aspire.git
			Run this command and setup project.
            
Step 2 ::
			create database and set in env file
			or copy aspire.sql file from database folder

Step 3 ::
			run this command 
			composer install
			
Step 4 :: 	
			php artisan migrate
			run this command

Step 5 :: 
			For admin i have create on seeder so please run below command
			php artisan db:seed --class=UserSeeder

Step 6 :: 
			Please check postman collection for more api details
			Postman collection you can find on root folder of this project :: Aspire.postman_collection

You can fined admin credentials on userSeeder file.

NOTE :: In postman collection i have set global veriable for authentication and url please set accounding you domain name.

Suggestions: There are many things we can achieve for this project, like adding crons to determine the customer's loan repayment date and sending them an email with the details. There are others things we can achieve, too, but it will take me some time to accomplish them."

Contact me if youfacing any issue 
What's App :: +91 9510195111.
Email :: tatariyaromil@gmail.com.
			
