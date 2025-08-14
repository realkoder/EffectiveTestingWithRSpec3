# Effective Testing with RSpec 3 - Build Ruby Apps with Confidence

## Definitions 🧾

### _test_ vs _spec_ vs _example_

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

#### Visual summary

| Term                 | Fake Object? | Method Call Verified? | Matches Real API? | Works on Real Object? |
|----------------------|--------------|-----------------------|-------------------|-----------------------|
| **Stub**             | Maybe        | ❌                     | ❌                 | ✅ (partial double)    |
| **Mock**             | Maybe        | ✅ (before)            | ❌                 | ✅ (partial double)    |
| **Spy**              | Maybe        | ✅ (after)             | ❌                 | ✅ (partial double)    |
| **Partial Double**   | ❌            | ❌/✅                   | ❌                 | ✅                     |
| **Pure Double**      | ✅            | ❌/✅                   | ❌                 | ❌                     |
| **Verifying Double** | ✅            | ❌/✅                   | ✅                 | ❌                     |
| **Stubbed Constant** | ✅            | ❌/✅                   | Optional          | ❌                     |

---

<br>

## Important CLI commands 🎮

**Running with --profile to track slowest examples**

``` bash

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

### Using Sequel as DB TOOLKIT with SQLite3

This is to enable a migration: `bundle exec sequel -m ./db/migrations sqlite://db/development.db --echo`

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

#### Configure RSpec to run just focused examples.

```ruby
RSpec.configure do |config|
  # This enables to only run focused examples by: fcontext or fit
  config.filter_run_when_matching(focus: true)
end
```

#### Configure RSpec when a tag is matched a block is yielded

```ruby
config.when_first_matching_example_defined(:db) do
  require_relative '/support/db'
end
```

---

<br>

## RSpec Tagging

RSpec supports **tags** to help organize, filter, and control the execution of tests. Tags are metadata that can
be attached to example groups (`describe` or `context`) or individual examples (`it`). They are specified as Ruby hash
syntax
in curly braces `{}` right after the description.

```ruby
RSpec.describe "Payment Processing", :integration do
  it "processes a payment" do
    # test code
  end
end

RSpec.describe "User Login" do
  it "logs in a valid user", :smoke do
    # test code
  end
end
```

You can run only tests with specific tags using the --tag option:

```bash
rspec --tag integration
rspec --tag smoke
```

You can also exclude tags:

```bash
rspec --tag ~integration
```

__Custom Tags__ Tags can carry values, allowing more control:

```ruby
RSpec.describe "API", type: :request, version: 2 do
  it "returns correct data" do
    # test code
  end
end

# Run only version 2 tests
rspec --tag version : 2
```

#### Special Tag: :aggregate_failures

The __:aggregate_failures__ tag tells RSpec to collect multiple failed expectations within a single example and report
them together instead of stopping at the first failure.

Without :aggregate_failures (default behavior):

```ruby
it "checks multiple conditions" do
  expect(1).to eq(2) # fails here, stops
  expect("foo").to eq("bar") # never runs
end
```

With :aggregate_failures:

```ruby
it "checks multiple conditions", :aggregate_failures do
  expect(1).to eq(2) # fails, but continues
  expect("foo").to eq("bar") # also fails
end
Output :
  Both failures are shown together, making it easier to debug related expectations.
```

---

<br>

## Gems 💎

- Coderay --> Used for formatting the output
- rack-test --> Used for HTTP request testing
- rspec --> The entire lib for RSpec
- sinatra --> Web framework simpler than Rails