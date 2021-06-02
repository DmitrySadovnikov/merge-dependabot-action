## Github Action to merge pull requests from dependabot

### Setup

```yaml
name: Merge dependabot action

on:
  schedule:
    - cron: "*/10 * * * *" # every 10 minutes

jobs:
  build:
    name: Merge dependabot action
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: DmitrySadovnikov/merge-dependabot-action@master
        env:
          GITHUB_TOKEN: ${{ secrets.PAT }} # token of your account
          PULL_REQUEST_AUTHOR: "dependabot[bot]"
```
