# Bemoji

GitHub-flavored Emoji plugin for Bunto

[![Gem Version](https://badge.fury.io/rb/bemoji.svg)](http://badge.fury.io/rb/bemoji)
[![Build Status](https://travis-ci.org/bunto/bemoji.svg?branch=master)](https://travis-ci.org/bunto/bemoji)

## Usage

Add the following to your site's `Gemfile`

```
gem 'bemoji'
```

And add the following to your site's `_config.yml`

```yml
gems:
  - bemoji
```

In any page or post, use emoji as you would normally, e.g.

```markdown
I give this plugin two :+1:!
```

## Customizing

If you'd like to serve emoji images locally, or use a custom emoji source, you can specify so in your `_config.yml` file:

```yml
emoji:
  src: "/assets/images/emoji"
```

See the [Gemoji](https://github.com/github/gemoji) documentation for generating image files.
