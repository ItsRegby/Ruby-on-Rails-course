# Ruby Interactive Calculator

A simple yet powerful command-line calculator built in Ruby that supports basic arithmetic operations with a history feature.

## Features

- Basic arithmetic operations
- Expression evaluation
- Command history storage
- Ability to reuse previous results
- Error handling for invalid expressions
- Clean and intuitive interface

## Usage

To start the calculator, simply run:

```ruby
calc = Calculator.new
calc.start
```

### Available Commands

- Enter any mathematical expression (e.g., `2 + 2`, `10 * 5`, `(3 + 4) * 2`)
- `history` - Display all previous calculations
- `use N` - Reuse the result from history entry N (where N is the entry number)
- `exit`, `quit`, or `q` - Exit the calculator

### Using Previous Results

When using a result from history:
1. Type `use N` (where N is the history entry number)
2. Enter a new expression using `ANS` as a placeholder for the previous result

Example:
```
Enter an expression: 5 + 5
Result: 10
Enter an expression: history
1. 5 + 5 = 10
Enter an expression: use 1
Using result from history: 10
Enter a new expression using this result: ANS * 2
Result: 20
```

## Error Handling

The calculator includes robust error handling for:
- Invalid expressions
- Syntax errors
- Invalid history entry numbers
- Other runtime errors

## Implementation Details

The calculator is implemented as a Ruby class with the following key components:
- Command history storage
- Expression evaluation using Ruby's `eval`
- Input handling and command parsing
- Result history management