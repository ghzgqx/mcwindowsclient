:batset
@echo off
@rem debub=-v
set debug=
set sshloginver= Final
title ADMIN CONTROL PANEL - Update %sshloginver%
color f0
goto :config

:config
@echo off
@rem Host:
set configfile=servercfg.txt
set hostname=mcserver_console
goto :start

:start
color fc
echo  # 2016-10-21#
echo  #^<admin@ghzgqx.com^>#
echo.  
echo  #######     数据无价      谨慎操作     #######
echo.
echo  ####### Minecraft服务器 - 管理员控制台 #######
echo  http://www.github.com/ghzgqx/mc
echo  ----------------------------------------------
echo            季节变迁  那曾经刺骨的寒风
echo           已经在春天的歌声中  沉入梦乡
echo         满是泪水的脸颊 又会映出多美的笑容
echo        在随后的日子  我们迎来了崭新的季节
echo  ----------------------------------------------
echo.
echo 自检
if exist %configfile% (
cls & goto :select
) else (
goto :errornocfg
)





:select
set select=
color f0 
title ADMIN CONTROL PANEL - Update %sshloginver% / Main Menu
echo.
echo  Minecraft服务器管理员控制台
echo.
echo 服务端：
echo 1.服务端启动/重启  2.Minecraft控制台  3.强制停止服务端 
echo.
echo 系统：
echo 4.终端  5.系统重启 
echo.
echo 存档：
echo 6.备份  7.恢复  8.查询  9.压缩 0.文件大小
echo.
echo.
set /p select="  请输入数字选择[回车键确认]:"
if "%select%" == "1" (goto :start) else (
if "%select%" == "2" (goto :console) else (
if "%select%" == "3" (goto :stop) else (
if "%select%" == "4" (goto :shell) else (
if "%select%" == "5" (goto :reboot) else (
if "%select%" == "6" (goto :bkup) else (
if "%select%" == "7" (goto :rec) else (
if "%select%" == "8" (goto :log) else (
if "%select%" == "9" (goto :gc) else (
if "%select%" == "0" (goto :du) else (goto :noselect))))))))))

:start
title ADMIN CONTROL PANEL - Update %sshloginver%  / Start Server
echo. 
ssh.exe -t %debug% -C -F servercfg.txt %hostname% "mc start"
goto :select

:console
title ADMIN CONTROL PANEL - Update %sshloginver% / Minecraft Console
echo.
ssh.exe -t %debug% -C -F servercfg.txt %hostname% "mc shell"
:select

:stop
title ADMIN CONTROL PANEL - Update %sshloginver% / Stop Server 
echo.
ssh.exe -t %debug% -C -F servercfg.txt %hostname% "mc stop"
echo.
goto :select

:shell 
title ADMIN CONTROL PANEL - Update %sshloginver% / Shell
echo.
ssh.exe -t %debug% -C -F servercfg.txt %hostname% 
goto :select

:reboot
echo.
set confirmr=
set /p confirmr="Sure? yes/no[Enter]:"
if "%confirmr%" == "yes" (echo yes) else (goto :select)
ssh.exe -t %debug% -C -F servercfg.txt %hostname% "sudo reboot"
goto :select

:bkup
color f0
title ADMIN CONTROL PANEL - Update %sshloginver% /Git Backup
ssh.exe -t %debug% -C -F servercfg.txt %hostname% "mc backup do"
goto :select
 
:rec
color f0
title ADMIN CONTROL PANEL - Update %sshloginver% / Git Recovery
set /p commit="Commit ID"
ssh.exe -t %debug% -C -F servercfg.txt %hostname% "mc backup rec %commit%"
goto :select

:log
color f0
title ADMIN CONTROL PANEL - Update %sshloginver% / Git Log
ssh.exe -t %debug% -C -F servercfg.txt %hostname% "mc backup log"
goto :select

:gc
title ADMIN CONTROL PANEL - Update %sshloginver% / Git GC
ssh.exe -t %debug% -C -F servercfg.txt %hostname% "mc backup gc"
set httpport= 
goto:select

:du
title ADMIN CONTROL PANEL - Update %sshloginver% / File Size
ssh.exe -t %debug% -C -F servercfg.txt %hostname% "mc du"
goto:select

:error
echo Error! Please check :config

:noselect
echo ERROR
goto :select

:errornocfg
echo Error！ No server config file