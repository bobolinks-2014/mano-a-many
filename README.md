# Mano-A-Many 
[ ![Codeship Status for bobolinks-2014/mano-a-many](https://codeship.io/projects/756d8a80-1151-0132-5385-72f63f219fb7/status)](https://codeship.io/projects/33017)
 This is Spanish for "hand to many"


##Summary 
Mano-a-Many is a social debt calculator, built as a five-day project for Dev Bootcamp. 

When large groups of friends frequently lend each other money, borrowing and lending money can quickly become unweildy. 

For simple one-to-one relationships, Mano-a-Many tracks the transaction history for both parties. Between larger groups, the application can simplify a complex web of transactions such that friends can settle up with the group by either giving or receiving one lump-sum payment. 

##Installation
1. Fork this repo.
2. Create the database using:
```
rake db:create db:migrate
```
3. Start up your rails server and point to localhost:3000.


##Usage
Mano-a-Many is [currently hosted on Heroku](http://mano-a-many.herokuapp.com/).
Log in or create an account.
Create a transaction by supplying the email of another registered user.
Settle up any number of users by clicking "Create Square Up".  All transactions the group members were involved in will be included. The app will return a list of settle up transactions to clear all of the debts.

##Methodology
Given a group, we count each user's credits against their debits, arriving at a positive or negative balance from relative to the rest of the group. We then consolidate all transactions down to fewer than N-1, where N is the size of the group. [Read this paper](http://www.mathmeth.com/tom/files/settling-debts.pdf) for more details on the pairing algorithm.

##Programmers
* Tanner Blumer
* Joey Chamberlin
* Jeff Keslin
* Steve Pikelny

