!addplug local function callback_res(extra, success, result)
 info = "اسم کامل#<: "..result.print_name.."\n"
 ..">#اسم: "..(result.first_name or "").."\n"
 ..">#لقب: "..(result.last_name or "").."\n"
 ..">#یوزرنیم: "..(result.username or "").."\n"
 ..">#ایدی تلگرام: "..result.id.."\n"
 send_large_msg(org_chat_id, info)
end
 
local function callback_reply(extra, success, result)
 if result.media then
  if result.media.type == "document" then
   msg_type = "document"
  elseif result.media.type == "photo" then
   msg_type = "photo"
  elseif result.media.type == "video" then
   msg_type = "video"
  elseif result.media.type == "audio" then
   msg_type = "audio"
  end
 elseif result.text then
  msg_type = "text"
 end
 if is_sudo(result) then
  rank = "sudo(پدر)"
 elseif is_admin(result) then
  rank = "admin(ادمین)"
 elseif is_momod(result) then
  rank = "moderator(مدیر گروه)"
 else
  rank = "member(ممبر)"
 end
 info = "اسم کامل#>: "..result.from.print_name.."\n"
 ..">#اسم: "..(result.from.first_name or "").."\n"
 ..">#لقب: "..(result.from.last_name or "").."\n"
 ..">#یوزرنیم: "..(result.from.username or "").."\n"
 ..">#ایدی تلگرام: "..result.from.id.."\n\n"
 ..">#مقام: "..rank.."\n\n"
 .."msg type: "..msg_type.."\n\n"
 ..">#اسم گروه: "..result.to.print_name.."\n"
 ..">#ایدی گروه: "..result.to.id
 send_large_msg(org_chat_id, info)
end

local function run(msg, matches)
 org_chat_id = "chat#id"..msg.to.id
 if #matches == 3 then
  return res_user(matches[3], callback_res, cbres_extra)
 elseif #matches == 1 then
  if not msg.reply_id then
   if is_sudo(msg) then
    rank = "پدر(sudo)"
   elseif is_admin(msg) then
    rank = "ادمین(admin)"
   elseif is_momod(msg) then
    rank = "مدیر گروه(owner)"
   else
    rank = "(member)ممبر"
   end
   info = "اسم کامل#<: "..msg.from.print_name.."\n"
   ..">#اسم: "..(msg.from.first_name or "").."\n"
   ..">#لقب: "..(msg.from.last_name or "").."\n"
   ..">#یوزرنیم: "..(msg.from.username or "").."\n"
   ..">#ایدی تلگرام: "..msg.from.id.."\n\n"
   ..">#مقام: "..rank.."\n\n"
   ..">#اسم گروه: "..msg.to.print_name.."\n"
   ..">#ایدی گروه: "..msg.to.id
   return info
  else
   return get_message(msg.reply_id, callback_reply, false)
  end
 else
  return "bad command!"
 end
end

return {
 description = "User Infomation",
 usage = {
  "!info : your information",
  "!info [reply] : target information",
  "!info [@username] : target username information",
 }, 
 patterns = {
  "^[!/#]([Ii]nfo) (@)(.+)$",
  "^[!/#]([Ii]nfo) (.+)$",
  "^[!/#]([Ii]nfo)$",
 },
 run = run,
} info
