; ========= Переменные и константы =========

EventID.l = 0 ; Хранит события ОС
sClipBoard.s = GetClipboardText()
Global getStrText$ ; clipboard text

; код события изменения буфера обмена
#WM_CLIPBOARDUPDATE = $031D

Enumeration
  #WIN_MAIN
  #BUTTON_STRIP
  #BUTTON_DEJAT
  #BUTTON_PEREN
  #BUTTON_PEREN2
  #BUTTON_DERAZ
  #TEXT
EndEnumeration

; флаги главного окна
#FLAGS = #PB_Window_SystemMenu | #PB_Window_ScreenCentered

; ========= Объявления процедур =========

Declare SelectEventGadget()
Declare Strip()
Declare Dejat()
Declare Peren()
Declare Peren2()
Declare Deraz()
Declare Winproc(hwnd, msg, wParam, lParam)

; ========= Рисуем интерфейс =========
  
;координаты окна = 0, так как окно центрируется флагом
OpenWindow(#WIN_MAIN, 0, 0, 200, 180, "wsutils", #FLAGS)

ButtonGadget(#BUTTON_STRIP,  20,  10,  70,  25, "Стрип")
ButtonGadget(#BUTTON_DEJAT,  110, 10,  70,  25, "ВАР")
ButtonGadget(#BUTTON_PEREN,  20,  50,  70,  25, "Перенос")
ButtonGadget(#BUTTON_PEREN2, 110, 50,  70,  25, "Перенос2")
ButtonGadget(#BUTTON_DERAZ,  50,  90,  70,  25, "Деразрядка")
TextGadget(#TEXT,            20,  130, 160, 25, sClipBoard)

; main window topmost

StickyWindow(#WIN_MAIN,1) 



; 7 строк, чтобы "слушать" обновления ClipBoard

OpenLibrary(0, "user32.dll")
Prototype AddClipboardFormatListener(hwnd)
Prototype RemoveClipboardFormatListener(hwnd)
Global AddClipboardFormatListener_.AddClipboardFormatListener = GetFunction(0, "AddClipboardFormatListener")
Global RemoveClipboardFormatListener_.RemoveClipboardFormatListener = GetFunction(0, "RemoveClipboardFormatListener")
SetWindowCallback(@WinProc())
AddClipboardFormatListener_(WindowID(#WIN_MAIN))

; ========= Ждём действий =========

Repeat
  EventID = WaitWindowEvent()
  If EventID = #PB_Event_Gadget
      SelectEventGadget()
  EndIf
Until EventID = #PB_Event_CloseWindow

; ========= Завершаем ============
RemoveClipboardFormatListener_(WindowID(#WIN_MAIN))
CloseLibrary(0)

End

;---------------------------------------------
;        End of Main Loop Code
;---------------------------------------------

Procedure WinProc(hwnd, msg, wParam, lParam)
  result = #PB_ProcessPureBasicEvents
  Select msg
    Case #WM_CLIPBOARDUPDATE
      getStrText$ = GetClipboardText()
      SetGadgetText(#TEXT, getStrText$)
  EndSelect
  ProcedureReturn result
EndProcedure

; действия по нажатию кнопок
Procedure SelectEventGadget()
  Select EventGadget()
    Case #BUTTON_STRIP
      Strip()
    Case #BUTTON_DEJAT
      Dejat()
    Case #BUTTON_PEREN
      Peren()
    Case #BUTTON_PEREN2
      Peren2()
    Case #BUTTON_DERAZ
      Deraz()    
  EndSelect
EndProcedure

; Чистим текст
Procedure Strip()
  MessageRequester("STRIP", "STRIP", #PB_MessageRequester_Ok)
EndProcedure

; шаблон ВАР и деятификация
Procedure Dejat()
  MessageRequester("DEJAT", "DEJAT", #PB_MessageRequester_Ok)
EndProcedure

; шаблон Перенос
Procedure Peren()
  Protected Text$ = RemoveString(getStrText$, "-")
  Text$ = "{{Перенос|" + Text$ + "|…}}"
  SetClipboardText(Text$)
EndProcedure

; шаблон Перенос2
Procedure Peren2()
  Protected Text$ = "{{Перенос2|…|" + getStrText$ + "}}"
  SetClipboardText(Text$)
EndProcedure

; убираем разрядку текста
Procedure Deraz()
  Protected Text$ = RemoveString(getStrText$, " ")
  SetClipboardText(Text$)
EndProcedure

; IDE Options = PureBasic 5.31 (Windows - x86)
; CursorPosition = 124
; FirstLine = 103
; Folding = --
; EnableUnicode
; EnableXP
; Executable = wsutils.exe