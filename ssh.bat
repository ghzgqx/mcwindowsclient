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
echo  #######     �����޼�      ��������     #######
echo.
echo  ####### Minecraft������ - ����Ա����̨ #######
echo  http://www.github.com/ghzgqx/mc
echo  ----------------------------------------------
echo            ���ڱ�Ǩ  �������̹ǵĺ���
echo           �Ѿ��ڴ���ĸ�����  ��������
echo         ������ˮ������ �ֻ�ӳ��������Ц��
echo        ����������  ����ӭ����ո�µļ���
echo  ----------------------------------------------
echo.
echo �Լ�
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
echo  Minecraft����������Ա����̨
echo.
echo ����ˣ�
echo 1.���������/����  2.Minecraft����̨  3.ǿ��ֹͣ����� 
echo.
echo ϵͳ��
echo 4.�ն�  5.ϵͳ���� 
echo.
echo �浵��
echo 6.����  7.�ָ�  8.��ѯ  9.ѹ�� 0.�ļ���С
echo.
echo.
set /p select="  ����������ѡ��[�س���ȷ��]:"
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
echo Error�� No server config file