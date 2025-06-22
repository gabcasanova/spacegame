# Building the game

* Install [Love2D 11.5](https://github.com/love2d/love/releases/download/11.5/love-11.5-win64.exe)
* Add Love2D to PATH (environment variables): ``C:\Program Files\LOVE``

## Debugging and coding
The game was written and made to run in VSCode using it's IDE capabilities for debugging and more. The config files are at ``.vscode\settings.json`` and ``spacegame.code-workspace``. Open the folder as a workspace.

Install the following extensions:
* [Lua Language Server](https://marketplace.visualstudio.com/items?itemName=sumneko.lua)
* [Local Lua Debugger](https://marketplace.visualstudio.com/items?itemName=tomblind.local-lua-debugger-vscode)

## Compiling the game
Configure build options at ``make_all.toml``
* Install Python
* ``pip install setuptools``
* ``pip3 install makelove``
* Add Python Scripts to PATH: ``C:\Users\%username%\AppData\Roaming\Python\Python312\Scripts``
* Press CTRL+SHIFT+B to build the project.


