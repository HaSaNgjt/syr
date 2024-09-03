URL     = require("./libs/url")
JSON    = require("./libs/dkjson")
serpent = require("libs/serpent")
json = require('libs/json')
Redis = require('libs/redis').connect('127.0.0.1', 6379)
http  = require("socket.http")
https   = require("ssl.https")
SshId = io.popen("echo $SSH_CLIENT ︙ awk '{ print $1}'"):read('*a')
Merotele = require 'MeroTele'
local FileInformation = io.open("./Information.lua","r")
if not FileInformation then
if not Redis:get(SshId.."Info:Redis:Token") then
io.write('\27[1;31mارسل لي توكن البوت الان \nSend Me a Bot Token Now ↡\n\27[0;39;49m')
local TokenBot = io.read()
if TokenBot and TokenBot:match('(%d+):(.*)') then
local url , res = https.request('https://api.telegram.org/bot'..TokenBot..'/getMe')
local Json_Info = JSON.decode(url)
if res ~= 200 then
print('\27[1;34mعذرا توكن البوت خطأ تحقق منه وارسله مره اخره \nBot Token is Wrong\n')
else
io.write('\27[1;34mتم حفظ التوكن بنجاح \nThe Token been saved successfully \n\27[0;39;49m')
TheTokenBot = TokenBot:match("(%d+)")
os.execute('sudo rm -fr .CallBack-Bot/'..TheTokenBot)
Redis:set(SshId.."Info:Redis:Token",TokenBot)
Redis:set(SshId.."Info:Redis:Token:User",Json_Info.result.username)
end 
else
print('\27[1;34mلم يتم حفظ التوكن جرب مره اخره \nToken not saved, try again')
end 
os.execute('lua5.2 Bot.lua')
end
if not Redis:get(SshId.."Info:Redis:User") then
io.write('\27[1;31mارسل معرف المطور الاساسي الان \nDeveloper UserName saved ↡\n\27[0;39;49m')
local UserSudo = io.read():gsub('@','')
if UserSudo ~= '' then
io.write('\n\27[1;34mتم حفظ معرف المطور \nDeveloper UserName saved \n\n\27[0;39;49m')
Redis:set(SshId.."Info:Redis:User",UserSudo)
else
print('\n\27[1;34mلم يتم حفظ معرف المطور الاساسي \nDeveloper UserName not saved\n')
end 
os.execute('lua5.2 Bot.lua')
end
if not Redis:get(SshId.."Info:Redis:User:ID") then
io.write('\27[1;31mارسل ايدي المطور الاساسي الان \nDeveloper ID saved ↡\n\27[0;39;49m')
local UserId = io.read()
if UserId and UserId:match('(%d+)') then
io.write('\n\27[1;34mتم حفظ ايدي المطور \nDeveloper ID saved \n\n\27[0;39;49m')
Redis:set(SshId.."Info:Redis:User:ID",UserId)
else
print('\n\27[1;34mلم يتم حفظ ايدي المطور الاساسي \nDeveloper ID not saved\n')
end 
os.execute('lua5.2 Bot.lua')
end
local Informationlua = io.open("Information.lua", 'w')
Informationlua:write([[
return {
Token = "]]..Redis:get(SshId.."Info:Redis:Token")..[[",
UserBot = "]]..Redis:get(SshId.."Info:Redis:Token:User")..[[",
UserSudo = "]]..Redis:get(SshId.."Info:Redis:User")..[[",
SudoId = ]]..Redis:get(SshId.."Info:Redis:User:ID")..[[
}
]])
Informationlua:close()
local Start = io.open("Start", 'w')
Start:write([[
cd $(cd $(dirname $0); pwd)
while(true) do
sudo lua5.2 Bot.lua
done
]])
Start:close()
local Run = io.open("Run", 'w')
Run:write([[
cd $(cd $(dirname $0); pwd)
while(true) do
screen -S BotInstall -X kill
screen -S BotInstall ./Start
done
]])
Run:close()
Redis:del(SshId.."Info:Redis:User:ID");Redis:del(SshId.."Info:Redis:User");Redis:del(SshId.."Info:Redis:Token:User");Redis:del(SshId.."Info:Redis:Token")
os.execute('chmod +x Start;chmod +x Run;./Run')
end
Information = dofile('./Information.lua')
Sudo_Id = Information.SudoId
UserSudo = Information.UserSudo
Token = Information.Token
UserBot = Information.UserBot
bot_id = Token:match("(%d+)")
os.execute('sudo rm -fr .CallBack-Bot/'..bot_id)
merolua = Merotele.set_config{api_id=2692371,api_hash='fe85fff033dfe0f328aeb02b4f784930',session_name=bot_id,token=Token}
function var(value)  
print(serpent.block(value, {comment=false}))   
end 
function chat_type(ChatId)
if ChatId then
local id = tostring(ChatId)
if id:match("-100(%d+)") then
Chat_Type = 'GroupBot' 
elseif id:match("^(%d+)") then
Chat_Type = 'UserBot' 
else
Chat_Type = 'GroupBot' 
end
end
return Chat_Type
end
function The_ControllerAll(msg)
ControllerAll = false
local ListSudos ={Sudo_Id,6590885543}
for k, v in pairs(ListSudos) do
if tonumber(msg.sender_id.user_id) == tonumber(v) then
ControllerAll = true
end
end
return ControllerAll
end
function scandirfile(directory)
local i, t, popen = 0, {}, io.popen
for filename in popen('ls '..directory..''):lines() do
i = i + 1
t[i] = filename
end
return t
end
function exi_filesx(cpath)
local files = {}
local pth = cpath
for k, v in pairs(scandirfile(pth)) do
table.insert(files, v)
end
return files
end
function file_exia(name, cpath)
for k,v in pairs(exi_filesx(cpath)) do
if name == v then
return true
end
end
return false
end


