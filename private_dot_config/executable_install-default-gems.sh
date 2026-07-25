#!/bin/sh

"$MISE_TOOL_INSTALL_PATH"/bin/gem update --system
xargs -rd'\n' -a ~/.config/default-gems "$MISE_TOOL_INSTALL_PATH"/bin/gem install
