# Jsup
[![Build Status](https://travis-ci.org/wizardone/jsup.svg?branch=master)](https://travis-ci.org/wizardone/jsup)

Jsup produces json using oj. It is really fast, simple and reliable. If
speed is what you are looking for in your APIs then you should check it
out.
If you have a complex architecture you should probably check gems like
`roar`, `jbuilder`, `serializers` etc.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jsup'
```

And then execute:

`bundle`

Or install it yourself as:

`gem install jsup`

## Usage
```ruby
user = User.first
Jsup.produce do |j|
  j.name user.name
  j.email user.email
end
```
Will produce:
```json
{
  "name": "John",
  "email": "john@johnson.com"
}
```

```ruby
Jsup.produce do |j|
  j.name 'Stefan'
  j.fetch(@address, :city)
end
```
Will produce:
```json
{
  "name": "Stefan",
  "city": "Sofia"
}
```
You can fetch multiple attributes:
```ruby
j.fetch(@address, :city, :zip_code, :street)
```

You can also produce nested content:
```ruby
Jsup.produce do |j|
  j.name 'Stefan'
  j.address do |ja|
    ja.street '13 march'
    ja.city 'Sofia'
  end
end
```
Will produce:
```json
{
  "name": "Stefan",
  "address":
    {
      "street": "13 march",
      "city": "Sofia"
    }
}
```
If you want to extract from a hash it is also possible:
```ruby
Jsup.produce do |j|
  j.fetch({first: 'my', last: 'initial'}, :first, :last)
end
```
```json
{
  "first": "my",
  "last": "initial"
}
```

## Benchmarking
For rather simple data structures jsup is way faster than jbuilder:
```ruby
def jb
  Jbuilder.encode do |person|
    person.name 'Stefan'
    person.email 'test@test.com'
    person.address 'some'
  end
end

def js
  Jsup.produce do |person|
    person.name 'Stefan'
    person.email 'test@test.com'
    person.address 'some'
  end
end


Benchmark.bm do |x|
  x.report('jbuilder') { 10000.times { jb } }
  x.report('jsup') { 10000.times { js } }
end
```
Results:
```shell
user     system      total        real
jbuilder  0.110000   0.000000   0.110000 (  0.112200)
jsup  0.030000   0.000000   0.030000 (  0.025732)
```

### I am welcoming ideas about new features and options for jsup! If you have any, let me know!


## Development

  After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

  To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

  Bug reports and pull requests are welcome on GitHub at https://github.com/wizardone/jsup. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

  The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

