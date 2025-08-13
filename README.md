# Effective Testing with RSpec 3 - Build Ruby Apps with Confidence

## Definitions 🧾

Src: _Page 2_

- A __test__ validates that a bit of code is working properly.
- A __spec__ describes the desired behaviour of a bit of code.
- An __example__ shows how a particular API is intended to be used.

---

## CMD 🎮

**Running with --profile to track slowest examples**

```bash
# The number is to define the amount of tracked slower examples being executed
rspec --profile 2
```

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