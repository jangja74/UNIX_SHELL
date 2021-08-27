#!/bin/expect

set LOGIN_ID [lindex $argv 0]
set LOGIN_PW [lindex $argv 1]
set HOST_IP  [lindex $argv 2]
set FILE_NM1 [lindex $argv 3]
set FILE_NM2 [lindex $argv 4]
set LOCAL_DIR [lindex $argv 5]

spawn sftp $LOGIN_ID@$HOST_IP
expect "password:"
send "$LOGIN_PW\n"
expect "sftp>"
send "cd RECV\n"
expect "sftp>"
send "lcd $LOCAL_DIR\n"
expect "sftp>"
send "get $FILE_NM1\n"
expect "sftp>"
send "get $FILE_NM2\n"
expect "sftp>"
send "exit\n"
interact