function File_Bot_Run(msg,data)  
--var(msg)
local msg_chat_id = msg.chat_id
local msg_reply_id = msg.reply_to_message_id
local msg_user_send_id = msg.sender_id.user_id
local msg_id = msg.id
local text = nil
if msg.date and msg.date < tonumber(os.time() - 15) then
print("->> Old Message End <<-")
return false
end
if data.content.text then
text = data.content.text.text
end
if tonumber(msg.sender_id.user_id) == tonumber(bot_id) then
print('This is reply for Bot')
return false
end
--------------------------------------------------------------------------------------------------------------
if chat_type(msg.chat_id) == 'UserBot' then
if text == '/start' then
Redis:sadd(bot_id.."Num:Usersall",msg.sender_id.user_id)
if The_ControllerAll(msg) then
local reply_markup = merolua.replyMarkup{type = 'keyboard',resize = true,is_personal = true,
data = {
{
{text = 'ايقاف/حذف بوت ↯',type = 'text'},{text = 'انشاء بوت ↯', type = 'text'},
},
{
{text = 'السكرينات ↯',type = 'text'},{text = 'تشغيل بوت ↯', type = 'text'},
},
{
{text = 'غلق سكرين ↯',type = 'text'},{text = 'السيرفر ↯', type = 'text'},
},
{
{text = 'الملفات ↯', type = 'text'},
},
{
{text = 'تعطيل التنصيب المجاني ↯',type = 'text'},{text = 'تفعيل التنصيب المجاني ↯',type = 'text'},
},
{
{text = 'تاريخ انشاء البوت ↯',type = 'text'},{text = 'جلب التوكن ↯', type = 'text'},
},
{
{text = 'عدد المشتركين في المصنع ↯',type = 'text'},
},
{
{text = 'عدد المصنوعات ↯',type = 'text'},
},
{
{text = "تحديث ↯",type = 'text'},
},
{
{text = 'الغاء ✖',type = 'text'} 
},
}
}
return merolua.sendText(msg_chat_id,msg_id,'↯︙ اهلا بك عزيزي المطور ', 'md', false, false, false, false, reply_markup)
else
if not Redis:get(bot_id.."Add:Freee:msn") then
return merolua.sendText(msg.chat_id,msg.id, '↯︙المصنع تم تعطيل الوضع المجاني فيه')   
end
local reply_markup = merolua.replyMarkup{type = 'keyboard',resize = true,is_personal = true,
data = {
{
{text = 'ايقاف/حذف بوت ↯',type = 'text'},{text = 'انشاء بوت ↯', type = 'text'},
},
{
{text = 'الغاء ✖',type = 'text'} 
},
}
}
return merolua.sendText(msg_chat_id,msg_id,'↯︙ اهلا بك عزيزي في مصنع البوتات ', 'md', false, false, false, false, reply_markup)
end
end
if The_ControllerAll(msg) then
if text == 'تحديث ↯' then    
merolua.sendText(msg.chat_id,msg.id, '↯︙تم تحديث البوت') 
dofile('Bot.lua')  
end 
if text =='تفعيل التنصيب المجاني ↯' then
Redis:set(bot_id.."Add:Freee:msn",true) 
return merolua.sendText(msg.chat_id,msg.id,'تم تفعيل الوضع المجاني')
end

