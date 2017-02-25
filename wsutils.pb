; ========= Переменные и константы =========

Event.l = 0 ; Хранит события ОС
sClip1.s = GetClipboardText()
sClip2.s = ""

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

; ========= Рисуем интерфейс =========
  
;координаты окна = 0, так как окно центрируется флагом
OpenWindow(#WIN_MAIN, 0, 0, 200, 180, "wsutils", #FLAGS)

ButtonGadget(#BUTTON_STRIP,  20,  10,  70,  25, "Стрип")
ButtonGadget(#BUTTON_DEJAT,  110, 10,  70,  25, "ВАР")
ButtonGadget(#BUTTON_PEREN,  20,  50,  70,  25, "Перенос")
ButtonGadget(#BUTTON_PEREN2, 110, 50,  70,  25, "Перенос2")
ButtonGadget(#BUTTON_DERAZ,  50,  90,  70,  25, "Деразрядка")
TextGadget(#TEXT,            20,  130, 160, 25, sClip1)

StickyWindow(#WIN_MAIN,1)

; ========= Ждём действий =========

Repeat
  Event = WindowEvent()
  If Event = #PB_Event_Gadget
      SelectEventGadget()
  EndIf
  sClip2 = GetClipboardText()
  If sClip1 <> sClip2
      sClip1 = sClip2
      SetGadgetText(#TEXT, sClip2)
  EndIf
  Delay(10)
Until Event = #PB_Event_CloseWindow

End

; ==================================

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
  MessageRequester("peren", "PERENOS", #PB_MessageRequester_Ok)
EndProcedure

; шаблон Перенос2
Procedure Peren2()
  MessageRequester("peren2", "PERENOS2", #PB_MessageRequester_Ok)
EndProcedure

; убираем разрядку выделенного текста
Procedure Deraz()
  MessageRequester("deraz", "DERAZ", #PB_MessageRequester_Ok)
EndProcedure

; IDE Options = PureBasic 5.31 (Windows - x86)
; CursorPosition = 40
; FirstLine = 39
; Folding = --
; EnableUnicode
; EnableXP