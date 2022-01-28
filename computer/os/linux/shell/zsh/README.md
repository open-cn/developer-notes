## zsh

https://zsh.sourceforge.io/Doc/Release/index.html

### fc

fc 命令控制交互式历史机制。请注意，只有在 shell 是交互式的时才会执行历史选项的读取和写入。通常这是自动检测到的，但可以通过在启动 shell 时设置交互选项来强制。

```zsh
fc [ -e ename ] [ -LI ] [ -m match ] [ old=new ... ] [ first [ last ] ]
fc -l [ -LI ] [ -nrdfEiD ] [ -t timefmt ] [ -m match ] [ old=new ... ] [ first [ last ] ]
```

从历史列表中选择给定范围的的事件记录。

如果 first 没有指定，它将被设置为 -1（最近的事件），或者如果给定 -l 标志，则设置为 -16。如果 last 没有指定，它将被设置为 first，或者如果给出 -l 标志则设置为 -1。但是，如果当前事件已使用“print -s”或“fc -R”将条目添加到历史记录，则 -l 的默认 last 包括自当前事件开始以来的所有新历史记录条目。

-I restricts to only internal events (not from $HISTFILE)

-L restricts to only local events (not from other shells, see SHARE_HISTORY in Description of Options – note that $HISTFILE is considered local when read at startup)

-m takes the first argument as a pattern (should be quoted) and only the history events matching this pattern are considered

When the -l flag is given, the resulting events are listed on standard output. Otherwise the editor program specified by -e ename is invoked on a file containing these history events. If -e is not given, the value of the parameter FCEDIT is used; if that is not set the value of the parameter EDITOR is used; if that is not set a builtin default, usually ‘vi’ is used. If ename is ‘-’, no editor is invoked. When editing is complete, the edited command is executed.

The flag -r reverses the order of the events and the flag -n suppresses event numbers when listing.

Also when listing,

-d
prints timestamps for each event

-f
prints full time-date stamps in the US ‘MM/DD/YY hh:mm’ format

-E
prints full time-date stamps in the European ‘dd.mm.yyyy hh:mm’ format

-i
prints full time-date stamps in ISO8601 ‘yyyy-mm-dd hh:mm’ format

-t fmt
prints time and date stamps in the given format; fmt is formatted with the strftime function with the zsh extensions described for the %D{string} prompt format in Prompt Expansion. The resulting formatted string must be no more than 256 characters or will not be printed

-D
prints elapsed times; may be combined with one of the options above


```zsh
fc -p [ -a ] [ filename [ histsize [ savehistsize ] ] ]
fc -P
fc -ARWI [ filename ]
```

‘fc -p’ pushes the current history list onto a stack and switches to a new history list. If the -a option is also specified, this history list will be automatically popped when the current function scope is exited, which is a much better solution than creating a trap function to call ‘fc -P’ manually. If no arguments are specified, the history list is left empty, $HISTFILE is unset, and $HISTSIZE & $SAVEHIST are set to their default values. If one argument is given, $HISTFILE is set to that filename, $HISTSIZE & $SAVEHIST are left unchanged, and the history file is read in (if it exists) to initialize the new list. If a second argument is specified, $HISTSIZE & $SAVEHIST are instead set to the single specified numeric value. Finally, if a third argument is specified, $SAVEHIST is set to a separate value from $HISTSIZE. You are free to change these environment values for the new history list however you desire in order to manipulate the new history list.

‘fc -P’ pops the history list back to an older list saved by ‘fc -p’. The current list is saved to its $HISTFILE before it is destroyed (assuming that $HISTFILE and $SAVEHIST are set appropriately, of course). The values of $HISTFILE, $HISTSIZE, and $SAVEHIST are restored to the values they had when ‘fc -p’ was called. Note that this restoration can conflict with making these variables "local", so your best bet is to avoid local declarations for these variables in functions that use ‘fc -p’. The one other guaranteed-safe combination is declaring these variables to be local at the top of your function and using the automatic option (-a) with ‘fc -p’. Finally, note that it is legal to manually pop a push marked for automatic popping if you need to do so before the function exits.

‘fc -R’ reads the history from the given file, ‘fc -W’ writes the history out to the given file, and ‘fc -A’ appends the history out to the given file. If no filename is specified, the $HISTFILE is assumed. If the -I option is added to -R, only those events that are not already contained within the internal history list are added. If the -I option is added to -A or -W, only those events that are new since last incremental append/write to the history file are appended/written. In any case, the created file will have no more than $SAVEHIST entries.
