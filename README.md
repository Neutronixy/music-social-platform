Home to the codebase of a dynamic music streaming social network that connects users through their love of music. Here, you'll find everything that powers our community's ability to explore, share, and discuss their favorite tunes and podcasts.

....

Instructions on how to run the system (same info in README.md) 

I used MySQL with a collation utf8mb4_unicode_ci that allows case insensitive and supports a wide range of language sets. Considering the specific filtering requirements, other collations may not be suitable. 

To run the system locally I used phpMyAdmin on a windows machine. I used XAMP (xampp-windows-x64-8.2.0-0-VS16-installer.exe). I created a database called 40386172 (utf8mb4_unicode_ci) and imported the file from: 

.\stacksofwax\database\40386172.sql 

 

To use different names, port or credentials to start the local database server, the configuration file is located in: 

.\stacksofwax\apiserver\.env 

 

The web app server code is located in 

.\stacksofwax\apiserver 

 

The API server code is located in 

.\stacksofwax\webserver 

 

To run the system, open both folders with the servers in vscode or in my case in vscodium (open-source version of vscode). Run both, the order doesn’t matter because if the api server runs before the web server, it generates the environment API keys that modify the webserver .env file. The webserver should automatically restart when the pair is generated, if doesn’t restart it manually or start the apiserver first.To start the servers, use the command “npx nodemon”. 

After starting both servers, go to http://localhost:3000/tracks and navigate from there to the dashboard and other pages. There are 2 users registered, they both reviewed 1 track called “Cracks”. If you want to see the average result of all the reviews, you can find the track Cracks in track name and see the review. 

The email and password to login with the 2 registered accounts are: 

Email: robertoloduca@hotmail.it 
Password: aaaaaaaaaaA.1

Email: aliceloduca@hotmail.it 
Password: aaaaaaaaaaA.1

in the folder .\stacksofwax\documentation there is an example of tracks stored in my database and the file in pdf and draw.io version of the database structure. please refer to them to see in a better resolution the ER diagram:

.\stacksofwax\documentation\ER stacksofwax.drawio.pdf