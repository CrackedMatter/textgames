# textgames

An interpreter/engine for text-based games
(you don't necessarily have to use it for games though)
written in shell.

## Dependencies

- [curl](https://github.com/curl/curl)

## Installation

Clone the repository or download the latest release:
```
git clone https://github.com/CrackedMatter/textgames
cd textgames
```
Install the programm with `make`:
- If you have root permissions (sudo), run `sudo make install`
- If you don't have root permissions, run `make install PREFIX=~/.local`
- If you are using Termux (Android), run `make install PREFIX=/data/data/com.termux/files/usr`

## Usage

Run the program with the path to the game as an argument:

Example: `textgames ./examplegame`

## More information

[Wiki](https://github.com/CrackedMatter/textgames/wiki)
