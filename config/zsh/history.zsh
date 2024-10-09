# History Management - keep plenty of history
#
HISTFILE=$ZDATADIR/zhistory
HISTSIZE=100000
SAVEHIST=100000
HISTDUP=erase
setopt APPEND_HISTORY            # Append history to the history file rather than replace it..
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
# setopt SHARE_HISTORY             # Share history between all sessions.
setopt INC_APPEND_HISTORY_TIME   # Append command right after execution.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.