if text =='source' then
return merolua.sendText(msg.chat_id,msg.id,'@dython , @ssuxs')
end

if text =='تعطيل التنصيب المجاني ↯' then
Redis:del(bot_id.."Add:Freee:msn") 
return merolua.sendText(msg.chat_id,msg.id,'تم تعطيل الوضع المجاني')
end
if text == 'جلب التوكن ↯' then
Redis:set(bot_id.."getinfotoken"..msg.chat_id..":"..msg.sender_id.user_id,'true') 
merolua.sendText(msg.chat_id,msg.id,'↯︙ ارسل لي اسم الملف الان ...')
return false  
end 
if Redis:get(bot_id.."getinfotoken"..msg.chat_id..":"..msg.sender_id.user_id) == 'true' then
if text == 'الغاء ✖' then
merolua.sendText(msg.chat_id,msg.id, '↯︙تم الغاء الامر') 
Redis:del(bot_id.."getinfotoken"..msg.chat_id..":"..msg.sender_id.user_id)
return false  
end 
if file_exia(text,'/root') then
Redis:del(bot_id.."getinfotoken"..msg.chat_id..":"..msg.sender_id.user_id)
local Tokenbots = Redis:get(bot_id.."Set:Token:Bot:Dev"..text) 
local url , res = https.request('https://api.telegram.org/bot'..Tokenbots..'/getMe')
local Json_Info = JSON.decode(url)
if Json_Info.ok == false then
merolua.sendText(msg.chat_id,msg.id, '\n↯︙التوكن تم تغييره ') 
Redis:del(bot_id.."getinfotoken"..msg.chat_id..":"..msg.sender_id.user_id)
return false
end
local NameBot = Json_Info.result.first_name
local UserNameBot = Json_Info.result.username
local NameBot = NameBot:gsub('"','') 
local NameBot = NameBot:gsub("'",'') 
local NameBot = NameBot:gsub('`','') 
local NameBot = NameBot:gsub('*','') 
merolua.sendText(msg.chat_id,msg.id,'\n↯︙معلومات البوت هي : \n↯︙التوكن : `'..Tokenbots..'`\n↯︙ معرف البوت : [@'..UserNameBot..']\n↯︙ اسم البوت : '..NameBot..'\n↯︙ معرف المطور : '..text,"md")
else
merolua.sendText(msg.chat_id,msg.id,'↯︙عذرا ليس هناك ملف بهاذا الاسم\n↯︙قم بارسال اسم الملف مره اخره او ارسل الغاء من الكيبورد')
end
Redis:del(bot_id.."getinfotoken"..msg.chat_id..":"..msg.sender_id.user_id)
return false  
end 
if text == 'تشغيل بوت ↯' then 
Redis:set(bot_id.."Start:Bot:new"..msg.chat_id..":"..msg.sender_id.user_id,'true') 
merolua.sendText(msg.chat_id,msg.id,'↯︙ارسل اسم الملف الان ..')
return false  
end 
if Redis:get(bot_id.."Start:Bot:new"..msg.chat_id..":"..msg.sender_id.user_id) == 'true' then
if text == 'الغاء ✖' then
merolua.sendText(msg.chat_id,msg.id, '↯︙تم الغاء الامر') 
Redis:del(bot_id.."Start:Bot:new:data"..msg.chat_id..":"..msg.sender_id.user_id)
return false  
end 
if file_exia(text,'/root') then
Redis:del(bot_id.."Start:Bot:new"..msg.chat_id..":"..msg.sender_id.user_id)
merolua.sendText(msg.chat_id,msg.id,'↯︙تم تشغيل البوت بنجاح')
os.execute('cd ..;cd '..text..' ;screen -d -m -S '..text..' ./Buka')
else
Redis:del(bot_id.."Start:Bot:new"..msg.chat_id..":"..msg.sender_id.user_id)
merolua.sendText(msg.chat_id,msg.id,'↯︙عذرا ليس هناك ملف بهاذا الاسم\n↯︙قم بارسال اسم الملف مره اخره او ارسل الغاء من الكيبورد')
end
return false  
end 
if text == 'تاريخ انشاء البوت ↯' then
Redis:set(bot_id.."Start:Bot:new:data"..msg.chat_id..":"..msg.sender_id.user_id,'true') 
merolua.sendText(msg.chat_id,msg.id,'↯︙ارسل اسم الملف المصنوع الان ..')
return false  
end 
if Redis:get(bot_id.."Start:Bot:new:data"..msg.chat_id..":"..msg.sender_id.user_id) == 'true' then
if text == 'الغاء ✖' then
merolua.sendText(msg.chat_id,msg.id, '↯︙تم الغاء الامر') 
Redis:del(bot_id.."Start:Bot:new:data"..msg.chat_id..":"..msg.sender_id.user_id)
return false  
end 
if file_exia(text,'/root') then
Redis:del(bot_id.."Start:Bot:new:data"..msg.chat_id..":"..msg.sender_id.user_id)
local datauser = Redis:get(bot_id.."Data:Username"..text) or 'لا يوجد'
merolua.sendText(msg.chat_id,msg.id,datauser)
else
Redis:del(bot_id.."Start:Bot:new:data"..msg.chat_id..":"..msg.sender_id.user_id)
merolua.sendText(msg.chat_id,msg.id,'↯︙عذرا ليس هناك ملف بهاذا الاسم\n↯︙قم بارسال اسم الملف مره اخره او ارسل الغاء من الكيبورد')
end
return false  
end 
if text == 'عدد المشتركين في المصنع ↯' then
local numuser = Redis:scard(bot_id.."Num:Usersall") or 0
merolua.sendText(msg.chat_id,msg.id,'↯︙عدد المشتركين في المصنع : '..numuser)
end
if text == 'السيرفر ↯' then
p = io.popen([[
linux_version=`lsb_release -ds`
memUsedPrc=`free -m | awk 'NR==2{printf "%sMB/%sMB {%.2f%}\n", $3,$2,$3*100/$2 }'`
HardDisk=`df -lh | awk '{if ($6 == "/") { print $3"/"$2" ~ {"$5"}" }}'`
CPUPer=`top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}'`
uptime=`uptime | awk -F'( |,|:)+' '{if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days,",h+0,"hours,",m+0,"minutes."}'`

echo '📟l •⊱ { نظام التشغيل } ⊰•\n*»» '"$linux_version"'*' 
echo '*------------------------------\n*🔖l •⊱ { الذاكره العشوائيه } ⊰•\n*»» '"$memUsedPrc"'*'
echo '*------------------------------\n*💾l •⊱ { وحـده الـتـخـزيـن } ⊰•\n*»» '"$HardDisk"'*'
echo '*------------------------------\n*⚙️l •⊱ { الـمــعــالــج } ⊰•\n*»» '"`grep -c processor /proc/cpuinfo`""Core ~ {$CPUPer%} "'*'
echo '*------------------------------\n*👨🏾‍🔧l •⊱ { الــدخــول } ⊰•\n*»» '`whoami`'*'
echo '*------------------------------\n*🔌l •⊱ { مـده تـشغيـل الـسـيـرفـر } ⊰•  \n*»» '"$uptime"'*'
]]):read('*all')
merolua.sendText(msg.chat_id,msg.id,p,"md")
return false
end
if text == 'غلق سكرين ↯' then
Redis:set(bot_id.."Del:Screen"..msg.chat_id..":"..msg.sender_id.user_id,'true') 
merolua.sendText(msg.chat_id,msg.id,'↯︙ارسل السكرين الان')
return false
end
if Redis:get(bot_id.."Del:Screen"..msg.chat_id..":"..msg.sender_id.user_id) == 'true' then
if text == 'الغاء ✖' then
merolua.sendText(msg.chat_id,msg.id, '↯︙تم الغاء الامر') 
Redis:del(bot_id.."Del:Screen"..msg.chat_id..":"..msg.sender_id.user_id) 
return false  
end 
if text and text:match("^(%d+)(.)(.*)") then
if text:find('install') then
merolua.sendText(msg.chat_id,msg.id, '↯︙عذرا هاذا سكرين لوحة التنصيب\n💠︙ارسل اسم السكرين مره اخره او ارسل من الكيبورد الغاء') 
return false 
end 
Redis:del(bot_id.."Del:Screen"..msg.chat_id..":"..msg.sender_id.user_id) 
merolua.sendText(msg.chat_id,msg.id, '↯︙تم حذف السكرين وايقاف البوت')
os.execute('screen -S '..text..' -X kill')
os.execute('screen -X -S '..text..' quit')
return false  
end 
end 
if text == 'السكرينات ↯' then
i = 0
local t = '↯︙السكرينات الموجوده حاليا \n  - - - - - - - - -\n'
for v in io.popen('ls /var/run/screen/S-root'):lines() do
i = i + 1
t = t..i..'- { `'..v..'` }\n'
end
merolua.sendText(msg.chat_id,msg.id,t,"md")
return false
end
if text == 'الملفات ↯' then
local i = 0
local t = '↯︙الملفات الموجوده حاليا \n  - - - - - - - - -\n'
for v in io.popen('ls /root'):lines() do
i = i +1
t = t..'*'..i..'- * `'..v..'` \n' 
end 
merolua.sendText(msg.chat_id,msg.id,t,"md")
return false
end
if text == 'عدد المصنوعات ↯' then
local i = 0
for v in io.popen('ls /root'):lines() do
local datauser = Redis:get(bot_id.."Data:Username"..v) or ''
local userdev = Redis:get(bot_id.."Dev:Username"..v)
if userdev then
i = i +1
end
end 
merolua.sendText(msg.chat_id,msg.id,'↯︙ عدد البوتات المصنوعه  : '..i)
return false
end
if text == 'ايقاف/حذف بوت ↯' then
Redis:set(bot_id.."Set:Deleate:Dev"..msg.chat_id..":"..msg.sender_id.user_id,'true') 
return merolua.sendText(msg.chat_id,msg.id,'↯︙ارسل لي البوت  المصنوع الان  ...')  
end
if Redis:get(bot_id.."Set:Deleate:Dev"..msg.chat_id..":"..msg.sender_id.user_id) == 'true' then
if text == 'الغاء ✖' then
Redis:del(bot_id.."Set:Deleate:Dev"..msg.chat_id..":"..msg.sender_id.user_id) 
return merolua.sendText(msg.chat_id,msg.id, '↯︙تم الغاء الامر')   
end 
if file_exia(text,'/root') then
if text:find('Install') then
Redis:del(bot_id.."Set:Deleate:Dev"..msg.chat_id..":"..msg.sender_id.user_id)
return merolua.sendText(msg.chat_id,msg.id,'↯︙ عذرا هاذا الملف لا يخصك')
end
Redis:del(bot_id.."Set:Deleate:Dev"..msg.chat_id..":"..msg.sender_id.user_id)
local delbotuser = Redis:get(bot_id..'Redis:Set:InstallBots'..text)
if delbotuser then
Redis:del(bot_id..'Redis:Set:InstallBot'..delbotuser)
end
merolua.sendText(msg.chat_id,msg.id,'↯︙تم حذف الملف')
os.execute('rm -fr ~/'..text)
os.execute('screen -S '..text..' -X kill')
else
Redis:del(bot_id.."Set:Deleate:Dev"..msg.chat_id..":"..msg.sender_id.user_id)
return merolua.sendText(msg.chat_id,msg.id,'↯︙عذرا ليس هناك ملف بهاذا الاسم\n↯︙قم بارسال اسم الملف مره اخره او ارسل الغاء من الكيبورد')
end
end

