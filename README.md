# Hooka: just add water

An ergonomic bash only zero dependency git hooks manager.

Hooka has been written with the following in mind:

- does not mess up with `.git/hooks` (git ≥ 2.9).
- compatible with running `.git/hooks`.
- No nonsense configuration, no YAML, and can be configured with your text editor.

## Usage

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

