# Mano-A-Many 
[ ![Codeship Status for bobolinks-2014/mano-a-many](https://codeship.io/projects/756d8a80-1151-0132-5385-72f63f219fb7/status)](https://codeship.io/projects/33017)
 This is Spanish for "hand to many"

##Summary 
Mano-a-Many is a Rails project for Dev Bootcamp. When a large group of people interact on a daily basis, sometimes borrowing and lending money, sometimes buying coffee or meals, it can get pretty complicated to pay each other back or settle up.

##Installation
1. Fork this repo.
2. Create the database using:
```
rake db:create db:migrate
```
3. Start up your rails server and point to localhost:3000.


##Usage
Log in or create an account.
Create a transaction by supplying the email of another registered user.
Settle up any number of users by pressing settle up.  All transactions the group members were involved in will be included. The app will return a list of settle up transactions to clear all of the debts.

##Tests
We ain't got no tests.

##Programmers
* Tanner Blumer
* Joey Chamberlin
* Jeff Keslin
* Steve Pikelny

