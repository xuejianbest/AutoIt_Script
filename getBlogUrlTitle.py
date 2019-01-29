# 此脚本爬取自己csdn博文的编辑地址和标题
#
# 运行脚本前先启动浏览器，并登入csdn账号
# "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" --remote-debugging-port=9222 --user-data-dir="C:\selenum\AutomationProfile"
#
from selenium import webdriver
from bs4 import BeautifulSoup
from selenium.webdriver.chrome.options import Options
import time
base_url = "https://mp.csdn.net"

#若是想爬取其他分类下文章，只需要替换url变量
#全部文章列表页面
#url = "https://mp.csdn.net/postlist/list/all/%d"
#公开文章列表页面
url = "https://mp.csdn.net/postlist/list/enable/%d"

file = open("url/blog_title.txt", "w", encoding='utf-8')

#文章管理中博文列表的页数，此处一共24页
for i in range(1, 25):
    chrome_options = Options()
    # 使用已打开的浏览器，提前登陆csdn账号
    chrome_options.add_experimental_option("debuggerAddress", "127.0.0.1:9222")
    driver = webdriver.Chrome(chrome_options=chrome_options)

    driver.get(url % i)
    html = driver.page_source  #获取当前标签的html内容
    
    soup = BeautifulSoup(html, 'lxml')
    list_div = soup.find(id="pills-home").find_all("div", class_="list-item-title")
    
    list_a = []
    for div in list_div:
        list_a.append(div.find("a"))
    
    for a in list_a:
        blogurl = base_url + a['href']
        blogtitle = a.get_text()
        file.write(blogurl + " " + blogtitle + "\n")
      
    time.sleep(3)

file.close()
print("完成...")