# StreetFighterV

![Xcode](https://img.shields.io/badge/Xcode-10.2.1-brightgreen.svg)
![Swift](https://img.shields.io/badge/Swift-5.0-brightgreen.svg)

| | |
|---|---|
|![Frame](https://raw.githubusercontent.com/Nonchalant/StreetFighterV/master/documents/Frame.png?token=ABH4HOYPGDL3DUPAAE3RFWK43RZIE)|![Character](https://raw.githubusercontent.com/Nonchalant/StreetFighterV/master/documents/Character.png?token=ABH4HO3J7DDAJZ24FOIDQP243RZGK)|

## Setup

Download `fastlane/.env` from [here](https://github.com/Nonchalant/env/blob/master/StreetFighterV/fastlane/.env) (**You need permission**)

```
$ bundle install
$ bundle exec pod install
$ bundle exec fastlane setup
```

## Update Data

Download `scripts/.env` from [here](https://github.com/Nonchalant/env/blob/master/StreetFighterV/scripts/.env) (**You need permission**)

And update `ENV["COOKIE"]`

```
$ bundle install
$ bundle exec ruby scraping.rb [ja, en]
// Run google app script
```
