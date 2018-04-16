require 'pg'

Given(/^open the site with the signup page$/) do
  visit "https://www-stage2.medici-living.de"
end
When(/^go to the login page$/) do
  find("a[href='/user/login']").click
end
When(/^go to the registration page$/) do
  find("a[href='https://www-stage2.medici-living.de/user/register']").click
end
When(/^introduce (.*), (.*), (.*), (.*) and (.*)$/) do |firstname, lastname, email_address, password, passwords_confirmation|
  fill_in('registration[firstname]', with: firstname)
  fill_in('registration[lastname]', with: lastname)
  fill_in('registration[email]', with: email_address)
  fill_in('registration[password][first]', with: password)
  fill_in('registration[password][second]', with: passwords_confirmation)
  check('registration_disclaimer')
  click_button('registration_save')
end
When(/^I'm signup succesfull$/) do
  have_content('Vielen Dank für deine Anmeldung bei Medici Living.')
end
When(/^Open admin page$/) do
  visit "https://admin-stage2.medici-living.de/admin/login"
end
When(/^Login to Admin page$/) do
  fill_in('_username', with: 'admin')
  fill_in('_password', with: 'admin123')
  click_button('_submit')
end
When(/^Go to user list$/) do
  visit "https://admin-stage2.medici-living.de/admin/ml/data/user/list"
end
When(/^Approve user (.*)$/) do |email_address|
  visit "https://www-stage2.medici-living.de/user/login"
  #update user_user set status=1 where email='alina.ghetler+10002@medici-living.de'
  conn = PG::Connection.open(:host => 'h2672951.stratoserver.net', :port => '7102', 
    :user => 'mladmin', :password => 'mladmin', :dbname => 'mldata')
  res = conn.exec_params('update user_user set status=1 where email=$1', [email_address])
end
When(/^Login succesfull user with (.*) and (.*)$/) do |email_address, password|
  fill_in('_username', with: email_address)
  fill_in('_password', with: password)
  click_button('Anmelden')
end
When(/^Go to contract page$/) do
  click_link('Vertrag')
end
When(/^Search for property in Berlin$/) do
  visit "https://www-stage2.medici-living.de/s/berlin"
end
When(/^Open a free room (.*)$/) do |room_id|
  visit "https://www-stage2.medici-living.de/p/" + room_id
end
When(/^Book room$/) do
  find('#book_room_button').click
end
When(/^Fill in customer data$/) do
  find('#contract_phone_number').set('015784378561')
  find('#contract_street').set('Landsberger Allee')
  find('#contract_streetnumber').set('171D')
  find('#contract_zipcode').set('10369')
  find('#contract_city').set('Berlin')
  find('#contract_countryCode').find(:xpath, 'option[52]').select_option
  find('#contract_nationality').find(:xpath, 'option[52]').select_option
  find('#contract_gender').find(:xpath, 'option[3]').select_option
  find('#contract_occupation').find(:xpath, 'option[2]').select_option
  find('#contract_incomeLevel').find(:xpath, 'option[2]').select_option
  find('#contract_birthday_day').find(:xpath, 'option[8]').select_option
  find('#contract_birthday_day').find(:xpath, 'option[8]').select_option
  find('#contract_birthday_month').find(:xpath, 'option[4]').select_option
  find('#contract_birthday_year').find(:xpath, 'option[2]').select_option
  find('#contract_idNumber').set('234567')
  find('#pay').click
end
When(/^Select payment method Visa$/) do
  find('#visa').click
  find('#pay').click
end
When(/^Go to next payment step$/) do
  find('#terms_disclaimerTerms').click
  find('#terms_revocationTerms').click
  find('#pay').click
end
When(/^Fill in card data$/) do
  find(:xpath, "//select[@name='card.expiryMonth']").find(:xpath, 'option[5]').select_option
  find(:xpath, "//select[@name='card.expiryYear']").find(:xpath, 'option[3]').select_option
  fill_in('card.cardNumber', with: '4012888888881881')
  fill_in('card.cardHolderName', with: 'Alina Ghetler')
  fill_in('card.cvcCode', with: '347')
  find('#mainSubmit').click
end

When(/^Finalize payment$/) do
  find('#mainSubmit').click
end

#Die Passwörter stimmen nicht überein. Versuche es noch einmal.
Then(/^signup check pass$/)do
  have_button('registration_save')
end 