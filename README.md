# Effective Testing with RSpec 3 - Build Ruby Apps with Confidence

## Definitions 🧾

### test_ vs _spec_ vs _example

Src: _Page 2_

- A __test__ validates that a bit of code is working properly.
- A __spec__ describes the desired behaviour of a bit of code.
- An __example__ shows how a particular API is intended to be used.

---

### _ChatGPT's_ understanding of mocks, stubs, doubles etc.

#### _Double_

A double is a stand-in actor for a real objects in the system. It pretends to be something else so you can
control and observe behavior in isolation.

```ruby
user = double("User")
```

---

#### _Stub_

A stub is a fake implementation of a method — you tell the double (or real object) what to return when a
method is called.

``` ruby
user = double("User")
allow(user).to receive(:name).and_return("Alice")
user.name # => "Alice"
```

🔹 Use stubs when you don’t care if the method gets called, you just want it to return something predictable.

---

#### _Mock_

A mock is like a stub plus an expectation that it will be called.
If the method isn’t called, the test fails.

```ruby
user = double("User")
expect(user).to receive(:name).and_return("Alice")

user.name # Passes  
# If we didn’t call `user.name`, test fails.
```

🔹 Use mocks when you care that the method is called (behavior verification).

---

#### _Spy_

A spy is like a double that starts out as a stub, but records what’s called so you can check after the fact.

```ruby
user = spy("User")
allow(user).to receive(:name).and_return("Alice")

user.name
expect(user).to have_received(:name)
```

🔹 Use spies when you don’t want to set expectations upfront, but still want to check calls afterward.

---

#### _Partial doubles_

A partial double is a real object that you replace some methods on with stubs or mocks.

```ruby
user = User.new("Alice")
allow(user).to receive(:name).and_return("Bob") # overrides method
```

🔹 Useful when you only want to fake part of the object’s behavior.

---

#### _Pure Double_

A pure double is a double that has no real implementation — every method must be explicitly defined via allow or expect.

```ruby
user = double("User")
# If you call `user.name` without stubbing it → error
```

🔹 These are the safest when you want total isolation.

---

#### _Verifying Double_

A verifying double is a double that checks against the real class or module to ensure the methods you stub or mock
actually exist.

```ruby
user = instance_double(User) # checks method existence
allow(user).to receive(:name).and_return("Alice") # ok
allow(user).to receive(:non_existent) # raises error
```

🔹 Great for safety — avoids tests passing because of typos.

---

#### _Stubbed Constant_

This is when you temporarily replace a constant (often a class/module) with a test double.

```ruby
stub_const("UserService", double(create: "fake user"))
UserService.create # => "fake user"
```

🔹 Useful for replacing big dependencies (services, API clients) in isolation.

---

## CMD 🎮

**Running with --profile to track slowest examples**

` `` bash

# The number is to define the amount of tracked slower examples being executed

rspec --profile 2

```

### Setting up with Bundler

Example will be for `expensee-tracker`

```bash
# Ensure to be placed in expensee-tracker dir
gem install bundler

# Setup the bundler - creates the Gemfile
bundle init

# installs the gems specified in Gem file
bundle install
```

Set up project to use _RSpec_ - always run _rspec_ using `bundle exec rspec`.

__Init rspec__ `bundle exec rspec --init` which generates two files:

- `.rspec`: _contains default command-line flags_.
- `spec/spec_helper.rb`: _contains configuration options_.

Add following `ENV['RACK:ENV'] = 'test'` to ´spec/spec_helper.rb´ to set __ENV__ to _test_.

---

### Running the specs we need

__Based on paths / files__

```bash
rspec spec/unit                   # Load *_spec.rb in this dir and subdirs
rspec spec/unit/specific_spec.rb  # Load just one spec file
rspec spec/unit spec/smoke        # More than one directory
rspec spec/unit spec/foo_spec.rb  # Or mix and match files and directories
```

__Running Examples by Name using flag: --example or -e__

```bash
rspec -e milk -fd
```

__Rerunning Everything That Failed - this need examples.txt go to: ## Configurations ⚒️__

```bash
rspec --only-failues
rspec --next-failure
```

__Focusing Specific Examples__

```bash
# Run examples by tag
rspec --tag last_run_status:failed
```

---

## Configurations ⚒️

__Configuring the storage file for failing examples__

```ruby
RSpec.configure do |config|
  # Define the path for examples.txt - persist metrics for executed RSpec examples 
  config.example_status_persistence_file_path = 'spec/examples.txt'
end
```

---

__Configure RSpec to run just focused examples.

```ruby
RSpec.configure do |config|
  # This enables to only run focused examples by: fcontext or fit
  config.filter_run_when_matching(focus: true)
end
```

---

<br>

## Gems 💎

- Coderay --> Used for formatting the output
- rack-test --> Used for HTTP request testing
- rspec --> The entire lib for RSpec
- sinatra --> Web framework simpler than Rails