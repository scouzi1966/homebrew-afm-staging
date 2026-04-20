# homebrew-afm-staging

Staging Homebrew tap for [afm](https://github.com/scouzi1966/maclocal-api). Used to validate candidate builds on multiple machines before they are promoted to the main tap at `scouzi1966/afm`.

## Install

```bash
brew tap scouzi1966/afm-staging
brew install scouzi1966/afm-staging/afm
afm --version
```

## Switch back to the stable tap

```bash
brew uninstall afm
brew untap scouzi1966/afm-staging
brew install scouzi1966/afm/afm
```

## Caveats

- Builds here are **candidates under test** — expect regressions.
- The `afm.rb` formula URL/version/sha256 is rewritten as new candidates are staged.
- Do not use this tap for day-to-day work.
