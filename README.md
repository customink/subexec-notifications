
# Subexec::Notifications

Instrumentation For Subexec Commands Using ActiveSupport::Notifications.


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
[![Build Status](https://secure.travis-ci.org/customink/subexec-notifications.png)](http://travis-ci.org/customink/subexec-notifications)

