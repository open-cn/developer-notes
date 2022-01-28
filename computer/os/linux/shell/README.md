## shell

### echo

-n 不加空的新行

### history

```shell
history [-c] [-d offset ] [ n ]
history -anrw [ file name ]
history -ps arg [ arg... ]
```

Options: 

- -c	Clear the history list by deleting all of the entries.
- -d offset	Delete the history entry at offset OFFSET.
- -a	Append history lines from this session to the history file.
- -n	Read all history lines not already read from the history file.
- -r	Read the history file and append the contents to the history list.
- -w	Write the current history to the history file and append them to the history list
- -p	Perform history expansion on each ARG and display the result without storing it in the history list.
- -s	Append the ARGs to the history list as a single entry.

If FILE NAME is given, it is used as the history file. Otherwise, if $HISTFILE has a value, that is used, else ~/.bash_history.

If the $HISTTIMEFORMAT variable is set and not null, its value is used as a format string for strftime to print the timestamp associated with each displayed history entry. No timestamps are printed otherwise.

### fc

FC是LINUX命令用途是处理命令历史列表，fc 命令显示了历史命令文件内容或调用一个编辑器去修改并重新执行以前在 shell 中输入的命令。

```shell
fc [-e ename] [-lnr] [first] [last]
fc -s [pat=rep] [command]
```

Options: 

- -e ENAME	Select which editor to use. Default is FCEDIT, then EDITOR, then vi.
- -l	List lines instead of editing.
- -n	Omit line numbers when listing.
- -r	Reverse the order of the lines (newest listed first).

With the 'fc -s [pat=rep ...] [command]' format, COMMAND is re-executed after the substitution OLD=NEW is performed.

A useful alias to use with this is r='fc -s', so that typing 'r cc' runs the last command beginning with 'cc' and typing 'r' re-executes the last command.

