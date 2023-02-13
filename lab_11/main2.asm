format PE GUI 4.0
entry start

include 'win32a.inc'

section '.data' data readable writeable

_class db 'GetNumberClass',0
_title db 'Adding',0
_edit db 'edit',0
_button db 'button',0
_button_name db 'Add',0

wc WNDCLASS 0,WindowProc,0,0,NULL,NULL,NULL,COLOR_BTNFACE+1,NULL,_class

msg MSG
entry_t dd ?
flag dd ?
iVar dd ?
strFormat db 'Sum = %d',0
buf rd 16

section '.code' code readable executable

start:
        invoke GetModuleHandle,0
        mov [wc.hInstance],eax
        invoke LoadCursor,0,IDC_ARROW
        mov [wc.hCursor],eax
        invoke RegisterClass,wc
        invoke CreateWindowEx,0,_class,_title,WS_VISIBLE+WS_DLGFRAME+WS_SYSMENU,810,350,300,250,NULL,NULL,[wc.hInstance],NULL


msg_loop:
        invoke GetMessage,msg,NULL,0,0
        cmp eax,1
        jb end_loop
        jne msg_loop
        invoke TranslateMessage,msg
        invoke DispatchMessage,msg
        jmp msg_loop


end_loop:
        invoke ExitProcess,[msg.wParam]
        proc WindowProc hwnd,wmsg,wparam,lparam
        push ebx esi edi
        cmp [wmsg],WM_CREATE
        je .wmcreate
        cmp [wmsg],WM_COMMAND
        je .wmcommand
        cmp [wmsg],WM_DESTROY
        je .wmdestroy


.defwndproc:
        invoke DefWindowProc,[hwnd],[wmsg],[wparam],[lparam]
        jmp .ret


.wmcreate:
        ; first entry
        invoke CreateWindowEx,WS_EX_CLIENTEDGE,_edit,0,WS_VISIBLE+WS_CHILDWINDOW+ES_NUMBER+ES_AUTOHSCROLL+ES_NOHIDESEL,100,50,100,20,[hwnd],100,[wc.hInstance],NULL
        mov [entry_t],eax
        invoke SetFocus,eax
        invoke SendMessage,[entry_t],EM_SETLIMITTEXT,1,0
        ; swecond entry
        invoke CreateWindowEx,WS_EX_CLIENTEDGE,_edit,0,WS_VISIBLE+WS_CHILDWINDOW+ES_NUMBER+ES_AUTOHSCROLL+ES_NOHIDESEL,100,80,100,20,[hwnd],101,[wc.hInstance],NULL
        mov [entry_t],eax
        invoke SendMessage,[entry_t],EM_SETLIMITTEXT,1,0
        ; sum button
        invoke CreateWindowEx,0,_button,_button_name,WS_VISIBLE+WS_CHILDWINDOW+BS_DEFPUSHBUTTON,100,130,100,80,[hwnd],102,[wc.hInstance],NULL
        jmp .finish


.wmcommand:
        ; if we click button
        mov eax,[wparam]
        cmp ax,102
        jne .finish
        ; first number
        invoke GetDlgItemInt,[hwnd],100,flag,1
        ; save first  figure
        mov [iVar], eax
        ; second number
        invoke GetDlgItemInt,[hwnd],101,flag,1
        cmp [flag],1
        je .sum


; get sum
.sum:
        ; adding
        add eax, [iVar]
        ; get string to write it
        cinvoke wsprintf, buf, strFormat, eax
        ; print result
        invoke MessageBox,[hwnd],buf,_title,MB_OK
        jmp .finish


; finish
.wmdestroy:
        invoke PostQuitMessage,0


.finish:
        xor eax,eax


.ret:
        pop edi esi ebx
        ret
        endp

section '.idata' import data readable writeable

library kernel32,'KERNEL32.DLL',\
user32,'USER32.DLL'

include 'api\kernel32.inc'
include 'api\user32.inc'