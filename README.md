# pre-commit-erlang

[pre-commit](https://pre-commit.com) hooks for Erlang

## Example:
Add the hooks to your .pre-commit-config.yaml like so:

```yaml
  - repo: https://github.com/sebastiw/pre-commit-erlang
    rev: v0.2.0
    hooks:
      - id: rebar3-fmt
```
