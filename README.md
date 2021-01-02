# Hooka: just add water

Yet another git hooks manager.

```bash

hooka init

# Add and edit a hook step by name
hooka add pre-commit lint

# Add an executable file as a hook step
hooka add pre-commit some/path/to/a/file

# to test your step
hooka run pre-commit

# edit steps / order
hooka edit pre-commit

# list steps in hook
hooka ls pre-commit