if text == 'انشاء بوت ↯' then
Redis:set(bot_id.."Set:Token:Bot"..msg.chat_id..":"..msg.sender_id.user_id,'true') 
return merolua.sendText(msg.chat_id,msg.id,'↯︙حسنآ , ارسل لي التوكن الان ...')  
end
if Redis:get(bot_id.."Set:Token:Bot"..msg.chat_id..":"..msg.sender_id.user_id) =='true' then 
if text == 'الغاء ✖' then
Redis:del(bot_id.."Set:Token:Bot"..msg.chat_id..":"..msg.sender_id.user_id) 
return merolua.sendText(msg.chat_id,msg.id, '↯︙تم الغاء الامر')   
end 
if text and text:match("^(%d+)(:)(.*)") then
local url , res = https.request('https://api.telegram.org/bot'..text..'/getMe')
local Json_Info = JSON.decode(url)
if Json_Info.ok == false then
return merolua.sendText(msg.chat_id,msg.id, '\n↯︙التوكن غير صحيح ? \n↯︙ارسله مره اخره او ارسل الغاء من الكيبورد !') 
else
local NameBot = Json_Info.result.first_name
local UserNameBot = Json_Info.result.username
Redis:set(bot_id.."Set:Token:Bot"..msg.chat_id..":"..msg.sender_id.user_id,'true1') 
Redis:set(bot_id..'Token:User'..msg.sender_id.user_id,text)
Redis:set(bot_id..'Token:User:Bot'..msg.sender_id.user_id,UserNameBot)
return merolua.sendText(msg.chat_id,msg.id, '\n↯︙تم حفظ التوكن بنجاح \n↯︙اسم البوت ['..NameBot..']\n↯︙معرف البوت [@'..UserNameBot..']\n↯︙الان ارسل معرف المستخدم ') 
end
end  
end
if Redis:get(bot_id.."Set:Token:Bot"..msg.chat_id..":"..msg.sender_id.user_id) == 'true1' then
Redis:del(bot_id.."Set:Token:Bot"..msg.chat_id..":"..msg.sender_id.user_id) 
if text == 'الغاء ✖' then
Redis:del(bot_id.."Set:Token:Bot"..msg.chat_id..":"..msg.sender_id.user_id) 
return merolua.sendText(msg.chat_id,msg.id, '↯︙تم الغاء الامر')   
end 
local username = string.match(text, "@[%a%d_]+") 
if username then
local UserId_Info = merolua.searchPublicChat(username)
if not UserId_Info.id then
return merolua.sendText(msg_chat_id,msg_id,"\n↯︙عذرآ لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return merolua.sendText(msg_chat_id,msg_id,"\n↯︙عذرآ لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if username and username:match('(%S+)[Bb][Oo][Tt]') then
return merolua.sendText(msg_chat_id,msg_id,"\n↯︙عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
local TokenBots = Redis:get(bot_id..'Token:User'..msg.sender_id.user_id)
local UserNameBots = Redis:get(bot_id..'Token:User:Bot'..msg.sender_id.user_id)
local UserNameSudo = text:gsub('@','')
local IdUserSudo = UserId_Info.id
local Write_Info_Sudo = io.open("./source/Information.lua", 'w')
Write_Info_Sudo:write([[
return {
Token = "]]..TokenBots..[[",
UserBot = "]]..UserNameBots..[[",
UserSudo = "]]..UserNameSudo..[[",
SudoId = ]]..IdUserSudo..[[
}
]])
Write_Info_Sudo:close()
local Jarvis = io.open("./source/Buka", 'w')
Jarvis:write([[
cd $(cd $(dirname $0); pwd)
while(true) do
sudo lua5.2 Buka.lua
done
]])
Jarvis:close()
local Run = io.open("./source/Run", 'w')
Run:write([[
cd $(cd $(dirname $0); pwd)
while(true) do
screen -S @]]..UserNameBots..[[ -X kill 
screen -S @]]..UserNameBots..[[ ./Buka
done
]])
Run:close()
os.execute('cp -a ./source/. ../@'..UserNameBots..' && cd ../@'..UserNameBots..' && chmod +x ./Run && chmod +x ./Buka && screen -d -m -S @'..UserNameBots..' ./Buka')
Redis:del(bot_id.."Set:Token:Bot"..msg.chat_id..":"..msg.sender_id.user_id) 
Redis:del(bot_id..'Token:User:Bot'..msg.sender_id.user_id)
Redis:del(bot_id..'Token:User'..msg.sender_id.user_id)
return merolua.sendText(msg_chat_id, msg_id, "↯︙تم تشغيل البوت على السورس ", 'md')
end
end




end -- The_ControllerAll(msg)


if not The_ControllerAll(msg) then
if text == 'انشاء بوت ↯' then
if not Redis:get(bot_id.."Add:Freee:msn") then
return merolua.sendText(msg.chat_id,msg.id, '↯︙المصنع تم تعطيل الوضع المجاني فيه')   
end
if Redis:get(bot_id..'Redis:Set:InstallBot'..msg.sender_id.user_id) == "Install" then
return merolua.sendText(msg.chat_id,msg.id, '↯︙انت قمت بصنع بوت مسبقا')   
end
Redis:set(bot_id.."Set:Token:Bot"..msg.chat_id..":"..msg.sender_id.user_id,'true') 
return merolua.sendText(msg.chat_id,msg.id,'↯︙حسنآ , ارسل لي التوكن الان ...')  
end
if Redis:get(bot_id.."Set:Token:Bot"..msg.chat_id..":"..msg.sender_id.user_id) =='true' then 
if text == 'الغاء ✖' then
Redis:del(bot_id.."Set:Token:Bot"..msg.chat_id..":"..msg.sender_id.user_id) 
return merolua.sendText(msg.chat_id,msg.id, '↯︙تم الغاء الامر')   
end 
if text and text:match("^(%d+)(:)(.*)") then
local url , res = https.request('https://api.telegram.org/bot'..text..'/getMe')
local Json_Info = JSON.decode(url)
if Json_Info.ok == false then
return merolua.sendText(msg.chat_id,msg.id, '\n↯︙التوكن غير صحيح ? \n↯︙ارسله مره اخره او ارسل الغاء من الكيبورد !') 
end
local NameBot = Json_Info.result.first_name
local UserNameBot = Json_Info.result.username
if file_exia('@'..UserNameBot,'/root') then
return merolua.sendText(msg.chat_id,msg.id, '\n↯︙يوجد بوت مصنوع بهاذا التوكن ') 
end
local UserInfo = merolua.getUser(msg.sender_id.user_id)
if not UserInfo.username then
return merolua.sendText(msg.chat_id,msg.id, '\n↯︙انت لا تمتلك معرف في حسابك يرجى تعيين معرف المستخدم والمحاوله مره اخره') 
end
Redis:set(bot_id..'Redis:Set:IdUser'..msg.sender_id.user_id,msg.sender_id.user_id)
Redis:set(bot_id..'Redis:Set:UserName'..msg.sender_id.user_id,UserInfo.username)
Redis:set(bot_id..'Redis:Set:TokenUser'..msg.sender_id.user_id,text)
Redis:set(bot_id..'Redis:Set:UserNameBot'..msg.sender_id.user_id,UserNameBot)
Redis:del(bot_id.."Set:Token:Bot"..msg.chat_id..":"..msg.sender_id.user_id)
local Text = '↯︙هل انت متاكد من المعلومات الاتيه ؟ \n↯︙اضغط على تشغيل البوت ' 
local reply_markup = merolua.replyMarkup{
type = 'inline',
data = {
{
{text = 'تشغيل البوت ...', data = msg.sender_id.user_id.."/StartBot"}, 
},
{
{text = '- Cancel , الغاء الامر', data = msg.sender_id.user_id.."/CancelBot"}, 
},
}
}
return merolua.sendText(msg_chat_id, msg_id, '\n↯︙تم حفظ التوكن بنجاح \n\n↯︙اسم البوت ['..NameBot..']\n↯︙معرف البوت [@'..UserNameBot..']\n\n↯︙معرف المطور : [@'..UserInfo.username..']\n'..Text, 'md', false, false, false, false, reply_markup)
end
end  

if text == 'ايقاف/حذف بوت ↯' then
if Redis:get(bot_id..'Redis:Set:InstallBot'..msg.sender_id.user_id) ~= "Install" then
return merolua.sendText(msg.chat_id,msg.id, '↯︙انت لم تقم بصنع بوت هنا')   
end
local GetuserBot = Redis:get(bot_id..'Redis:Set:InstallBotdel'..msg.sender_id.user_id)
if GetuserBot then
os.execute('rm -fr ~/'..'@'..GetuserBot)
os.execute('screen -S '..'@'..GetuserBot..' -X kill')
Redis:del(bot_id..'Redis:Set:InstallBot'..msg.sender_id.user_id)
Redis:del(bot_id..'Redis:Set:InstallBotdel'..msg.sender_id.user_id)
return merolua.sendText(msg.chat_id,msg.id,'↯︙تم حذف بوتك من المصنع')
end
end

end -- not The_ControllerAll(msg)

end -- type user

end
function CallBackLua(data) --- هذا الكالباك بي الابديت 
if data and data.Merotele and data.Merotele == "updateNewMessage" then
File_Bot_Run(data.message,data.message)
elseif data and data.Merotele and data.Merotele == "updateNewCallbackQuery" then
Text = merolua.base64_decode(data.payload.data)
IdUser = data.sender_user_id
ChatId = data.chat_id
Msg_id = data.message_id

if Text and Text:match('(.*)/CancelBot') then  
if tonumber(Text:match('(.*)/CancelBot')) == tonumber(IdUser) then
Redis:del(bot_id..'Redis:Set:IdUser'..IdUser)
Redis:del(bot_id..'Redis:Set:UserName'..IdUser)
Redis:del(bot_id..'Redis:Set:TokenUser'..IdUser)
Redis:del(bot_id..'Redis:Set:UserNameBot'..IdUser)
return merolua.editMessageText(ChatId,Msg_id,"\n↯︙تم الغاء عمليه انشاء بوت ", 'md')
end
end
if Text and Text:match('(.*)/StartBot') then  
if tonumber(Text:match('(.*)/StartBot')) == tonumber(IdUser) then
local RedisIdUser = Redis:get(bot_id..'Redis:Set:IdUser'..IdUser)
local SetUserName = Redis:get(bot_id..'Redis:Set:UserName'..IdUser)
local RedisTokenUser = Redis:get(bot_id..'Redis:Set:TokenUser'..IdUser)
local RedisUserNameBot = Redis:get(bot_id..'Redis:Set:UserNameBot'..IdUser)
Redis:set(bot_id..'Redis:Set:InstallBot'..IdUser,'Install')
Redis:set(bot_id..'Redis:Set:InstallBots'..'@'..RedisUserNameBot,IdUser)
Redis:set(bot_id..'Redis:Set:InstallBotdel'..IdUser,RedisUserNameBot)
local Write_Info_Sudo = io.open("./source/Information.lua", 'w')
Write_Info_Sudo:write([[
return {
Token = "]]..RedisTokenUser..[[",
UserBot = "]]..RedisUserNameBot..[[",
UserSudo = "]]..SetUserName..[[",
SudoId = ]]..RedisIdUser..[[
}
]])
Write_Info_Sudo:close()
local Jarvis = io.open("./source/Buka", 'w')
Jarvis:write([[
cd $(cd $(dirname $0); pwd)
while(true) do
sudo lua5.2 Buka.lua
done
]])
Jarvis:close()
local Run = io.open("./source/Run", 'w')
Run:write([[
cd $(cd $(dirname $0); pwd)
while(true) do
screen -S @]]..RedisUserNameBot..[[ -X kill 
screen -S @]]..RedisUserNameBot..[[ ./Buka
done
]])
Run:close()
os.execute('cp -a ./source/. ../@'..RedisUserNameBot..' && cd ../@'..RedisUserNameBot..' && chmod +x ./Run && chmod +x ./Buka && screen -d -m -S @'..RedisUserNameBot..' ./Buka')
local Newbots = '\n↯︙ عزيزي مطور المصنع قام شخص بصنع بوت حمايه خاص فيه \n↯︙معرف الشخص : [@'..SetUserName..']\n↯︙معلومات البوت :\n↯︙التوكن : `'..RedisTokenUser..'`\n↯︙ معرف البوت : [@'..RedisUserNameBot..']'
merolua.sendText(Sudo_Id,Newbots,"md")
Redis:del(bot_id..'Redis:Set:IdUser'..IdUser)
Redis:del(bot_id..'Redis:Set:UserName'..IdUser)
Redis:del(bot_id..'Redis:Set:TokenUser'..IdUser)
Redis:del(bot_id..'Redis:Set:UserNameBot'..IdUser)
return merolua.editMessageText(ChatId,Msg_id,"\n↯︙تم تشغيل سورس Buka \n↯︙البوت : [@"..RedisUserNameBot.."]\n↯︙معرف المطور : [@"..SetUserName.."]\n", 'md')
end
end

end
end
Merotele.run(CallBackLua)