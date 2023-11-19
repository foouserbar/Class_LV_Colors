#Requires AutoHotkey v2.0
#Warn
#Include Class_LV_Colors.ahk

myGui := Gui(, "ListView & Colors")
myGui.MarginX := 20, myGui.MarginY := 20
myLV := myGui.AddListView("w600 r15 Grid -ReadOnly", ["Column 1", "Column 2", "Column 3", "Column 4", "Column 5", "Column6"])

Loop 256
   myLV.Add("", "Value " . A_Index, "Value " . A_Index, "Value " . A_Index, "Value " . A_Index, "Value " . A_Index, "Value " . A_Index)
Loop myLV.GetCount("Column")
   myLV.ModifyCol(A_Index, 95)
; Create a new instance of LV_Colors
CLV := LV_Colors(myLV.Hwnd, False)
If !IsObject(CLV) {
   MsgBox("Couldn't create a new LV_Colors object!", "ERROR", 0)
   ExitApp
}
; Set the colors for selected rows
CLV.SelectionColors(0xF0F0F0)
myGui.AddCheckBox("w120 vColorsOn Checked", "Colors On").OnEvent("Click", ShowColors)
myGui.AddRadio("x+120 yp wp vColors", "Colors").OnEvent("Click", Colors)
myGui.AddRadio("x+0 yp wp vAltRows", "Alternate Rows").OnEvent("Click", Colors)
myGui.AddRadio("x+0 yp wp vAltCols", "Alternate Columns").OnEvent("Click", Colors)
myGui.Show()
; Redraw the ListView after the first Gui, Show command to show the colors, if any.
myLV.Redraw()


; ----------------------------------------------------------------------------------------------------------------------
ShowColors(*) {
    res := myGui.Submit(False)
    If (res.ColorsOn)
       CLV.OnMessage()
    Else
       CLV.OnMessage(False)
    myLv.Focus()
}
; ----------------------------------------------------------------------------------------------------------------------
Colors(*) {
    res := myGui.Submit(False)
    myLV.Opt("-Redraw")
    CLV.Clear(1, 1)
    If (res.Colors)
        SetColors()
    If (res.AltRows)
        CLV.AlternateRows(0x808080, 0xFFFFFF)
    If (res.AltCols)
        CLV.AlternateCols(0x808080, 0xFFFFFF)
    myLV.Opt("+Redraw")
}
; ----------------------------------------------------------------------------------------------------------------------
SetColors() {
    Loop myLV.GetCount() {
       If (A_Index & 1) {
          CLV.Cell(A_Index, 1, 0x808080, 0xFFFFFF)
          CLV.Cell(A_Index, 3, 0x808080, 0xFFFFFF)
          CLV.Cell(A_Index, 5, 0x808080, 0xFFFFFF)
       } Else {
          CLV.Cell(A_Index, 2, 0x808080, 0xFFFFFF)
          CLV.Cell(A_Index, 4, 0x808080, 0xFFFFFF)
          CLV.Cell(A_Index, 6, 0x808080, 0xFFFFFF)
       }
    }
}
