#          ______   ___    ___
#         /\  _  \ /\_ \  /\_ \
#         \ \ \L\ \\//\ \ \//\ \      __     __   _ __   ___ 
#          \ \  __ \ \ \ \  \ \ \   /'__`\ /'_ `\/\`'__\/ __`\
#           \ \ \/\ \ \_\ \_ \_\ \_/\  __//\ \L\ \ \ \//\ \L\ \
#            \ \_\ \_\/\____\/\____\ \____\ \____ \ \_\\ \____/
#             \/_/\/_/\/____/\/____/\/____/\/___L\ \/_/ \/___/
#                                            /\____/
#                                            \_/__/
# 
#       MPW Script install allegro.
# 
#       By Ronaldo Hideki Yamada.
#  
#       See readme.txt for copyright information.
#
#       See readme.mpw for information about use of this file.
#

Set savedir `Directory`

If "{0}" =~ /(�:)�1readme.mpw/
	SetDirectory {�1}
End

If "{Allegro}"!="{Libraries}::Allegro:"
	Echo "### Allegro var not defined correctly"
	Echo "### If required quit MPW after install"
	Set -e Allegro {Libraries}::Allegro:
End

If !`Exists "{MPW}Startup Items:setalleg.sh"`
   Echo "### Please quit MPW after install"
   Echo 'Set -e Allegro {Libraries}::Allegro:' > "{MPW}Startup Items:setalleg.sh"
End

Duplicate -y ":tools:datedit.h" ":tools:plugins:../datedit.h"

If !`Exists "{Allegro}"`
	NewFolder "{Allegro}"	
End
If !`Exists ":obj:"`
	NewFolder ":obj:"	
End
If !`Exists ":obj:mpw:"`
	NewFolder ":obj:mpw:"
End
If !`Exists ":obj:mpw:alld:"`
	NewFolder ":obj:mpw:alld:"
End

#change creator to MPW Shell
set f "`Files -r -f -t 'TEXT' -c 'CWIE' -o`"
if "{f}"!=""
	SetFile -c 'MPS ' {f}
end
unset f

If `Exists "makefile.mpw"`
    Duplicate -y makefile.mpw makefile
	Echo "analyzing dependencys"
	make {Parameters} > ":obj:mpw:alld:makefile.dep"
	Echo "building sources"
	Echo "this can take several minutes..."
	":obj:mpw:alld:makefile.dep"
Else
	Echo "makefile.mpw not found"
End

Echo "### Done"

SetDirectory "{savedir}"
