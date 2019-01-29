#cs -----------------------------------------------------------
# 此脚本保存自己csdn的博文到文件
# 博文要求是markdown格式编写
#ce -----------------------------------------------------------

;; 此文件记录了博客编辑地址和博客标题，格式为每行：url title
;; https://mp.csdn.net/postedit/86505013 我的世界、DotA IMBA常用游戏指令
$blogUrlTitleFile = FileOpen("d:\python\url\blog_title.txt", 0)

;; 遍历文件每一行，每个循环将一篇文章保存到.md文件
;; 输出文件位于脚本/可执行程序所在目录下的blog目录下
;; blog目录需要自己创建
While 1
   $line = FileReadLine($blogUrlTitleFile)
   If $line = "" Then
	  ExitLoop
   EndIf
   ;; 获取url和title
   $arr = StringSplit($line, " ")
   $url = $arr[1]
   $title = StringRight($line, StringLen($line) - StringLen($url) - 1)

   ;; 若title包含文件名不允许的字符，则替换为空格
   Local $no_file_name = ["\", "/", ":", "*", "?", '"', "<", ">", "|"]
   for $i = 0 To UBound($no_file_name) - 1
	  $title = StringReplace($title, $no_file_name[$i], "")
   Next

   ;; 判断输出.md文件是否存在，若存在且不为空则跳过，否则保存
   $filePath = @ScriptDir & "\blog\" & $title & ".md"
   If FileExists($filePath) Then
	  If FileGetSize($filePath) <= 0 Then
		 FileDelete($filePath)
		 saveBlog($url, $title)
	  EndIf
   Else
	  saveBlog($url, $title)
   EndIf
WEnd

FileClose($blogUrlTitleFile)
print("全部博文保存完成..")

;;==================================
;; 显示信息
Func print($s)
   MsgBox(0, "print", $s)
EndFunc

;;==================================
;; 保存一篇博文
Func saveBlog($url, $title)
   ;; 先用chrome浏览器打开博文编辑地址
   run("C:\Program Files (x86)\Google\Chrome\Application\chrome.exe " & $url)
   $chrome_open = WinWaitActive("[CLASS:Chrome_WidgetWin_1]", "", 5)
   If $chrome_open > 0 Then
	  ;; 全选、复制
	  sleep(4000)
	  Send("^a")
	  sleep(100)
	  Send("^c")
	  sleep(100)
	  ;; 关闭博文编辑页面标签
	  Send("^w")
	  sleep(500)
	  ;; 将博文内容保存为.md文件，文件名为title
	  Local $file = FileOpen(@ScriptDir & "\blog\" & $title & ".md", 2)
	  sleep(50)
	  FileWrite($file, ClipGet())
	  sleep(500)
	  FileClose($file)
	  sleep(50)
   else
	  Exit
   EndIf
EndFunc




