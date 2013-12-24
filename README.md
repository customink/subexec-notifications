# Subexec::Notifications

Instrumentation for [`Subexec`](https://github.com/nulayer/subexec) commands using `ActiveSupport::Notifications`.


## Usage

Read the full document documentation for [`ActiveSupport::Notifications`](http://apidock.com/rails/ActiveSupport/Notifications) first. All `Subexec` events can be subscribed to using the `subexec.run` key.

```ruby
ActiveSupport::Notifications.subscribe('subexec.run') do |*args|
  # Your code here
end
```


## Payload

The payload for events return the `Subexec` instance via the `:sub` key as well as the hostname of the machine running the command via the `:hostname` key. For example:

* `:sub` - Subexec object
* `:hostname` - The hostname of the machine as reported by `Socket.gethostname`.


## Full Example

```ruby
ActiveSupport::Notifications.subscribe('subexec.run') do |*args|
  Subscribers::SubexecLibrato.new(*args)
end

module Subscribers
  class SubexecLibrato < Base

    def initialize(*args)
      @event = ActiveSupport::Notifications::Event.new(*args)
      process
    end

    def process
      sub = @event.payload[:sub]
      duration = @event.duration
      command = sub.command.split.first
      source = @event.payload[:hostname]
      Librato::Metrics.submit 'subexec.run' => {type: command, value: duration, source: source}
    end

  end
end
```


## Learn More

* [Instrumenting Your Code With ActiveSupport Notifications](http://technology.customink.com/blog/2013/12/19/instrumenting-your-code-with-activesupport-notifications/)
* [Digging Deep with ActiveSupport::Notifications](https://speakerdeck.com/nextmat/digging-deep-with-activesupportnotifications)


## Contributing

The subexec-notifications gem is tested against ActiveSupport v3.x to v4.x. We run our tests on [Travis CI](http://travis-ci.org/customink/subexec-notifications) in both Ruby 1.9 and 2.0. Check the `.travis.yml` file for the latest build information. 

If you detect a problem, open up a github issue or fork the repo and help out. After you fork or clone the repository, the following commands will get you up and running on the test suite. 

```shell
$ bundle install
$ bundle exec rake appraisal:setup
$ bundle exec rake appraisal test
```

We use the [appraisal](https://github.com/thoughtbot/appraisal) gem from Thoughtbot to help us generate the individual gemfiles for each ActiveSupport version and to run the tests locally against each generated Gemfile. The `rake appraisal test` command actually runs our test suite against all ActiveSupport versions in our `Appraisal` file. If you want to run the tests for a specific ActiveSupport version, use `rake -T` for a list. For example, the following command will run the tests for ActiveSupport v3.2 only.

```shell
$ bundle exec rake appraisal:v32 test
```

Our current build status is:
[![Build Status](https://travis-ci.org/customink/subexec-notifications.png?branch=master)](https://travis-ci.org/customink/subexec-notifications)
