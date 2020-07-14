# products_CLI

## Introduction 

products_CLI is a command line program that takes in a product type and 0 or more product options and
returns available product options for the criteria entered, excluding the options that have already been specified.

## Table of contents
* [Examples](#examples)
* [Installation](#installation)
* [Usage](#usage)
* [Contributing](#contributing)

### Examples

Example: Product type only.

```
> ./products_CLI tshirt
Gender: male, female
Color: red, navy, green, white, black
Size: small, medium, large, extra-large, 2x-large
```

Example: When options are providing alongside product type.
         No Gender option is shown when option 'male' is given.

```
> ./product_CLI tshirt male
Color: red, blue, green
Size: small, medium, large, extra-large, 2x-large
```

## Installation

Fork and clone this repository and `cd` into the directory.

And then execute:

    $ bundle install

## Usage

To run products_CLI enter the following command along with a product_type and 0 or more options:
```
  ruby bin/run product_type

  ruby bin/run product_type option1 option2 etc
```
You can also run `bin/console` for an interactive prompt that will allow you to experiment with the code.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/BSalemi/products_CLI.