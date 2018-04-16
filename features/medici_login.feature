Feature: Signup

Scenario Outline: Signupfails
  Given open the site with the signup page
  When go to the login page
  And go to the registration page
  And introduce <firstname>, <lastname>, <email_address>, <password> and <passwords_confirmation>
  Then signup check pass

  Examples: 

      | firstname               | lastname      | email_address                     | password      | passwords_confirmation | 
      |                         | ghetler       | alina.ghetler+2@medici-living.de  | berlinberlin1 | berlinberlin1          |
      | alina                   | ghetler       | alina.ghetler+1medici-living.de   | berlinberlin2 | berlinberlin2          |
      | alina                   |               | alina.ghetler+1@medici-living.de  | berlinberlin2 | berlinberlin2          |
      | alina                   | ghetler       | alina.ghetler+1@medici-living.de  | berlinberlin2 | berlinberlin3          |
      

Scenario Outline: Signup
  Given open the site with the signup page
  When go to the login page
  And go to the registration page
  And introduce <firstname>, <lastname>, <email_address>, <password> and <passwords_confirmation>
  And I'm signup succesfull
  And Approve user <email_address>
  And Login succesfull user with <email_address> and <password>
  And Go to contract page
  And Search for property in Berlin
  And Open a free room <room_id>
  And Book room
  And Fill in customer data
  And Select payment method Visa
  And Go to next payment step
  And Fill in card data
  And Finalize payment

  Examples: 

      | firstname               | lastname      | email_address                         | password      | passwords_confirmation| room_id      | 
      | alina                   | ghetler       | alina.ghetler+10003@medici-living.de  | berlinberlin1 | berlinberlin1         | DE-01-042-05 |
      