# ChatApp
The chatapp enables better communication between hotels and guests while automating responses to frequent guest questions.

## Dependencies
- Ruby 2.4.2
- Rails 5.1.4
- PostgreSQL
- Yarn
- Webpacker
- ReactJS
- Redis
- PhantomJS

## To setup project
- Install deps using `bundle install` & `yarn install`
- Copy `config/application.example.yml` to `config/application.yml`
- Setup DB using `rails db:setup`
- Run `bin/server` at project root, fire up the browser and go to `localhost:5000`

## Specs
- For rails specs `rspec`
- `./node_modules/karma/bin/karma start`

## Lint
- `rubocop`

## Assumptions/considerations
* Currently there is limited support for multiple hotels but can be extended easily
  * Of course, if a new hotel signs up we need to create a new app in Smooch using API
  * The JWT token needs to generated and app id needs to be fetched as well, currently both are accessed through ENV vars

## Answers to additional questions
A large number of incoming messages from guests are replied automatically by Chatapp based on the message content. How would
you implement a similar feature? No coding is required, just design a solution around this question.
Please start with considerations, with examples provided below.

Example Considerations:
* "What's the wifi password?" should get a Smart Response, but "the wifi password isn't working" should be sent to staff
* Unresponsive guests should not be bombarded with new messages by staff or chatapp
* Chatapp should never sound robotic or dumb to a guest (there is always human fallback!)

### Answer
I'll start by building an intelligent system that'll make decisions around the probability of correctness of
a generated answer (answer found in the system library), if it's too low it definitely needs to be answered by a human if high
enough it can go straight to user, third possibility it 50/50 and it needs to be approved by a human. ChatApp can always wait for
users to message first and then reply back, to avoid sending overwhelming number of messages.
