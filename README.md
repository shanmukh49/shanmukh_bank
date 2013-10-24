# Online Banking Application

== Welcome to the Bank of Kwantlen's Online Banking Application

This is a simple application which simulates an online banking system.
This has been developed as part of INFO 4320: Software Quality Assurance at
[Kwantlen Polytechnic University](http://www.kwantlen.ca).

## Getting Started

In order to try out this application, you will need to have Ruby installed. After downloading the code, enter the following command in the project folder in order to install all the dependencies:

    bundle install
    
Next you need to migrate the database:

    bundle exec rake db:migrate
    bundle exec rake db:test:prepare
    
You can then fire up the Rails web server:

    rails server

## Test Suite

In order to run the test suite built with RSpec and Cabybara, issue the following command:

    bundle exec rspec spec/
    


