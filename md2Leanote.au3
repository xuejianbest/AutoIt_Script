#cs -----------------------------------------------------------
# 此脚本将指定目录下的所有.md文件保存到leanote笔记
# 笔记内容为文件内容，笔记标题为文件名
#ce -----------------------------------------------------------

$dirPath = "D:\AU3\blog\*.md" ;; 将该路径下所有.md文件写到笔记

;; 遍历.md文件并获取文件名和文件内容
$search = FileFindFirstFile($dirPath)
If $search <> -1 Then
   while 1
	  $file = FileFindNextFile($search)
	  If @error = 1 Then
		 FileClose($search)
		 ExitLoop
	  Else
		 $filePath = StringReplace($dirPath, "*.md", "") & $file

		 $mdfile = FileOpen($filePath)
		 $content = FileRead($mdfile)
		 FileClose($mdfile)
		 createNote($file, $content)
	  EndIf
	  sleep(1000)
   WEnd
EndIf

;; 创建指定标题的笔记，并输入指定内容。
Func createNote($title, $content)
   ClipPut(StringReplace($title, ".md", ""))
   MouseClick("left", 1089, 47, 1, 3)  ;; 点击笔记标题输入框
   sleep(500)
   Send("^v")
   sleep(200)

   ClipPut($content)
   MouseClick("left", 1217, 273, 1, 3) ;; 点击笔记内容输入框
   sleep(500)
   Send("^v")
   sleep(1000)

   Send("^s")
   sleep(1000)
EndFunc









