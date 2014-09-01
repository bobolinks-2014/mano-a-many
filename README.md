# Mano-A-Many 
[ ![Codeship Status for bobolinks-2014/mano-a-many](https://codeship.io/projects/756d8a80-1151-0132-5385-72f63f219fb7/status)](https://codeship.io/projects/33017)
 This is Spanish for "hand to many"

##Summary 
Mano-a-Many is a Rails project for Dev Bootcamp. When a large group of people interact on a daily basis, sometimes borrowing and lending money, sometimes buying coffee or meals, it can get pretty complicated to pay each other back or settle up.  Mano-a-Many allows you to create a circle of friends and square up your debts with one another. Instead of trying to keep track of your money through a complicated web of transactions between you and your friends, Mano-a-Many does the calculations for you and lets the group know how you can settle your debts with as much simplicity and as few transactions as possible.

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

##Methodology
Given a group, we count each user's credits against their debits, arriving at a positive or negative balance from relative to the rest of the group. We then consolidate all transactions down to fewer than N-1, where N is the size of the gorup. [Read this paper](http://www.mathmeth.com/tom/files/settling-debts.pdf) for more details on the pairing algorithm.

##Programmers
* Tanner Blumer
* Joey Chamberlin
* Jeff Keslin
* Steve Pikelny

