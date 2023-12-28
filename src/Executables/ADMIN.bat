net user "Administrator" /active:yes

@echo OFF
for /f "usebackq delims=" %%A in (`net localgroup administrators ^| findstr /V /X /I /R /c:"Alias name[ ].*" /c:"Comment[ ].*" /c:"Members" /c:"-*" /c:"The command completed.*" /c:"Administrator"`) do (
	echo net localgroup administrators "%%A" /delete
	net localgroup administrators "%%A" /delete
	echo net localgroup users "%%A" /add
	net localgroup users "%%A" /add
)
@echo ON
