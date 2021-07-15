# textgames

An interpreter/engine for text-based games
(you don't necessarily have to use it for games though)
written in bash.

## Dependencies

- [sed](https://www.gnu.org/software/sed)

## Installation

Clone the repository or download the latest release:
```
git clone https://github.com/CrackedMatter/textgames
cd textgames
```
- If you have root permissions (sudo), run `sudo make install`
- If you don't have root permissions, run `make install PREFIX=~/.local/bin`
- If you are using Termux (Android), run `make install PREFIX=/data/data/com.termux/usr/bin`

## Usage

Run the program with the path to the game as an argument:

Example: `textgames example.txg`

## More information

[Wiki](https://github.com/CrackedMatter/textgames/wiki)
