<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<%
'��������
PASSWORD = "2121"

dim Report

if request.QueryString("act")="login" then
if request.Form("pwd") = PASSWORD then session("pig")=1
end if
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">                          '��ҿ��԰�����ļ��ŵ��Լ�����վ��
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>ASPSecurity for Hacking</title>
</head>

<body>
<%If Session("pig") <> 1 then%>
<form name="form1" method="post" action="?act=login">
<div align="center">Password: 
    <input name="pwd" type="password" size="15"> 
    <input type="submit" name="Submit" value="�ύ">
</div>
</form>
<%
else
if request.QueryString("act")<>"scan" then
%>
     <form action="?act=scan" method="post">
     <b>������Ҫ����·����</b>
     <input name="path" type="text" style="border:1px solid #999" value="." size="30" />
     <br>
     * ��վ��Ŀ¼�����·�����\�������������վ����.��Ϊ��������Ŀ¼
     <br>
     <br>
     <input type="submit" value=" ��ʼɨ�� " style="background:#fff;border:1px solid #999;padding:2px 2px 0px 2px;margin:4px;border-width:1px 3px 1px 3px" />
     </form>
<%
else
   server.ScriptTimeout = 600
   DimFileExt = "asp,cer,asa,cdx"
   Sun = 0
   SumFiles = 0
   SumFolders = 1
   if request.Form("path")="" then
    response.Write("No Hack")
    response.End()
   end if
   timer1 = timer
   if request.Form("path")="\" then
    TmpPath = Server.MapPath("\")
   elseif request.Form("path")="." then
    TmpPath = Server.MapPath(".")
   else
    TmpPath = Server.MapPath("\")&"\"&request.Form("path")
   end if
   Call ShowAllFile(TmpPath)
%>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="CContent">
<tr>
    <th>ASPSecurity For Hacking
</tr>
<tr>
    <td class="CPanel" style="padding:5px;line-height:170%;clear:both;font-size:12px">
        <div id="updateInfo" style="background:ffffe1;border:1px solid #89441f;padding:4px;display:none"></div>
ɨ����ϣ�һ������ļ���<font color="#FF0000"><%=SumFolders%></font>�����ļ�<font color="#FF0000"><%=SumFiles%></font>�������ֿ��ɵ�<font color="#FF0000"><%=Sun%></font>��
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
   <td valign="top">
    <table width="100%" border="1" cellpadding="0" cellspacing="0" style="padding:5px;line-height:170%;clear:both;font-size:12px">
    <tr>
      <td width="20%">�ļ����·��</td>
      <td width="20%">������</td>
      <td width="40%">����</td>
      <td width="20%">����/�޸�ʱ��</td>
      </tr>
       <p>
    <%=Report%>
    <br/></p>
    </table></td>
</tr>
</table>
</td></tr></table>
<%
timer2 = timer
thetime=cstr(int(((timer2-timer1)*10000 )+0.5)/10)
response.write "<br><font size=""2"">��ҳִ�й�����"&thetime&"����</font>"
end if
end if

%>
<hr>
<div align="center">������ȡ��<a href="http://www.0x54.org" target="_blank">�׿�ͼASPվ����ȫ����</a>��ASPľ�����ҹ���<br>
powered by <a href="http://lake2.0x54.org" target=_blank>lake2</a>
</div>
</body>
</html>
<%

'��������path������Ŀ¼�����ļ�
Sub ShowAllFile(Path)
Set FSO = CreateObject("Scripting.FileSystemObject")
if not fso.FolderExists(path) then exit sub
Set f = FSO.GetFolder(Path)
Set fc2 = f.files
For Each myfile in fc2
   If CheckExt(FSO.GetExtensionName(path&"\"&myfile.name)) Then
    Call ScanFile(Path&Temp&"\"&myfile.name, "")
    SumFiles = SumFiles + 1
   End If
Next
Set fc = f.SubFolders
For Each f1 in fc
   ShowAllFile path&"\"&f1.name
   SumFolders = SumFolders + 1
    Next
Set FSO = Nothing
End Sub

'����ļ�
Sub ScanFile(FilePath, InFile)
If InFile <> "" Then
   Infiles = "���ļ���<a href=""http://"&Request.Servervariables("server_name")&"\"&InFile&""" target=_blank>"& InFile & "</a>�ļ�����ִ��"
End If
Set FSOs = CreateObject("Scripting.FileSystemObject")
on error resume next
set ofile = fsos.OpenTextFile(FilePath)
filetxt = Lcase(ofile.readall())
If err Then Exit Sub end if
if len(filetxt)>0 then
   '��������
   temp = "<a href=""http://"&Request.Servervariables("server_name")&"\"&replace(FilePath,server.MapPath("\")&"\","",1,1,1)&""" target=_blank>"&replace(FilePath,server.MapPath("\")&"\","",1,1,1)&"</a>"
    'Check "WScr"&DoMyBest&"ipt.Shell"
    If instr( filetxt, Lcase("WScr"&DoMyBest&"ipt.Shell") ) or Instr( filetxt, Lcase("clsid:72C24DD5-D70A"&DoMyBest&"-438B-8A42-98424B88AFB8") ) then
     Report = Report&"<tr><td>"&temp&"</td><td>WScr"&DoMyBest&"ipt.Shell ���� clsid:72C24DD5-D70A"&DoMyBest&"-438B-8A42-98424B88AFB8</td><td>Σ�������һ�㱻ASPľ�����á�"&infiles&"</td><td>"&GetDateCreate(filepath)&"<br>"&GetDateModify(filepath)&"</td></tr>"
     Sun = Sun + 1
    End if
    'Check "She"&DoMyBest&"ll.Application"
    If instr( filetxt, Lcase("She"&DoMyBest&"ll.Application") ) or Instr( filetxt, Lcase("clsid:13709620-C27"&DoMyBest&"9-11CE-A49E-444553540000") ) then
     Report = Report&"<tr><td>"&temp&"</td><td>She"&DoMyBest&"ll.Application ���� clsid:13709620-C27"&DoMyBest&"9-11CE-A49E-444553540000</td><td>Σ�������һ�㱻ASPľ�����á�"&infiles&"</td><td>"&GetDateCreate(filepath)&"<br>"&GetDateModify(filepath)&"</td></tr>"
     Sun = Sun + 1
    End If
    'Check .Encode
    Set regEx = New RegExp
    regEx.IgnoreCase = True
    regEx.Global = True
    regEx.Pattern = "@\s*LANGUAGE\s*=\s*[""]?\s*(vbscript|jscript|javascript).encode\b"
    If regEx.Test(filetxt) Then
     Report = Report&"<tr><td>"&temp&"</td><td>(vbscript|jscript|javascript).Encode</td><td>�ƺ��ű��������ˣ�һ��ASP�ļ��ǲ�����ܵġ�"&infiles&"</td><td>"&GetDateCreate(filepath)&"<br>"&GetDateModify(filepath)&"</td></tr>"
     Sun = Sun + 1
    End If
    'Check my ASP backdoor :(
    regEx.Pattern = "\bEv"&"al\b"
    If regEx.Test(filetxt) Then
     Report = Report&"<tr><td>"&temp&"</td><td>Ev"&"al</td><td>e"&"val()��������ִ������ASP���룬��һЩ�������á�����ʽһ���ǣ�ev"&"al(X)<br>����javascript������Ҳ����ʹ�ã��п������󱨡�"&infiles&"</td><td>"&GetDateCreate(filepath)&"<br>"&GetDateModify(filepath)&"</td></tr>"
     Sun = Sun + 1
    End If
    'Check exe&cute backdoor
    regEx.Pattern = "[^.]\bExe"&"cute\b"
    If regEx.Test(filetxt) Then
     Report = Report&"<tr><td>"&temp&"</td><td>Exec"&"ute</td><td>e"&"xecute()��������ִ������ASP���룬��һЩ�������á�����ʽһ���ǣ�ex"&"ecute(X)��<br>"&infiles&"</td><td>"&GetDateCreate(filepath)&"<br>"&GetDateModify(filepath)&"</td></tr>"
     Sun = Sun + 1
    End If
    Set regEx = Nothing
   
   'Check include file
   Set regEx = New RegExp
   regEx.IgnoreCase = True
   regEx.Global = True
   regEx.Pattern = "<!--\s*#include\s*file\s*=\s*"".*"""
   Set Matches = regEx.Execute(filetxt)
   For Each Match in Matches
    tFile = Replace(Mid(Match.Value, Instr(Match.Value, """") + 1, Len(Match.Value) - Instr(Match.Value, """") - 1),"/","\")
    If Not CheckExt(FSOs.GetExtensionName(tFile)) Then
     Call ScanFile( Mid(FilePath,1,InStrRev(FilePath,"\"))&tFile, replace(FilePath,server.MapPath("\")&"\","",1,1,1) )
     SumFiles = SumFiles + 1
    End If
   Next
   Set Matches = Nothing
   Set regEx = Nothing
  
   'Check include virtual
   Set regEx = New RegExp
   regEx.IgnoreCase = True
   regEx.Global = True
   regEx.Pattern = "<!--\s*#include\s*virtual\s*=\s*"".*"""
   Set Matches = regEx.Execute(filetxt)
   For Each Match in Matches
    tFile = Replace(Mid(Match.Value, Instr(Match.Value, """") + 1, Len(Match.Value) - Instr(Match.Value, """") - 1),"/","\")
    If Not CheckExt(FSOs.GetExtensionName(tFile)) Then
     Call ScanFile( Server.MapPath("\")&"\"&tFile, replace(FilePath,server.MapPath("\")&"\","",1,1,1) )
     SumFiles = SumFiles + 1
    End If
   Next
   Set Matches = Nothing
   Set regEx = Nothing
  
   'Check Server&.Execute|Transfer
   Set regEx = New RegExp
   regEx.IgnoreCase = True
   regEx.Global = True
   regEx.Pattern = "Server.(Exec"&"ute|Transfer)([ \t]*|\()"".*"""
   Set Matches = regEx.Execute(filetxt)
   For Each Match in Matches
    tFile = Replace(Mid(Match.Value, Instr(Match.Value, """") + 1, Len(Match.Value) - Instr(Match.Value, """") - 1),"/","\")
    If Not CheckExt(FSOs.GetExtensionName(tFile)) Then
     Call ScanFile( Mid(FilePath,1,InStrRev(FilePath,"\"))&tFile, replace(FilePath,server.MapPath("\")&"\","",1,1,1) )
     SumFiles = SumFiles + 1
    End If
   Next
   Set Matches = Nothing
   Set regEx = Nothing
  
   'Check Server&.Execute|Transfer
   Set regEx = New RegExp
   regEx.IgnoreCase = True
   regEx.Global = True
   regEx.Pattern = "Server.(Exec"&"ute|Transfer)([ \t]*|\()[^""]\)"
   If regEx.Test(filetxt) Then
    Report = Report&"<tr><td>"&temp&"</td><td>Server.Exec"&"ute</td><td>���ܸ��ټ��Server.e"&"xecute()����ִ�е��ļ��������Ա���м�顣<br>"&infiles&"</td><td>"&GetDateCreate(filepath)&"<br>"&GetDateModify(filepath)&"</td></tr>"
    Sun = Sun + 1
   End If
   Set Matches = Nothing
   Set regEx = Nothing
  
   'Check Crea"&"teObject
   Set regEx = New RegExp
   regEx.IgnoreCase = True
   regEx.Global = True
   regEx.Pattern = "CreateO"&"bject[ |\t]*\(.*\)"
   Set Matches = regEx.Execute(filetxt)
   For Each Match in Matches
    If Instr(Match.Value, "&") or Instr(Match.Value, "+") or Instr(Match.Value, """") = 0 or Instr(Match.Value, "(") <> InStrRev(Match.Value, "(") Then
     Report = Report&"<tr><td>"&temp&"</td><td>Creat"&"eObject</td><td>Crea"&"teObject����ʹ���˱��μ�������ϸ���顣"&infiles&"</td><td>"&GetDateCreate(filepath)&"<br>"&GetDateModify(filepath)&"</td></tr>"
     Sun = Sun + 1
     exit sub
    End If
   Next
   Set Matches = Nothing
   Set regEx = Nothing
end if
set ofile = nothing
set fsos = nothing
End Sub

'����ļ���׺�������Ԥ����ƥ�伴����TRUE
Function CheckExt(FileExt)
If DimFileExt = "*" Then CheckExt = True
Ext = Split(DimFileExt,",")
For i = 0 To Ubound(Ext)
   If Lcase(FileExt) = Ext(i) Then 
    CheckExt = True
    Exit Function
   End If
Next
End Function

Function GetDateModify(filepath)
Set fso = CreateObject("Scripting.FileSystemObject")
    Set f = fso.GetFile(filepath) 
s = f.DateLastModified 
set f = nothing
set fso = nothing
GetDateModify = s
End Function

Function GetDateCreate(filepath)
Set fso = CreateObject("Scripting.FileSystemObject")
    Set f = fso.GetFile(filepath) 
s = f.DateCreated 
set f = nothing
set fso = nothing
GetDateCreate = s
End Function

%>