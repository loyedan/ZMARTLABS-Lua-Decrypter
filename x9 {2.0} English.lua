function jsonum()
targetInfo = gg.getTargetInfo()
app = targetInfo.packageName
local utf8 = {}
local bit = {
  data32 = {}
}
do
  do
    for SRD1_5_ = 1, 32 do
      bit.data32[SRD1_5_] = 2 ^ (32 - SRD1_5_)
    end
  end
end
local toby = string.byte
function utf8.charbytes(s, i)
  i = i or 1
  local c = string.byte(s, i)
  if c > 0 and c <= 127 then
    do return 1 end
    return
  end
  if c >= 194 and c <= 223 then
    do return 2 end
    return
  end
  if c >= 224 and c <= 239 then
    do return 3 end
    return
  end
  if c >= 240 and c <= 244 then
    return 4
  end
  return 1
end

local ded
function bit:d2b(arg)
  if arg == nil then
    return
  end
  local tr, c = {}, arg < 0
  if c then
    arg = 0 - arg
  end
  do
    do
      for SRD1_7_ = 1, 32 do
        if arg >= self.data32[SRD1_7_] then
          tr[SRD1_7_] = 1
          arg = arg - self.data32[SRD1_7_]
        else
          tr[SRD1_7_] = 0
        end
      end
    end
  end
  if c then
    tr = self:_bnot(tr)
    tr = self:b2d(tr) + 1
    tr = self:d2b(tr)
  end
  return tr
end

function bit:b2d(arg, neg)
  local nr = 0
  if arg[1] == 1 and neg == true then
    arg = self:_bnot(arg)
    nr = self:b2d(arg) + 1
    nr = 0 - nr
  else
    do
      for SRD1_7_ = 1, 32 do
        if arg[SRD1_7_] == 1 then
          nr = nr + 2 ^ (32 - SRD1_7_)
        end
      end
    end
  end
  return nr
end

function bit:_and(a, b)
  local op1 = self:d2b(a)
  local op2 = self:d2b(b)
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == 1 and op2[SRD1_9_] == 1 then
          r[SRD1_9_] = 1
        else
          r[SRD1_9_] = 0
        end
      end
    end
  end
  return self:b2d(r, true)
end

function bit:_or(a, b)
  local op1 = self:d2b(a)
  local op2 = self:d2b(b)
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == 1 or op2[SRD1_9_] == 1 then
          r[SRD1_9_] = 1
        else
          r[SRD1_9_] = 0
        end
      end
    end
  end
  return self:b2d(r, true)
end

function bit:_xor(a, b)
  local op1 = self:d2b(a)
  if op1 == nil then
    return nil
  end
  local op2 = self:d2b(b)
  if op2 == nil then
    return nil
  end
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == op2[SRD1_9_] then
          r[SRD1_9_] = 0
        else
          r[SRD1_9_] = 1
        end
      end
    end
  end
  return self:b2d(r, true)
end

local switch = {
  [1] = function(s, pos)
    local c1 = toby(s, pos)
    return c1
  end
  ,
  [2] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local int1 = bit:_and(31, c1)
    local int2 = bit:_and(63, c2)
    return bit:_or(bit:_lshift(int1, 6), int2)
  end
  ,
  [3] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local c3 = toby(s, pos + 2)
    local int1 = bit:_and(15, c1)
    local int2 = bit:_and(63, c2)
    local int3 = bit:_and(63, c3)
    local o2 = bit:_or(bit:_lshift(int1, 12), bit:_lshift(int2, 6))
    local dt = bit:_or(o2, int3)
    return dt
  end
  ,
  [4] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local c3 = toby(s, pos + 2)
    local c4 = toby(s, pos + 3)
    local int1 = bit:_and(15, c1)
    local int2 = bit:_and(63, c2)
    local int3 = bit:_and(63, c3)
    local int4 = bit:_and(63, c4)
    local o2 = bit:_or(bit:_lshift(int1, 18), bit:_lshift(int2, 12))
    local o3 = bit:_or(o2, bit:_lshift(int3, 6))
    local o4 = bit:_or(o3, int4)
    return o4
  end
  
}
function bit:_bnot(op1)
  local r = {}
  do
    do
      for SRD1_6_ = 1, 32 do
        if op1[SRD1_6_] == 1 then
          r[SRD1_6_] = 0
        else
          r[SRD1_6_] = 1
        end
      end
    end
  end
  return r
end

function bit:_not(a)
  local op1 = self:d2b(a)
  local r = self:_bnot(op1)
  return self:b2d(r, true)
end

function bit:charCodeAt(s)
  local pos, int, H, L = 1, 0, 0, 0
  local slen = string.len(s)
  local allByte = {}
  while pos <= slen do
    local tLen = utf8.charbytes(s, pos)
    if tLen >= 1 and tLen <= 4 then
      if tLen == 4 then
        int = switch[4](s, pos)
        H = math.floor((int - 65536) / 1024) + 55296
        L = (int - 65536) % 1024 + 56320
        table.insert(allByte, H)
        table.insert(allByte, L)
      else
        int = switch[tLen](s, pos)
        table.insert(allByte, int)
      end
    end
    pos = pos + tLen
  end
  return allByte
end

function bit:_rshift(a, n)
  local r = 0
  if a < 0 then
    r = 0 - self:_frshift(0 - a, n)
  elseif a >= 0 then
    r = self:_frshift(a, n)
  end
  return r
end

function bit:_frshift(a, n)
  local op1 = self:d2b(a)
  local r = self:d2b(0)
  local left = 32 - n
  if n < 32 and n > 0 then
    do
      for SRD1_9_ = left, 1, -1 do
        r[SRD1_9_ + n] = op1[SRD1_9_]
      end
    end
  end
  return self:b2d(r)
end

function bit:_lshift(a, n)
  local op1 = self:d2b(a)
  local r = self:d2b(0)
  if n < 32 and n > 0 then
    do
      for SRD1_8_ = n, 31 do
        r[SRD1_8_ - n + 1] = op1[SRD1_8_ + 1]
      end
    end
  end
  return self:b2d(r, true)
end

function trim(s)
  return s:match("^%s*(.*)"):match("(.-)%s*$")
end

local json = {}
local kind_of = function(obj)
  if type(obj) ~= "table" then
    return type(obj)
  end
  local i = 1
  do
    do
      for SRD1_5_ in pairs(obj) do
        if obj[i] ~= nil then
          i = i + 1
        else
          return "table"
        end
      end
    end
  end
  if i == 1 then
    do return "table" end
    return
  end
  return "array"
end

local escape_str = function(s)
  local in_char = {
    "\\",
    "\"",
    "/",
    "\b",
    "\f",
    "\n",
    "\r",
    "\t"
  }
  local out_char = {
    "\\",
    "\"",
    "/",
    "b",
    "f",
    "n",
    "r",
    "t"
  }
  do
    do
      for SRD1_6_, SRD1_7_ in ipairs(in_char) do
        s = s:gsub(SRD1_7_, "\\" .. out_char[SRD1_6_])
      end
    end
  end
  return s
end

local skip_delim = function(str, pos, delim, err_if_missing)
  pos = pos + #str:match("^%s*", pos)
  if str:sub(pos, pos) ~= delim then
    if err_if_missing then
      error("Expected " .. delim .. " close position " .. pos)
    end
    return pos, false
  end
  return pos + 1, true
end

local function parse_str_val(str, pos, val)
  val = val or ""
  local early_end_error = "End of input encountered during string parsing."
  if pos > #str then
    error(early_end_error)
  end
  local c = str:sub(pos, pos)
  if c == "\"" then
    return val, pos + 1
  end
  if c ~= "\\" then
    return parse_str_val(str, pos + 1, val .. c)
  end
  local esc_map = {
    b = "\b",
    f = "\f",
    n = "\n",
    r = "\r",
    t = "\t"
  }
  local nextc = str:sub(pos + 1, pos + 1)
  if not nextc then
    error(early_end_error)
  end
  return parse_str_val(str, pos + 2, val .. (esc_map[nextc] or nextc))
end

local parse_num_val = function(str, pos)
  local num_str = str:match("^-?%d+%.?%d*[eE]?[+-]?%d*", pos)
  local val = tonumber(num_str)
  if not val then
    error("Error parsing number at position " .. pos .. ".")
  end
  return val, pos + #num_str
end

function json.stringify(obj, as_key)
  local s = {}
  local kind = kind_of(obj)
  if kind == "array" then
    if as_key then
      error("Unable to encode array as key.")
    end
    s[#s + 1] = "["
    do
      do
        for SRD1_7_, SRD1_8_ in ipairs(obj) do
          if SRD1_7_ > 1 then
            s[#s + 1] = ", "
          end
          s[#s + 1] = json.stringify(SRD1_8_)
        end
      end
    end
    s[#s + 1] = "]"
  elseif kind == "table" then
    if as_key then
      error("Unable to key encode table.")
    end
    s[#s + 1] = "{"
    do
      do
        for SRD1_7_, SRD1_8_ in pairs(obj) do
          if #s > 1 then
            s[#s + 1] = ", "
          end
          s[#s + 1] = json.stringify(SRD1_7_, true)
          s[#s + 1] = ":"
          s[#s + 1] = json.stringify(SRD1_8_)
        end
      end
    end
    s[#s + 1] = "}"
  else
    if kind == "string" then
      do return "\"" .. escape_str(obj) .. "\"" end
      return
    end
    if kind == "number" then
      if as_key then
        return "\"" .. tostring(obj) .. "\""
      end
      do return tostring(obj) end
      return
    end
    if kind == "boolean" then
      do return tostring(obj) end
      return
    end
    if kind == "nil" then
      do return "null" end
      return
    end
    error("unjsonifiable type,: " .. kind .. ".")
  end
  return table.concat(s)
end

json.null = {}
function json.parse(str, pos, end_delim)
  pos = pos or 1
  if pos > #str then
    error("Reached unexpected end of input ")
  end
  local pos = pos + #str:match("^%s*", pos)
  local first = str:sub(pos, pos)
  if first == "{" then
    do
      local obj, key, delim_found = {}, true, true
      pos = pos + 1
      while true do
        key, pos = json.parse(str, pos, "}")
        if key == nil then
          return obj, pos
        end
        if not delim_found then
          error("Missing comma between object items.")
        end
        pos = skip_delim(str, pos, ":", true)
        obj[key], pos = json.parse(str, pos)
        pos, delim_found = skip_delim(str, pos, ",")
      end
    end
    return
  end
  if first == "[" then
    do
      local arr, val, delim_found = {}, true, true
      pos = pos + 1
      while true do
        val, pos = json.parse(str, pos, "]")
        if val == nil then
          return arr, pos
        end
        if not delim_found then
          error("Missing comma between array items.")
        end
        arr[#arr + 1] = val
        pos, delim_found = skip_delim(str, pos, ",")
      end
    end
    return
  end
  if first == "\"" then
    do return parse_str_val(str, pos + 1) end
    return
  end
  if first == "-" or first:match("%d") then
    do return parse_num_val(str, pos) end
    return
  end
  if first == end_delim then
    do return nil, pos + 1 end
    return
  end
  do
    local literals = {
      ["true"] = true,
      ["false"] = false,
      null = json.null
    }
    do
      do
        for SRD1_9_, SRD1_10_ in pairs(literals) do
          local lit_end = pos + #SRD1_9_ - 1
          if str:sub(pos, lit_end) == SRD1_9_ then
            return SRD1_10_, lit_end + 1
          end
        end
      end
    end
    local pos_info_str = "position " .. pos .. ": " .. str:sub(pos, pos + 10)
    error("Invalid json syntax starting at " .. pos_info_str)
  end
end

function enc(data, b)
  return (data:gsub(".", function(x)
    local r, b = "", x:byte()
    do
      do
        for SRD1_6_ = 8, 1, -1 do
          r = r .. (b % 2 ^ SRD1_6_ - b % 2 ^ (SRD1_6_ - 1) > 0 and "1" or "0")
        end
      end
    end
    return r
  end
  ) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(x)
    if #x < 6 then
      return ""
    end
    local c = 0
    do
      do
        for SRD1_5_ = 1, 6 do
          c = c + (x:sub(SRD1_5_, SRD1_5_) == "1" and 2 ^ (6 - SRD1_5_) or 0)
        end
      end
    end
    return b:sub(c + 1, c + 1)
  end
  ) .. ({
    "",
    "??",
    "?"
  })[#data % 3 + 1]
end

function dec(data, b)
  data = string.gsub(data, "[^" .. b .. "=]", "")
  return (data:gsub(".", function(x)
    if x == "?" then
      return ""
    end
    local r, f = "", b:find(x) - 1
    do
      do
        for SRD1_6_ = 6, 1, -1 do
          r = r .. (f % 2 ^ SRD1_6_ - f % 2 ^ (SRD1_6_ - 1) > 0 and "1" or "0")
        end
      end
    end
    return r
  end
  ):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(x)
    if #x ~= 8 then
      return ""
    end
    local c = 0
    do
      do
        for SRD1_5_ = 1, 8 do
          c = c + (x:sub(SRD1_5_, SRD1_5_) == "1" and 2 ^ (8 - SRD1_5_) or 0)
        end
      end
    end
    return string.char(c)
  end
  ))
end
function rwmem(Address, SizeOrBuffer)
assert(Address ~= nil, "[rwmem]: error, given address is null.")
_rw = {}
if type(SizeOrBuffer) == "number" then
_ = ""
for _ = 1, SizeOrBuffer do _rw[_] = {address = (Address - 1) + _, flags = gg.TYPE_BYTE} end
for v, __ in ipairs(gg.getValues(_rw)) do
 if __.value == 00 and limit == true then
 return _
 end
_ = _ .. string.format("%02X", __.value & 0xFF)
end
return _
end
Byte = {} SizeOrBuffer:gsub("..", function(x)
Byte[#Byte + 1] = x _rw[#Byte] = {address = (Address - 1) + #Byte, flags = gg.TYPE_BYTE, value = x .. "h"}
end)
gg.setValues(_rw)
end
local function hexdecode(hex)
return (hex:gsub("%x%x", function(digits) return string.char(tonumber(digits, 16)) end))
end
local function hexencode(str)
return (str:gsub(".", function(char) return string.format("%2x", char:byte()) end))
end
function Dec2Hex(nValue)
nHexVal = string.format("%X", nValue);
sHexVal = nHexVal.."";
return sHexVal;
end
function ToInteger(number)
return math.floor(tonumber(number) or error("It was not possible transmitir '" .. tostring(number) .. "' enumerate.'"))
end

function save(data)
  io.open(gg.EXT_STORAGE .. "/decrypt.txt", "w"):write(data)
  gg.toast("I got you Lionel Richie!")
end

function save2(data)
  io.open(gg.EXT_STORAGE .. "/decrypt.txt", "w"):write(json.stringify(data))
  gg.toast("I got you Lionel Richie!")
end

function configjson(data)
  io.open(gg.EXT_STORAGE .. "/config.txt", "w"):write(data)
  gg.toast(data .. [[

𝙘𝙤𝙥𝙞𝙤𝙪, 𝙛𝙖𝙧𝙞𝙣𝙝𝙖?]])
  print(data, false)
  gg.clearResults()

end

  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("h 7B 0A 20 22 56 65 72 73 69", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("File Not Found ❌")
    json_2 = true
  end
  if json_2 then
    gg.searchNumber("h 7B 0A 20 22 56 65 72 73", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌")
      print([[

calma barboleta]])
      print("\nsink or swim?\n\n")
      os.exit()
    end
  end
  limit = true
  gg.searchNumber("h7B", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1000)
  readedMem = rwmem(r[1].address, 200000)
  configjson(hexdecode(readedMem))
  do
    do
      for SRD1_5_, SRD1_6_ in ipairs(r) do
        r[SRD1_5_].flags = gg.TYPE_FLOAT
        r[SRD1_5_].value = "1000"
      end
    end
  end
gg.setValues(r)
  gg.clearResults()
  gg.toast("File Found ✓")
  print("I got you Lionel Richie!\n\nThe file is at: /sdcard/config.txt")
  gg.clearResults()
os.exit()
end
function revhunter()
targetInfo = gg.getTargetInfo()
app = targetInfo.packageName
local utf8 = {}
local bit = {
  data32 = {}
}
do
  do
    for SRD1_5_ = 1, 32 do
      bit.data32[SRD1_5_] = 2 ^ (32 - SRD1_5_)
    end
  end
end
local toby = string.byte
function utf8.charbytes(s, i)
  i = i or 1
  local c = string.byte(s, i)
  if c > 0 and c <= 127 then
    do return 1 end
    return
  end
  if c >= 194 and c <= 223 then
    do return 2 end
    return
  end
  if c >= 224 and c <= 239 then
    do return 3 end
    return
  end
  if c >= 240 and c <= 244 then
    return 4
  end
  return 1
end

local ded
function bit:d2b(arg)
  if arg == nil then
    return
  end
  local tr, c = {}, arg < 0
  if c then
    arg = 0 - arg
  end
  do
    do
      for SRD1_7_ = 1, 32 do
        if arg >= self.data32[SRD1_7_] then
          tr[SRD1_7_] = 1
          arg = arg - self.data32[SRD1_7_]
        else
          tr[SRD1_7_] = 0
        end
      end
    end
  end
  if c then
    tr = self:_bnot(tr)
    tr = self:b2d(tr) + 1
    tr = self:d2b(tr)
  end
  return tr
end

function bit:b2d(arg, neg)
  local nr = 0
  if arg[1] == 1 and neg == true then
    arg = self:_bnot(arg)
    nr = self:b2d(arg) + 1
    nr = 0 - nr
  else
    do
      for SRD1_7_ = 1, 32 do
        if arg[SRD1_7_] == 1 then
          nr = nr + 2 ^ (32 - SRD1_7_)
        end
      end
    end
  end
  return nr
end

function bit:_and(a, b)
  local op1 = self:d2b(a)
  local op2 = self:d2b(b)
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == 1 and op2[SRD1_9_] == 1 then
          r[SRD1_9_] = 1
        else
          r[SRD1_9_] = 0
        end
      end
    end
  end
  return self:b2d(r, true)
end

function bit:_or(a, b)
  local op1 = self:d2b(a)
  local op2 = self:d2b(b)
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == 1 or op2[SRD1_9_] == 1 then
          r[SRD1_9_] = 1
        else
          r[SRD1_9_] = 0
        end
      end
    end
  end
  return self:b2d(r, true)
end

function bit:_xor(a, b)
  local op1 = self:d2b(a)
  if op1 == nil then
    return nil
  end
  local op2 = self:d2b(b)
  if op2 == nil then
    return nil
  end
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == op2[SRD1_9_] then
          r[SRD1_9_] = 0
        else
          r[SRD1_9_] = 1
        end
      end
    end
  end
  return self:b2d(r, true)
end

local switch = {
  [1] = function(s, pos)
    local c1 = toby(s, pos)
    return c1
  end
  ,
  [2] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local int1 = bit:_and(31, c1)
    local int2 = bit:_and(63, c2)
    return bit:_or(bit:_lshift(int1, 6), int2)
  end
  ,
  [3] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local c3 = toby(s, pos + 2)
    local int1 = bit:_and(15, c1)
    local int2 = bit:_and(63, c2)
    local int3 = bit:_and(63, c3)
    local o2 = bit:_or(bit:_lshift(int1, 12), bit:_lshift(int2, 6))
    local dt = bit:_or(o2, int3)
    return dt
  end
  ,
  [4] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local c3 = toby(s, pos + 2)
    local c4 = toby(s, pos + 3)
    local int1 = bit:_and(15, c1)
    local int2 = bit:_and(63, c2)
    local int3 = bit:_and(63, c3)
    local int4 = bit:_and(63, c4)
    local o2 = bit:_or(bit:_lshift(int1, 18), bit:_lshift(int2, 12))
    local o3 = bit:_or(o2, bit:_lshift(int3, 6))
    local o4 = bit:_or(o3, int4)
    return o4
  end
  
}
function bit:_bnot(op1)
  local r = {}
  do
    do
      for SRD1_6_ = 1, 32 do
        if op1[SRD1_6_] == 1 then
          r[SRD1_6_] = 0
        else
          r[SRD1_6_] = 1
        end
      end
    end
  end
  return r
end

function bit:_not(a)
  local op1 = self:d2b(a)
  local r = self:_bnot(op1)
  return self:b2d(r, true)
end

function bit:charCodeAt(s)
  local pos, int, H, L = 1, 0, 0, 0
  local slen = string.len(s)
  local allByte = {}
  while pos <= slen do
    local tLen = utf8.charbytes(s, pos)
    if tLen >= 1 and tLen <= 4 then
      if tLen == 4 then
        int = switch[4](s, pos)
        H = math.floor((int - 65536) / 1024) + 55296
        L = (int - 65536) % 1024 + 56320
        table.insert(allByte, H)
        table.insert(allByte, L)
      else
        int = switch[tLen](s, pos)
        table.insert(allByte, int)
      end
    end
    pos = pos + tLen
  end
  return allByte
end

function bit:_rshift(a, n)
  local r = 0
  if a < 0 then
    r = 0 - self:_frshift(0 - a, n)
  elseif a >= 0 then
    r = self:_frshift(a, n)
  end
  return r
end

function bit:_frshift(a, n)
  local op1 = self:d2b(a)
  local r = self:d2b(0)
  local left = 32 - n
  if n < 32 and n > 0 then
    do
      for SRD1_9_ = left, 1, -1 do
        r[SRD1_9_ + n] = op1[SRD1_9_]
      end
    end
  end
  return self:b2d(r)
end

function bit:_lshift(a, n)
  local op1 = self:d2b(a)
  local r = self:d2b(0)
  if n < 32 and n > 0 then
    do
      for SRD1_8_ = n, 31 do
        r[SRD1_8_ - n + 1] = op1[SRD1_8_ + 1]
      end
    end
  end
  return self:b2d(r, true)
end

function trim(s)
  return s:match("^%s*(.*)"):match("(.-)%s*$")
end

local json = {}
local kind_of = function(obj)
  if type(obj) ~= "table" then
    return type(obj)
  end
  local i = 1
  do
    do
      for SRD1_5_ in pairs(obj) do
        if obj[i] ~= nil then
          i = i + 1
        else
          return "table"
        end
      end
    end
  end
  if i == 1 then
    do return "table" end
    return
  end
  return "array"
end

local escape_str = function(s)
  local in_char = {
    "\\",
    "\"",
    "/",
    "\b",
    "\f",
    "\n",
    "\r",
    "\t"
  }
  local out_char = {
    "\\",
    "\"",
    "/",
    "b",
    "f",
    "n",
    "r",
    "t"
  }
  do
    do
      for SRD1_6_, SRD1_7_ in ipairs(in_char) do
        s = s:gsub(SRD1_7_, "\\" .. out_char[SRD1_6_])
      end
    end
  end
  return s
end

local skip_delim = function(str, pos, delim, err_if_missing)
  pos = pos + #str:match("^%s*", pos)
  if str:sub(pos, pos) ~= delim then
    if err_if_missing then
      error("Expected " .. delim .. " close position " .. pos)
    end
    return pos, false
  end
  return pos + 1, true
end

local function parse_str_val(str, pos, val)
  val = val or ""
  local early_end_error = "End of input encountered during string parsing."
  if pos > #str then
    error(early_end_error)
  end
  local c = str:sub(pos, pos)
  if c == "\"" then
    return val, pos + 1
  end
  if c ~= "\\" then
    return parse_str_val(str, pos + 1, val .. c)
  end
  local esc_map = {
    b = "\b",
    f = "\f",
    n = "\n",
    r = "\r",
    t = "\t"
  }
  local nextc = str:sub(pos + 1, pos + 1)
  if not nextc then
    error(early_end_error)
  end
  return parse_str_val(str, pos + 2, val .. (esc_map[nextc] or nextc))
end

local parse_num_val = function(str, pos)
  local num_str = str:match("^-?%d+%.?%d*[eE]?[+-]?%d*", pos)
  local val = tonumber(num_str)
  if not val then
    error("Error parsing number at position " .. pos .. ".")
  end
  return val, pos + #num_str
end

function json.stringify(obj, as_key)
  local s = {}
  local kind = kind_of(obj)
  if kind == "array" then
    if as_key then
      error("Unable to encode array as key.")
    end
    s[#s + 1] = "["
    do
      do
        for SRD1_7_, SRD1_8_ in ipairs(obj) do
          if SRD1_7_ > 1 then
            s[#s + 1] = ", "
          end
          s[#s + 1] = json.stringify(SRD1_8_)
        end
      end
    end
    s[#s + 1] = "]"
  elseif kind == "table" then
    if as_key then
      error("Unable to key encode table.")
    end
    s[#s + 1] = "{"
    do
      do
        for SRD1_7_, SRD1_8_ in pairs(obj) do
          if #s > 1 then
            s[#s + 1] = ", "
          end
          s[#s + 1] = json.stringify(SRD1_7_, true)
          s[#s + 1] = ":"
          s[#s + 1] = json.stringify(SRD1_8_)
        end
      end
    end
    s[#s + 1] = "}"
  else
    if kind == "string" then
      do return "\"" .. escape_str(obj) .. "\"" end
      return
    end
    if kind == "number" then
      if as_key then
        return "\"" .. tostring(obj) .. "\""
      end
      do return tostring(obj) end
      return
    end
    if kind == "boolean" then
      do return tostring(obj) end
      return
    end
    if kind == "nil" then
      do return "null" end
      return
    end
    error("unjsonifiable type,: " .. kind .. ".")
  end
  return table.concat(s)
end

json.null = {}
function json.parse(str, pos, end_delim)
  pos = pos or 1
  if pos > #str then
    error("Reached unexpected end of input ")
  end
  local pos = pos + #str:match("^%s*", pos)
  local first = str:sub(pos, pos)
  if first == "{" then
    do
      local obj, key, delim_found = {}, true, true
      pos = pos + 1
      while true do
        key, pos = json.parse(str, pos, "}")
        if key == nil then
          return obj, pos
        end
        if not delim_found then
          error("Missing comma between object items.")
        end
        pos = skip_delim(str, pos, ":", true)
        obj[key], pos = json.parse(str, pos)
        pos, delim_found = skip_delim(str, pos, ",")
      end
    end
    return
  end
  if first == "[" then
    do
      local arr, val, delim_found = {}, true, true
      pos = pos + 1
      while true do
        val, pos = json.parse(str, pos, "]")
        if val == nil then
          return arr, pos
        end
        if not delim_found then
          error("Missing comma between array items.")
        end
        arr[#arr + 1] = val
        pos, delim_found = skip_delim(str, pos, ",")
      end
    end
    return
  end
  if first == "\"" then
    do return parse_str_val(str, pos + 1) end
    return
  end
  if first == "-" or first:match("%d") then
    do return parse_num_val(str, pos) end
    return
  end
  if first == end_delim then
    do return nil, pos + 1 end
    return
  end
  do
    local literals = {
      ["true"] = true,
      ["false"] = false,
      null = json.null
    }
    do
      do
        for SRD1_9_, SRD1_10_ in pairs(literals) do
          local lit_end = pos + #SRD1_9_ - 1
          if str:sub(pos, lit_end) == SRD1_9_ then
            return SRD1_10_, lit_end + 1
          end
        end
      end
    end
    local pos_info_str = "position " .. pos .. ": " .. str:sub(pos, pos + 10)
    error("Invalid json syntax starting at " .. pos_info_str)
  end
end

function enc(data, b)
  return (data:gsub(".", function(x)
    local r, b = "", x:byte()
    do
      do
        for SRD1_6_ = 8, 1, -1 do
          r = r .. (b % 2 ^ SRD1_6_ - b % 2 ^ (SRD1_6_ - 1) > 0 and "1" or "0")
        end
      end
    end
    return r
  end
  ) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(x)
    if #x < 6 then
      return ""
    end
    local c = 0
    do
      do
        for SRD1_5_ = 1, 6 do
          c = c + (x:sub(SRD1_5_, SRD1_5_) == "1" and 2 ^ (6 - SRD1_5_) or 0)
        end
      end
    end
    return b:sub(c + 1, c + 1)
  end
  ) .. ({
    "",
    "??",
    "?"
  })[#data % 3 + 1]
end

function dec(data, b)
  data = string.gsub(data, "[^" .. b .. "=]", "")
  return (data:gsub(".", function(x)
    if x == "?" then
      return ""
    end
    local r, f = "", b:find(x) - 1
    do
      do
        for SRD1_6_ = 6, 1, -1 do
          r = r .. (f % 2 ^ SRD1_6_ - f % 2 ^ (SRD1_6_ - 1) > 0 and "1" or "0")
        end
      end
    end
    return r
  end
  ):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(x)
    if #x ~= 8 then
      return ""
    end
    local c = 0
    do
      do
        for SRD1_5_ = 1, 8 do
          c = c + (x:sub(SRD1_5_, SRD1_5_) == "1" and 2 ^ (8 - SRD1_5_) or 0)
        end
      end
    end
    return string.char(c)
  end
  ))
end
function rwmem(Address, SizeOrBuffer)
assert(Address ~= nil, "[rwmem]: error, given address is null.")
_rw = {}
if type(SizeOrBuffer) == "number" then
_ = ""
for _ = 1, SizeOrBuffer do _rw[_] = {address = (Address - 1) + _, flags = gg.TYPE_BYTE} end
for v, __ in ipairs(gg.getValues(_rw)) do
 if __.value == 00 and limit == true then
 return _
 end
_ = _ .. string.format("%02X", __.value & 0xFF)
end
return _
end
Byte = {} SizeOrBuffer:gsub("..", function(x)
Byte[#Byte + 1] = x _rw[#Byte] = {address = (Address - 1) + #Byte, flags = gg.TYPE_BYTE, value = x .. "h"}
end)
gg.setValues(_rw)
end
local function hexdecode(hex)
return (hex:gsub("%x%x", function(digits) return string.char(tonumber(digits, 16)) end))
end
local function hexencode(str)
return (str:gsub(".", function(char) return string.format("%2x", char:byte()) end))
end
function Dec2Hex(nValue)
nHexVal = string.format("%X", nValue);
sHexVal = nHexVal.."";
return sHexVal;
end
function ToInteger(number)
return math.floor(tonumber(number) or error("It was not possible transmitir '" .. tostring(number) .. "' enumerate.'"))
end

function save(data)
  io.open(gg.EXT_STORAGE .. "/decrypt.txt", "w"):write(data)
  gg.toast("I got you Lionel Richie!")
end

function save2(data)
  io.open(gg.EXT_STORAGE .. "/decrypt.txt", "w"):write(json.stringify(data))
  gg.toast("I got you Lionel Richie!")
end

function configjson(data)
  io.open(gg.EXT_STORAGE .. "/config.txt", "w"):write(data)
  gg.toast(data .. [[

𝙘𝙤𝙥𝙞𝙤𝙪, 𝙛𝙖𝙧𝙞𝙣𝙝𝙖?]])
  print(data, false)
  gg.clearResults()

end

  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("h 7B 0A 20 20 20 20 22 56 65 72 73 69 6F 6E", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("File Not Found ❌")
    json_2 = true
  end
  if json_2 then
    gg.searchNumber("h 7B 0A 20 20 20 20 22 56 65 72 73 69", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌")
      print([[

calma barboleta]])
      print("\nsink or swim?\n\n")
      os.exit()
    end
  end
  limit = true
  gg.searchNumber("h7B", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1000)
  readedMem = rwmem(r[1].address, 200000)
  configjson(hexdecode(readedMem))
  do
    do
      for SRD1_5_, SRD1_6_ in ipairs(r) do
        r[SRD1_5_].flags = gg.TYPE_FLOAT
        r[SRD1_5_].value = "1000"
      end
    end
  end
gg.setValues(r)
  gg.clearResults()
  gg.toast("File Found ✓")
  print("I got you Lionel Richie!\n\nThe file is at: /sdcard/config.txt")
  gg.clearResults()
os.exit()
end
function socksliteP()
targetInfo = gg.getTargetInfo()
app = targetInfo.packageName
local utf8 = {}
local bit = {
  data32 = {}
}
do
  do
    for SRD1_5_ = 1, 32 do
      bit.data32[SRD1_5_] = 2 ^ (32 - SRD1_5_)
    end
  end
end
local toby = string.byte
function utf8.charbytes(s, i)
  i = i or 1
  local c = string.byte(s, i)
  if c > 0 and c <= 127 then
    do return 1 end
    return
  end
  if c >= 194 and c <= 223 then
    do return 2 end
    return
  end
  if c >= 224 and c <= 239 then
    do return 3 end
    return
  end
  if c >= 240 and c <= 244 then
    return 4
  end
  return 1
end

local ded
function bit:d2b(arg)
  if arg == nil then
    return
  end
  local tr, c = {}, arg < 0
  if c then
    arg = 0 - arg
  end
  do
    do
      for SRD1_7_ = 1, 32 do
        if arg >= self.data32[SRD1_7_] then
          tr[SRD1_7_] = 1
          arg = arg - self.data32[SRD1_7_]
        else
          tr[SRD1_7_] = 0
        end
      end
    end
  end
  if c then
    tr = self:_bnot(tr)
    tr = self:b2d(tr) + 1
    tr = self:d2b(tr)
  end
  return tr
end

function bit:b2d(arg, neg)
  local nr = 0
  if arg[1] == 1 and neg == true then
    arg = self:_bnot(arg)
    nr = self:b2d(arg) + 1
    nr = 0 - nr
  else
    do
      for SRD1_7_ = 1, 32 do
        if arg[SRD1_7_] == 1 then
          nr = nr + 2 ^ (32 - SRD1_7_)
        end
      end
    end
  end
  return nr
end

function bit:_and(a, b)
  local op1 = self:d2b(a)
  local op2 = self:d2b(b)
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == 1 and op2[SRD1_9_] == 1 then
          r[SRD1_9_] = 1
        else
          r[SRD1_9_] = 0
        end
      end
    end
  end
  return self:b2d(r, true)
end

function bit:_or(a, b)
  local op1 = self:d2b(a)
  local op2 = self:d2b(b)
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == 1 or op2[SRD1_9_] == 1 then
          r[SRD1_9_] = 1
        else
          r[SRD1_9_] = 0
        end
      end
    end
  end
  return self:b2d(r, true)
end

function bit:_xor(a, b)
  local op1 = self:d2b(a)
  if op1 == nil then
    return nil
  end
  local op2 = self:d2b(b)
  if op2 == nil then
    return nil
  end
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == op2[SRD1_9_] then
          r[SRD1_9_] = 0
        else
          r[SRD1_9_] = 1
        end
      end
    end
  end
  return self:b2d(r, true)
end

local switch = {
  [1] = function(s, pos)
    local c1 = toby(s, pos)
    return c1
  end
  ,
  [2] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local int1 = bit:_and(31, c1)
    local int2 = bit:_and(63, c2)
    return bit:_or(bit:_lshift(int1, 6), int2)
  end
  ,
  [3] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local c3 = toby(s, pos + 2)
    local int1 = bit:_and(15, c1)
    local int2 = bit:_and(63, c2)
    local int3 = bit:_and(63, c3)
    local o2 = bit:_or(bit:_lshift(int1, 12), bit:_lshift(int2, 6))
    local dt = bit:_or(o2, int3)
    return dt
  end
  ,
  [4] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local c3 = toby(s, pos + 2)
    local c4 = toby(s, pos + 3)
    local int1 = bit:_and(15, c1)
    local int2 = bit:_and(63, c2)
    local int3 = bit:_and(63, c3)
    local int4 = bit:_and(63, c4)
    local o2 = bit:_or(bit:_lshift(int1, 18), bit:_lshift(int2, 12))
    local o3 = bit:_or(o2, bit:_lshift(int3, 6))
    local o4 = bit:_or(o3, int4)
    return o4
  end
  
}
function bit:_bnot(op1)
  local r = {}
  do
    do
      for SRD1_6_ = 1, 32 do
        if op1[SRD1_6_] == 1 then
          r[SRD1_6_] = 0
        else
          r[SRD1_6_] = 1
        end
      end
    end
  end
  return r
end

function bit:_not(a)
  local op1 = self:d2b(a)
  local r = self:_bnot(op1)
  return self:b2d(r, true)
end

function bit:charCodeAt(s)
  local pos, int, H, L = 1, 0, 0, 0
  local slen = string.len(s)
  local allByte = {}
  while pos <= slen do
    local tLen = utf8.charbytes(s, pos)
    if tLen >= 1 and tLen <= 4 then
      if tLen == 4 then
        int = switch[4](s, pos)
        H = math.floor((int - 65536) / 1024) + 55296
        L = (int - 65536) % 1024 + 56320
        table.insert(allByte, H)
        table.insert(allByte, L)
      else
        int = switch[tLen](s, pos)
        table.insert(allByte, int)
      end
    end
    pos = pos + tLen
  end
  return allByte
end

function bit:_rshift(a, n)
  local r = 0
  if a < 0 then
    r = 0 - self:_frshift(0 - a, n)
  elseif a >= 0 then
    r = self:_frshift(a, n)
  end
  return r
end

function bit:_frshift(a, n)
  local op1 = self:d2b(a)
  local r = self:d2b(0)
  local left = 32 - n
  if n < 32 and n > 0 then
    do
      for SRD1_9_ = left, 1, -1 do
        r[SRD1_9_ + n] = op1[SRD1_9_]
      end
    end
  end
  return self:b2d(r)
end

function bit:_lshift(a, n)
  local op1 = self:d2b(a)
  local r = self:d2b(0)
  if n < 32 and n > 0 then
    do
      for SRD1_8_ = n, 31 do
        r[SRD1_8_ - n + 1] = op1[SRD1_8_ + 1]
      end
    end
  end
  return self:b2d(r, true)
end

function trim(s)
  return s:match("^%s*(.*)"):match("(.-)%s*$")
end

local json = {}
local kind_of = function(obj)
  if type(obj) ~= "table" then
    return type(obj)
  end
  local i = 1
  do
    do
      for SRD1_5_ in pairs(obj) do
        if obj[i] ~= nil then
          i = i + 1
        else
          return "table"
        end
      end
    end
  end
  if i == 1 then
    do return "table" end
    return
  end
  return "array"
end

local escape_str = function(s)
  local in_char = {
    "\\",
    "\"",
    "/",
    "\b",
    "\f",
    "\n",
    "\r",
    "\t"
  }
  local out_char = {
    "\\",
    "\"",
    "/",
    "b",
    "f",
    "n",
    "r",
    "t"
  }
  do
    do
      for SRD1_6_, SRD1_7_ in ipairs(in_char) do
        s = s:gsub(SRD1_7_, "\\" .. out_char[SRD1_6_])
      end
    end
  end
  return s
end

local skip_delim = function(str, pos, delim, err_if_missing)
  pos = pos + #str:match("^%s*", pos)
  if str:sub(pos, pos) ~= delim then
    if err_if_missing then
      error("Expected " .. delim .. " close position " .. pos)
    end
    return pos, false
  end
  return pos + 1, true
end

local function parse_str_val(str, pos, val)
  val = val or ""
  local early_end_error = "End of input encountered during string parsing."
  if pos > #str then
    error(early_end_error)
  end
  local c = str:sub(pos, pos)
  if c == "\"" then
    return val, pos + 1
  end
  if c ~= "\\" then
    return parse_str_val(str, pos + 1, val .. c)
  end
  local esc_map = {
    b = "\b",
    f = "\f",
    n = "\n",
    r = "\r",
    t = "\t"
  }
  local nextc = str:sub(pos + 1, pos + 1)
  if not nextc then
    error(early_end_error)
  end
  return parse_str_val(str, pos + 2, val .. (esc_map[nextc] or nextc))
end

local parse_num_val = function(str, pos)
  local num_str = str:match("^-?%d+%.?%d*[eE]?[+-]?%d*", pos)
  local val = tonumber(num_str)
  if not val then
    error("Error parsing number at position " .. pos .. ".")
  end
  return val, pos + #num_str
end

function json.stringify(obj, as_key)
  local s = {}
  local kind = kind_of(obj)
  if kind == "array" then
    if as_key then
      error("Unable to encode array as key.")
    end
    s[#s + 1] = "["
    do
      do
        for SRD1_7_, SRD1_8_ in ipairs(obj) do
          if SRD1_7_ > 1 then
            s[#s + 1] = ", "
          end
          s[#s + 1] = json.stringify(SRD1_8_)
        end
      end
    end
    s[#s + 1] = "]"
  elseif kind == "table" then
    if as_key then
      error("Unable to key encode table.")
    end
    s[#s + 1] = "{"
    do
      do
        for SRD1_7_, SRD1_8_ in pairs(obj) do
          if #s > 1 then
            s[#s + 1] = ", "
          end
          s[#s + 1] = json.stringify(SRD1_7_, true)
          s[#s + 1] = ":"
          s[#s + 1] = json.stringify(SRD1_8_)
        end
      end
    end
    s[#s + 1] = "}"
  else
    if kind == "string" then
      do return "\"" .. escape_str(obj) .. "\"" end
      return
    end
    if kind == "number" then
      if as_key then
        return "\"" .. tostring(obj) .. "\""
      end
      do return tostring(obj) end
      return
    end
    if kind == "boolean" then
      do return tostring(obj) end
      return
    end
    if kind == "nil" then
      do return "null" end
      return
    end
    error("unjsonifiable type,: " .. kind .. ".")
  end
  return table.concat(s)
end

json.null = {}
function json.parse(str, pos, end_delim)
  pos = pos or 1
  if pos > #str then
    error("Reached unexpected end of input ")
  end
  local pos = pos + #str:match("^%s*", pos)
  local first = str:sub(pos, pos)
  if first == "{" then
    do
      local obj, key, delim_found = {}, true, true
      pos = pos + 1
      while true do
        key, pos = json.parse(str, pos, "}")
        if key == nil then
          return obj, pos
        end
        if not delim_found then
          error("Missing comma between object items.")
        end
        pos = skip_delim(str, pos, ":", true)
        obj[key], pos = json.parse(str, pos)
        pos, delim_found = skip_delim(str, pos, ",")
      end
    end
    return
  end
  if first == "[" then
    do
      local arr, val, delim_found = {}, true, true
      pos = pos + 1
      while true do
        val, pos = json.parse(str, pos, "]")
        if val == nil then
          return arr, pos
        end
        if not delim_found then
          error("Missing comma between array items.")
        end
        arr[#arr + 1] = val
        pos, delim_found = skip_delim(str, pos, ",")
      end
    end
    return
  end
  if first == "\"" then
    do return parse_str_val(str, pos + 1) end
    return
  end
  if first == "-" or first:match("%d") then
    do return parse_num_val(str, pos) end
    return
  end
  if first == end_delim then
    do return nil, pos + 1 end
    return
  end
  do
    local literals = {
      ["true"] = true,
      ["false"] = false,
      null = json.null
    }
    do
      do
        for SRD1_9_, SRD1_10_ in pairs(literals) do
          local lit_end = pos + #SRD1_9_ - 1
          if str:sub(pos, lit_end) == SRD1_9_ then
            return SRD1_10_, lit_end + 1
          end
        end
      end
    end
    local pos_info_str = "position " .. pos .. ": " .. str:sub(pos, pos + 10)
    error("Invalid json syntax starting at " .. pos_info_str)
  end
end

function enc(data, b)
  return (data:gsub(".", function(x)
    local r, b = "", x:byte()
    do
      do
        for SRD1_6_ = 8, 1, -1 do
          r = r .. (b % 2 ^ SRD1_6_ - b % 2 ^ (SRD1_6_ - 1) > 0 and "1" or "0")
        end
      end
    end
    return r
  end
  ) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(x)
    if #x < 6 then
      return ""
    end
    local c = 0
    do
      do
        for SRD1_5_ = 1, 6 do
          c = c + (x:sub(SRD1_5_, SRD1_5_) == "1" and 2 ^ (6 - SRD1_5_) or 0)
        end
      end
    end
    return b:sub(c + 1, c + 1)
  end
  ) .. ({
    "",
    "??",
    "?"
  })[#data % 3 + 1]
end

function dec(data, b)
  data = string.gsub(data, "[^" .. b .. "=]", "")
  return (data:gsub(".", function(x)
    if x == "?" then
      return ""
    end
    local r, f = "", b:find(x) - 1
    do
      do
        for SRD1_6_ = 6, 1, -1 do
          r = r .. (f % 2 ^ SRD1_6_ - f % 2 ^ (SRD1_6_ - 1) > 0 and "1" or "0")
        end
      end
    end
    return r
  end
  ):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(x)
    if #x ~= 8 then
      return ""
    end
    local c = 0
    do
      do
        for SRD1_5_ = 1, 8 do
          c = c + (x:sub(SRD1_5_, SRD1_5_) == "1" and 2 ^ (8 - SRD1_5_) or 0)
        end
      end
    end
    return string.char(c)
  end
  ))
end
function rwmem(Address, SizeOrBuffer)
assert(Address ~= nil, "[rwmem]: error, given address is null.")
_rw = {}
if type(SizeOrBuffer) == "number" then
_ = ""
for _ = 1, SizeOrBuffer do _rw[_] = {address = (Address - 1) + _, flags = gg.TYPE_BYTE} end
for v, __ in ipairs(gg.getValues(_rw)) do
 if __.value == 00 and limit == true then
 return _
 end
_ = _ .. string.format("%02X", __.value & 0xFF)
end
return _
end
Byte = {} SizeOrBuffer:gsub("..", function(x)
Byte[#Byte + 1] = x _rw[#Byte] = {address = (Address - 1) + #Byte, flags = gg.TYPE_BYTE, value = x .. "h"}
end)
gg.setValues(_rw)
end
local function hexdecode(hex)
return (hex:gsub("%x%x", function(digits) return string.char(tonumber(digits, 16)) end))
end
local function hexencode(str)
return (str:gsub(".", function(char) return string.format("%2x", char:byte()) end))
end
function Dec2Hex(nValue)
nHexVal = string.format("%X", nValue);
sHexVal = nHexVal.."";
return sHexVal;
end
function ToInteger(number)
return math.floor(tonumber(number) or error("It was not possible transmitir '" .. tostring(number) .. "' enumerate.'"))
end

function save(data)
  io.open(gg.EXT_STORAGE .. "/decrypt.txt", "w"):write(data)
  gg.toast("I got you Lionel Richie!")
end

function save2(data)
  io.open(gg.EXT_STORAGE .. "/decrypt.txt", "w"):write(json.stringify(data))
  gg.toast("I got you Lionel Richie!")
end

function configjson(data)
  io.open(gg.EXT_STORAGE .. "/config.txt", "w"):write(data)
  gg.toast(data .. [[

𝙘𝙤𝙥𝙞𝙤𝙪, 𝙛𝙖𝙧𝙞𝙣𝙝𝙖?]])
  print(data, false)
  gg.clearResults()

end

  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("h 7B 09 22 56 65 72 73 69 6F 6E 22 3A 20 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("File Not Found ❌")
    json_2 = true
  end
  if json_2 then
  gg.searchNumber("h 7B 09 22 56 65 72 73 69", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌")
      print([[

calma barboleta]])
      print("\nsink or swim?\n\n")
      os.exit()
    end
  end
  limit = true
  gg.searchNumber("h7B", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1000)
  readedMem = rwmem(r[1].address, 200000)
  configjson(hexdecode(readedMem))
  do
    do
      for SRD1_5_, SRD1_6_ in ipairs(r) do
        r[SRD1_5_].flags = gg.TYPE_FLOAT
        r[SRD1_5_].value = "1000"
      end
    end
  end
gg.setValues(r)
  gg.clearResults()
  gg.toast("File Found ✓")
  print("I got you Lionel Richie!\n\nThe file is at: /sdcard/config.txt")
  gg.clearResults()
os.exit()
end
x9ok = 1
function x9on()
while (true) do
if gg.isVisible(true) then 
x9A= 1
gg.clearResults()
gg.setVisible(false) 
end

x9B = 1
function x9B()
menu = gg.choice({
" 💉  x9 HTTP Injector",
" 🇧🇷  x9 Of Applications",
" 🌐  x9 HTTP Custom",
" 🐝  x9 Payload",
" 🦋  x9 Username & Password SSH",
" 🐱  x9 V2ray",
" 👀  x9 Dump",
" ❌  Leave, I'm Afraid "},nil, (_G["os"]["date"]([[
Version 2.0 x9.lua
Today is %d/%m/%Y
Are %H:%M:%S

☠️  Raj, pick a card:]])))
 if menu == nil then x9P() end
 if menu == 1 then ehi() end
 if menu == 2 then x9C() end
 if menu == 3 then hc() end
 if menu == 4 then Payload() end
 if menu == 5 then login() end
 if menu == 6 then V2Ray() end
 if menu == 7 then Dump() end
 if menu == 8 then EXIT() end
 x9A = -1
end

function ehi()

limit = true
targetInfo = gg.getTargetInfo()
app = targetInfo.packageName
local utf8 = {}
local bit = {
  data32 = {}
}
do
  do
    for SRD1_5_ = 1, 32 do
      bit.data32[SRD1_5_] = 2 ^ (32 - SRD1_5_)
    end
  end
end
local toby = string.byte
function utf8.charbytes(s, i)
  i = i or 1
  local c = string.byte(s, i)
  if c > 0 and c <= 127 then
    do return 1 end
    return
  end
  if c >= 194 and c <= 223 then
    do return 2 end
    return
  end
  if c >= 224 and c <= 239 then
    do return 3 end
    return
  end
  if c >= 240 and c <= 244 then
    return 4
  end
  return 1
end

local ded
function bit:d2b(arg)
  if arg == nil then
    return
  end
  local tr, c = {}, arg < 0
  if c then
    arg = 0 - arg
  end
  do
    do
      for SRD1_7_ = 1, 32 do
        if arg >= self.data32[SRD1_7_] then
          tr[SRD1_7_] = 1
          arg = arg - self.data32[SRD1_7_]
        else
          tr[SRD1_7_] = 0
        end
      end
    end
  end
  if c then
    tr = self:_bnot(tr)
    tr = self:b2d(tr) + 1
    tr = self:d2b(tr)
  end
  return tr
end

function bit:b2d(arg, neg)
  local nr = 0
  if arg[1] == 1 and neg == true then
    arg = self:_bnot(arg)
    nr = self:b2d(arg) + 1
    nr = 0 - nr
  else
    do
      for SRD1_7_ = 1, 32 do
        if arg[SRD1_7_] == 1 then
          nr = nr + 2 ^ (32 - SRD1_7_)
        end
      end
    end
  end
  return nr
end

function bit:_and(a, b)
  local op1 = self:d2b(a)
  local op2 = self:d2b(b)
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == 1 and op2[SRD1_9_] == 1 then
          r[SRD1_9_] = 1
        else
          r[SRD1_9_] = 0
        end
      end
    end
  end
  return self:b2d(r, true)
end

function bit:_or(a, b)
  local op1 = self:d2b(a)
  local op2 = self:d2b(b)
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == 1 or op2[SRD1_9_] == 1 then
          r[SRD1_9_] = 1
        else
          r[SRD1_9_] = 0
        end
      end
    end
  end
  return self:b2d(r, true)
end

function bit:_xor(a, b)
  local op1 = self:d2b(a)
  if op1 == nil then
    return nil
  end
  local op2 = self:d2b(b)
  if op2 == nil then
    return nil
  end
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == op2[SRD1_9_] then
          r[SRD1_9_] = 0
        else
          r[SRD1_9_] = 1
        end
      end
    end
  end
  return self:b2d(r, true)
end

local switch = {
  [1] = function(s, pos)
    local c1 = toby(s, pos)
    return c1
  end
  ,
  [2] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local int1 = bit:_and(31, c1)
    local int2 = bit:_and(63, c2)
    return bit:_or(bit:_lshift(int1, 6), int2)
  end
  ,
  [3] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local c3 = toby(s, pos + 2)
    local int1 = bit:_and(15, c1)
    local int2 = bit:_and(63, c2)
    local int3 = bit:_and(63, c3)
    local o2 = bit:_or(bit:_lshift(int1, 12), bit:_lshift(int2, 6))
    local dt = bit:_or(o2, int3)
    return dt
  end
  ,
  [4] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local c3 = toby(s, pos + 2)
    local c4 = toby(s, pos + 3)
    local int1 = bit:_and(15, c1)
    local int2 = bit:_and(63, c2)
    local int3 = bit:_and(63, c3)
    local int4 = bit:_and(63, c4)
    local o2 = bit:_or(bit:_lshift(int1, 18), bit:_lshift(int2, 12))
    local o3 = bit:_or(o2, bit:_lshift(int3, 6))
    local o4 = bit:_or(o3, int4)
    return o4
  end
  
}
function bit:_bnot(op1)
  local r = {}
  do
    do
      for SRD1_6_ = 1, 32 do
        if op1[SRD1_6_] == 1 then
          r[SRD1_6_] = 0
        else
          r[SRD1_6_] = 1
        end
      end
    end
  end
  return r
end

function bit:_not(a)
  local op1 = self:d2b(a)
  local r = self:_bnot(op1)
  return self:b2d(r, true)
end

function bit:charCodeAt(s)
  local pos, int, H, L = 1, 0, 0, 0
  local slen = string.len(s)
  local allByte = {}
  while pos <= slen do
    local tLen = utf8.charbytes(s, pos)
    if tLen >= 1 and tLen <= 4 then
      if tLen == 4 then
        int = switch[4](s, pos)
        H = math.floor((int - 65536) / 1024) + 55296
        L = (int - 65536) % 1024 + 56320
        table.insert(allByte, H)
        table.insert(allByte, L)
      else
        int = switch[tLen](s, pos)
        table.insert(allByte, int)
      end
    end
    pos = pos + tLen
  end
  return allByte
end

function bit:_rshift(a, n)
  local r = 0
  if a < 0 then
    r = 0 - self:_frshift(0 - a, n)
  elseif a >= 0 then
    r = self:_frshift(a, n)
  end
  return r
end

function bit:_frshift(a, n)
  local op1 = self:d2b(a)
  local r = self:d2b(0)
  local left = 32 - n
  if n < 32 and n > 0 then
    do
      for SRD1_9_ = left, 1, -1 do
        r[SRD1_9_ + n] = op1[SRD1_9_]
      end
    end
  end
  return self:b2d(r)
end

function bit:_lshift(a, n)
  local op1 = self:d2b(a)
  local r = self:d2b(0)
  if n < 32 and n > 0 then
    do
      for SRD1_8_ = n, 31 do
        r[SRD1_8_ - n + 1] = op1[SRD1_8_ + 1]
      end
    end
  end
  return self:b2d(r, true)
end

function trim(s)
  return s:match("^%s*(.*)"):match("(.-)%s*$")
end

local json = {}
local kind_of = function(obj)
  if type(obj) ~= "table" then
    return type(obj)
  end
  local i = 1
  do
    do
      for SRD1_5_ in pairs(obj) do
        if obj[i] ~= nil then
          i = i + 1
        else
          return "table"
        end
      end
    end
  end
  if i == 1 then
    do return "table" end
    return
  end
  return "array"
end

local escape_str = function(s)
  local in_char = {
    "\\",
    "\"",
    "/",
    "\b",
    "\f",
    "\n",
    "\r",
    "\t"
  }
  local out_char = {
    "\\",
    "\"",
    "/",
    "b",
    "f",
    "n",
    "r",
    "t"
  }
  do
    do
      for SRD1_6_, SRD1_7_ in ipairs(in_char) do
        s = s:gsub(SRD1_7_, "\\" .. out_char[SRD1_6_])
      end
    end
  end
  return s
end

local skip_delim = function(str, pos, delim, err_if_missing)
  pos = pos + #str:match("^%s*", pos)
  if str:sub(pos, pos) ~= delim then
    if err_if_missing then
      error("Expected " .. delim .. " close position " .. pos)
    end
    return pos, false
  end
  return pos + 1, true
end

local function parse_str_val(str, pos, val)
  val = val or ""
  local early_end_error = "End of input encountered during string parsing."
  if pos > #str then
    error(early_end_error)
  end
  local c = str:sub(pos, pos)
  if c == "\"" then
    return val, pos + 1
  end
  if c ~= "\\" then
    return parse_str_val(str, pos + 1, val .. c)
  end
  local esc_map = {
    b = "\b",
    f = "\f",
    n = "\n",
    r = "\r",
    t = "\t"
  }
  local nextc = str:sub(pos + 1, pos + 1)
  if not nextc then
    error(early_end_error)
  end
  return parse_str_val(str, pos + 2, val .. (esc_map[nextc] or nextc))
end

local parse_num_val = function(str, pos)
  local num_str = str:match("^-?%d+%.?%d*[eE]?[+-]?%d*", pos)
  local val = tonumber(num_str)
  if not val then
    error("Error parsing number at position " .. pos .. ".")
  end
  return val, pos + #num_str
end

function json.stringify(obj, as_key)
  local s = {}
  local kind = kind_of(obj)
  if kind == "array" then
    if as_key then
      error("Unable to encode array as key.")
    end
    s[#s + 1] = "["
    do
      do
        for SRD1_7_, SRD1_8_ in ipairs(obj) do
          if SRD1_7_ > 1 then
            s[#s + 1] = ", "
          end
          s[#s + 1] = json.stringify(SRD1_8_)
        end
      end
    end
    s[#s + 1] = "]"
  elseif kind == "table" then
    if as_key then
      error("Unable to key encode table.")
    end
    s[#s + 1] = "{"
    do
      do
        for SRD1_7_, SRD1_8_ in pairs(obj) do
          if #s > 1 then
            s[#s + 1] = ", "
          end
          s[#s + 1] = json.stringify(SRD1_7_, true)
          s[#s + 1] = ":"
          s[#s + 1] = json.stringify(SRD1_8_)
        end
      end
    end
    s[#s + 1] = "}"
  else
    if kind == "string" then
      do return "\"" .. escape_str(obj) .. "\"" end
      return
    end
    if kind == "number" then
      if as_key then
        return "\"" .. tostring(obj) .. "\""
      end
      do return tostring(obj) end
      return
    end
    if kind == "boolean" then
      do return tostring(obj) end
      return
    end
    if kind == "nil" then
      do return "null" end
      return
    end
    error("unjsonifiable type,: " .. kind .. ".")
  end
  return table.concat(s)
end

json.null = {}
function json.parse(str, pos, end_delim)
  pos = pos or 1
  if pos > #str then
    error("Reached unexpected end of input ")
  end
  local pos = pos + #str:match("^%s*", pos)
  local first = str:sub(pos, pos)
  if first == "{" then
    do
      local obj, key, delim_found = {}, true, true
      pos = pos + 1
      while true do
        key, pos = json.parse(str, pos, "}")
        if key == nil then
          return obj, pos
        end
        if not delim_found then
          error("Missing comma between object items.")
        end
        pos = skip_delim(str, pos, ":", true)
        obj[key], pos = json.parse(str, pos)
        pos, delim_found = skip_delim(str, pos, ",")
      end
    end
    return
  end
  if first == "[" then
    do
      local arr, val, delim_found = {}, true, true
      pos = pos + 1
      while true do
        val, pos = json.parse(str, pos, "]")
        if val == nil then
          return arr, pos
        end
        if not delim_found then
          error("Missing comma between array items.")
        end
        arr[#arr + 1] = val
        pos, delim_found = skip_delim(str, pos, ",")
      end
    end
    return
  end
  if first == "\"" then
    do return parse_str_val(str, pos + 1) end
    return
  end
  if first == "-" or first:match("%d") then
    do return parse_num_val(str, pos) end
    return
  end
  if first == end_delim then
    do return nil, pos + 1 end
    return
  end
  do
    local literals = {
      ["true"] = true,
      ["false"] = false,
      null = json.null
    }
    do
      do
        for SRD1_9_, SRD1_10_ in pairs(literals) do
          local lit_end = pos + #SRD1_9_ - 1
          if str:sub(pos, lit_end) == SRD1_9_ then
            return SRD1_10_, lit_end + 1
          end
        end
      end
    end
    local pos_info_str = "position " .. pos .. ": " .. str:sub(pos, pos + 10)
    error("Invalid json syntax starting at " .. pos_info_str)
  end
end

function enc(data, b)
  return (data:gsub(".", function(x)
    local r, b = "", x:byte()
    do
      do
        for SRD1_6_ = 8, 1, -1 do
          r = r .. (b % 2 ^ SRD1_6_ - b % 2 ^ (SRD1_6_ - 1) > 0 and "1" or "0")
        end
      end
    end
    return r
  end
  ) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(x)
    if #x < 6 then
      return ""
    end
    local c = 0
    do
      do
        for SRD1_5_ = 1, 6 do
          c = c + (x:sub(SRD1_5_, SRD1_5_) == "1" and 2 ^ (6 - SRD1_5_) or 0)
        end
      end
    end
    return b:sub(c + 1, c + 1)
  end
  ) .. ({
    "",
    "??",
    "?"
  })[#data % 3 + 1]
end

function dec(data, b)
  data = string.gsub(data, "[^" .. b .. "=]", "")
  return (data:gsub(".", function(x)
    if x == "?" then
      return ""
    end
    local r, f = "", b:find(x) - 1
    do
      do
        for SRD1_6_ = 6, 1, -1 do
          r = r .. (f % 2 ^ SRD1_6_ - f % 2 ^ (SRD1_6_ - 1) > 0 and "1" or "0")
        end
      end
    end
    return r
  end
  ):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(x)
    if #x ~= 8 then
      return ""
    end
    local c = 0
    do
      do
        for SRD1_5_ = 1, 8 do
          c = c + (x:sub(SRD1_5_, SRD1_5_) == "1" and 2 ^ (8 - SRD1_5_) or 0)
        end
      end
    end
    return string.char(c)
  end
  ))
end

function ehix9(key, data)
  local preData, result
  preData = ""
  result = ""
  local bit_key = bit:charCodeAt(key)
  do
    local c = 0
    local c2 = 1
    while c < #data and not (c >= #data) do
      preData = preData .. string.char(tonumber(string.sub(data, c2, c + 2), 16))
      c = c + 2
      c2 = c2 + 2
    end
  end
  local bit_data = bit:charCodeAt(preData)
  do
    local a = 0
    local b = 0
    while a < #preData do
      if b >= #key then
        b = 0
      end
      a = a + 1
      b = b + 1
      local xor = bit:_xor(bit_data[a], bit_key[b])
      if xor ~= nil and xor < 256 then
        result = result .. string.char(bit:_xor(bit_data[a], bit_key[b]))
      end
    end
  end
  return result
end

function decryptEhi(salt, data)
  data = dec(string.reverse(data), "RkLC2QaVMPYgGJW/A4f7qzDb9e+t6Hr0Zp8OlNyjuxKcTw1o5EIimhBn3UvdSFXs?")
  return ehix9(salt, string.sub(data, 1, #data))
end

function decryptEhil(salt, data)
  data = dec(string.reverse(data), "t6uxKcTwhBn3UvRkLC2QaVM1o5A4f7Hr0Zp8OyjqzDb9e+dSFXsEIimPYgGJW/lN?")
  return ehix9(salt, string.sub(data, 1, #data))
end

function rwmem(Address, SizeOrBuffer)
  assert(Address ~= nil, "[rwmem]: error, given address is null.")
  _rw = {}
  if type(SizeOrBuffer) == "number" then
    _ = ""
    do
      do
        for SRD1_5_ = 1, SizeOrBuffer do
          _rw[SRD1_5_] = {
            address = Address - 1 + SRD1_5_,
            flags = gg.TYPE_BYTE
          }
        end
      end
    end
    do
      do
        for SRD1_5_, SRD1_6_ in ipairs(gg.getValues(_rw)) do
          if SRD1_6_.value == 0 and limit == true then
            return _
          end
          _ = _ .. string.format("%02X", SRD1_6_.value & 255)
        end
      end
    end
    return _
  end
  Byte = {}
  SizeOrBuffer:gsub("..", function(x)
    Byte[#Byte + 1] = x
    _rw[#Byte] = {
      address = Address - 1 + #Byte,
      flags = gg.TYPE_BYTE,
      value = x .. "h"
    }
  end
  )
  gg.setValues(_rw)
end

function hexdecode(hex)
  return (hex:gsub("%x%x", function(digits)
    return string.char(tonumber(digits, 16))
  end
  ))
end

function hexencode(str)
  return (str:gsub(".", function(char)
    return string.format("%2x", char:byte())
  end
  ))
end

function Dec2Hex(nValue)
  nHexVal = string.format("%X", nValue)
  sHexVal = nHexVal .. ""
  return sHexVal
end

function ToInteger(number)
  return math.floor(tonumber(number) or error("It was not possible transmitir '" .. tostring(number) .. "' enumerate.'"))
end

function save(data)
  io.open(gg.EXT_STORAGE .. "/decrypt.txt", "w"):write(data)
  gg.toast("I got you Lionel Richie!")
end

function save2(data)
  io.open(gg.EXT_STORAGE .. "/decrypt.txt", "w"):write(json.stringify(data))
  gg.toast("I got you Lionel Richie!")
end

function v2json(data)
  io.open(gg.EXT_STORAGE .. "/v2ray.txt", "w"):write(data)
end

function saveEhi(data)
  io.open(gg.EXT_STORAGE .. "/ehi.txt", "w"):write(data)
end

local ehi, configSalt
local Http = {}
function Http:New(data)
  ehi = data
  if data.configSalt == "" then
    configSalt = "EVZJNI"
  else
    configSalt = data.configSalt
  end
end

function Http:Dec(key)
  if ehi.configVersionCode > 10000 then
    if ehi[key] then
      do return decryptEhil(configSalt, ehi[key]) end
      return
    end
    do return "N/A" end
    return
  end
  if ehi[key] then
    do return decryptEhi(configSalt, ehi[key]) end
    return
  end
  return "N/A"
end

function Http:TunnelType()
  if ehi.tunnelType == "ssl_proxy_payload_ssh" then
    do return "𝙎𝙎𝙃 ➔ 𝙏𝙇𝙎/𝙎𝙎𝙇 + 𝙋𝙧𝙤𝙭𝙮 ➔ 𝘾𝙪𝙨𝙩𝙤𝙢 𝙋𝙖𝙮𝙡𝙤𝙖𝙙" end
    return
  end
  if ehi.tunnelType == "http_obfs_shadowsocks" then
    do return "𝙃𝙏𝙏𝙋 (𝙊𝙗𝙛𝙨) ➔ 𝙎𝙝𝙖𝙙𝙤𝙬𝙨𝙤𝙘𝙠𝙨" end
    return
  end
  if ehi.tunnelType == "ssl_ssh" then
    do return "𝙎𝙎𝙇/𝙏𝙇𝙎 ➔ 𝙎𝙎𝙃" end
    return
  end
  if ehi.tunnelType == "proxy_payload_ssh" then
    do return "𝙎𝙎𝙃 ➔ 𝙃𝙏𝙏𝙋 𝙋𝙧𝙤𝙭𝙮 ➔ 𝘾𝙪𝙨𝙩𝙤𝙢 𝙋𝙖𝙮𝙡𝙤𝙖𝙙" end
    return
  end
  if ehi.tunnelType == "proxy_ssh" then
    do return "𝙎𝙎𝙃 ➔ 𝙃𝙏𝙏𝙋 𝙋𝙧𝙤𝙭𝙮" end
    return
  end
  if ehi.tunnelType == "direct_ssh" then
    do return "𝙎𝙎𝙃 (𝘿𝙞𝙧𝙚𝙘𝙩)" end
    return
  end
  if ehi.tunnelType == "direct_shadowsocks" then
    do return "𝙎𝙝𝙖𝙙𝙤𝙬𝙨𝙤𝙘𝙠𝙨 (𝘿𝙞𝙧𝙚𝙘𝙩)" end
    return
  end
  if ehi.tunnelType == "dnstt_ssh" then
    do return "𝘿𝙉𝙎 ➔ 𝘿𝙉𝙎𝙏𝙏 ➔ 𝙎𝙎𝙃" end
    return
  end
  if ehi.tunnelType == "ssl_proxy_ssh" then
    do return "𝙃𝙏𝙏𝙋 𝙋𝙧𝙤𝙭𝙮 ➔ 𝙎𝙎𝙇 ➔ 𝙎𝙎𝙃" end
    return
  end
  if ehi.tunnelType == "ssl_shadowsocks" then
    do return "𝙎𝙎𝙇/𝙏𝙇𝙎 (𝙎𝙩𝙪𝙣𝙣𝙚𝙡) ➔ 𝙎𝙝𝙖𝙙𝙤𝙬𝙨𝙤𝙘𝙠𝙨" end
    return
  end
  if ehi.tunnelType == "tls_obfs_shadowsocks" then
    do return "𝙎𝙎𝙇/𝙏𝙇𝙎 (𝙊𝙗𝙛𝙨) ➔ 𝙎𝙝𝙖𝙙𝙤𝙬𝙨𝙤𝙘𝙠𝙨" end
    return
  end
  if ehi.tunnelType == "proxy_shadowsocks" then
    do return "𝙃𝙏𝙏𝙋 𝙋𝙧𝙤𝙭𝙮 ➔ 𝙎𝙝𝙖𝙙𝙤𝙬𝙨𝙤𝙘𝙠𝙨" end
    return
  end
  if ehi.tunnelType == "proxy_payload_shadowsocks" then
    do return "𝙃𝙏𝙏𝙋 𝙋𝙧𝙤𝙭𝙮 ➔ 𝙎𝙝𝙖𝙙𝙤𝙬𝙨𝙤𝙘𝙠𝙨 (𝘾𝙪𝙨𝙩𝙤𝙢 𝙋𝙖𝙮𝙡𝙤𝙖𝙙)" end
    return
  end
  if ehi.v2ray_all_settings == "v2ray_all_settings" then
    do return "𝙑2𝙍𝙖𝙮" end
    return
  end
  if ehi.tunnelType == "direct_dnsurgent" then
    do return "𝘿𝙞𝙧𝙚𝙘𝙩 𝘿𝙣𝙨𝙪𝙧𝙜𝙚𝙣𝙩" end
    return
  end
  if ehi.tunnelType == "sni_host_port" then
    do return "𝙎𝙎𝙇/𝙏𝙇𝙎" end
    return
  end
  if ehi.tunnelType == "direct_v2r_vmess" then
    do return "𝙑2𝙍𝙖𝙮" end
    return
  end
  if ehi.tunnelType == "v2rRawJson" then
    do return "𝙫2𝙟𝙨𝙤𝙣 ➔ 𝙑2𝙧𝙖𝙮" end
    return
  end
  if ehi.tunnelType == "lock_all" then
    do return "𝙡𝙤𝙘𝙠 ➔ 𝙑2𝙧𝙖𝙮" end
    return
  end
  if ehi.tunnelType == "unknown" then
    do return "𝙃𝙏𝙏𝙋 𝙋𝙧𝙤𝙭𝙮 ➔ 𝙎𝙎𝙃 (𝘾𝙪𝙨𝙩𝙤𝙢 𝙋𝙖𝙮𝙡𝙤𝙖𝙙)" end
    return
  end
  if ehi.tunnelType == "http_obfs" then
    do return "𝙎𝙝𝙖𝙙𝙤𝙬𝙨𝙤𝙘𝙠𝙨 ➔ 𝙃𝙏𝙏𝙋 𝙊𝙗𝙛𝙨" end
    return
  end
  if ehi.tunnelType == "direct_payload_ssh" then
    do return "𝙎𝙎𝙃 ➔ 𝘿𝙞𝙧𝙚𝙘𝙩 ➔ 𝘾𝙪𝙨𝙩𝙤𝙢 𝙋𝙖𝙮𝙡𝙤𝙖𝙙" end
    return
  end
  return ehi.tunnelType
end

local includes = function(tab, val)
  do
    do
      for SRD1_5_, SRD1_6_ in ipairs(tab) do
        if SRD1_6_ == val then
          return true
        end
      end
    end
  end
  return false
end

local ssh_mode = {
  "ssl_proxy_payload_ssh",
  "direct_payload_ssh",
  "proxy_payload_ssh",
  "proxy_ssh",
  "dnstt_ssh",
  "ssl_shadowsocks",
  "tls_obfs_shadowsocks",
  "proxy_shadowsocks",
  "proxy_payload_shadowsocks",
  "direct_dnsurgent",
  "direct_v2r_vmess",
  "unknown",
  "v2rRawJson",
  "v2ray_all_settings",
  "http_obfs_shadowsocks",
  "direct_shadowsocks",
  "ssl_proxy_ssh",
  "direct_ssh",
  "sni_host_port",
  "ssl_ssh",
  "lock_all",
  "http_obfs"
}
function parseHttpInjector(data)
  local jsonData = json.parse(hexdecode(data))
  gg.toast("it's show time")
  
  Http:New(jsonData)
  if includes(ssh_mode, ehi.tunnelType) then
    message = ""
    if ehi.overwriteServerData ~= "" then
      serverData = json.parse(ehi.overwriteServerData)
      message = message .. "➔) 𝙍𝙚𝙥𝙡𝙖𝙘𝙚 𝙨𝙚𝙧𝙫𝙚𝙧 𝙙𝙖𝙩𝙖: " .. ehi.overwriteServerData .. [[


]]
      message = message .. "➔) 𝙊𝙫𝙚𝙧𝙧𝙞𝙙𝙚 𝙨𝙚𝙧𝙫𝙚𝙧 𝙥𝙧𝙤𝙭𝙮 𝙥𝙤𝙧𝙩: " .. ehi.overwriteServerProxyPort .. [[


]]
      message = message .. "➔) 𝙊𝙫𝙚𝙧𝙬𝙧𝙞𝙩𝙚 𝙎𝙚𝙧𝙫𝙚𝙧 𝙏𝙮𝙥𝙚: " .. ehi.overwriteServerType .. [[


]]
      message = message .. "➔) 𝙚𝙫𝙤𝙯𝙞 𝙨𝙚𝙧𝙫𝙚𝙧: " .. serverData.name .. " (" .. serverData.ip .. [[
)

]]
elseif ehi.tunnelType == "direct_shadowsocks" then
      message = message .. "➔) 𝙃𝙏𝙏𝙋 𝙊𝙗𝙛𝙨 𝙎𝙚𝙩𝙩𝙞𝙣𝙜𝙨:: " .. Http:Dec("httpObfsSettings") .. [[


]]
      message = message .. "➔) 𝙎𝙝𝙖𝙙𝙤𝙬𝙨𝙤𝙘𝙠𝙨 𝙃𝙤𝙨𝙩: " .. Http:Dec("shadowsocksHost") .. "\n"
      message = message .. "➔) 𝙎𝙝𝙖𝙙𝙤𝙬𝙨𝙤𝙘𝙠𝙨 𝙋𝙤𝙧𝙩: " .. ehi.shadowsocksPort .. "\n"
      message = message .. "➔) 𝙎𝙝𝙖𝙙𝙤𝙬𝙨𝙤𝙘𝙠𝙨 𝙋𝙖𝙨𝙨𝙬𝙤𝙧𝙙: " .. Http:Dec("shadowsocksPassword") .. [[


]]
      message = message .. "➔) 𝙀𝙣𝙘𝙧𝙮𝙥𝙩𝙈𝙚𝙩𝙝𝙤𝙙: " .. string.upper(ehi.shadowsocksEncryptionMethod) .. [[


]]
      message = message .. "➔) 𝙑2𝙧𝙈𝙪𝙭𝘾𝙤𝙣𝙘𝙪𝙧𝙧𝙚𝙣𝙘𝙮: " .. Http:Dec("v2rMuxConcurrency") .. [[


]]
      message = message .. "🔥 𝙏𝙪𝙣𝙣𝙚𝙡 𝙏𝙮𝙥𝙚: " .. Http:TunnelType() .. [[


]]
elseif ehi.tunnelType == "tls_obfs_shadowsocks" then
      message = message .. "➔) 𝙃𝙏𝙏𝙋 𝙊𝙗𝙛𝙨 𝙎𝙚𝙩𝙩𝙞𝙣𝙜𝙨:: " .. Http:Dec("httpObfsSettings") .. [[


]]
message = message .. "➔) 𝙎𝙝𝙖𝙙𝙤𝙬𝙨𝙤𝙘𝙠𝙨 𝙃𝙤𝙨𝙩: " .. Http:Dec("shadowsocksHost") .. "\n"
      message = message .. "➔) 𝙎𝙝𝙖𝙙𝙤𝙬𝙨𝙤𝙘𝙠𝙨 𝙋𝙤𝙧𝙩: " .. ehi.shadowsocksPort .. "\n"
      message = message .. "➔) 𝙎𝙝𝙖𝙙𝙤𝙬𝙨𝙤𝙘𝙠𝙨 𝙋𝙖𝙨𝙨𝙬𝙤𝙧𝙙: " .. Http:Dec("shadowsocksPassword") .. [[


]]
      message = message .. "➔) 𝙀𝙣𝙘𝙧𝙮𝙥𝙩𝙈𝙚𝙩𝙝𝙤𝙙: " .. string.upper(ehi.shadowsocksEncryptionMethod) .. [[


]]
      message = message .. "➔) 𝙑2𝙧𝙈𝙪𝙭𝘾𝙤𝙣𝙘𝙪𝙧𝙧𝙚𝙣𝙘𝙮: " .. Http:Dec("v2rMuxConcurrency") .. [[


]]
      message = message .. "➔) 𝙎𝙉𝙄: " .. Http:Dec("sniHostname") .. [[


]]
      message = message .. "🔥 𝙏𝙪𝙣𝙣𝙚𝙡 𝙏𝙮𝙥𝙚: " .. Http:TunnelType() .. [[


]]
elseif ehi.tunnelType == "http_obfs_shadowsocks" then
      message = message .. "➔) 𝙃𝙏𝙏𝙋 𝙊𝙗𝙛𝙨 𝙎𝙚𝙩𝙩𝙞𝙣𝙜𝙨:: " .. Http:Dec("httpObfsSettings") .. [[


]]
      message = message .. "➔) 𝙎𝙝𝙖𝙙𝙤𝙬𝙨𝙤𝙘𝙠𝙨 𝙃𝙤𝙨𝙩: " .. Http:Dec("shadowsocksHost") .. "\n"
      message = message .. "➔) 𝙎𝙝𝙖𝙙𝙤𝙬𝙨𝙤𝙘𝙠𝙨 𝙋𝙤𝙧𝙩: " .. ehi.shadowsocksPort .. "\n"
      message = message .. "➔) 𝙎𝙝𝙖𝙙𝙤𝙬𝙨𝙤𝙘𝙠𝙨 𝙋𝙖𝙨𝙨𝙬𝙤𝙧𝙙: " .. Http:Dec("shadowsocksPassword") .. [[


]]
      message = message .. "➔) 𝙀𝙣𝙘𝙧𝙮𝙥𝙩𝙈𝙚𝙩𝙝𝙤𝙙: " .. string.upper(ehi.shadowsocksEncryptionMethod) .. [[


]]
      message = message .. "➔) 𝙑2𝙧𝙈𝙪𝙭𝘾𝙤𝙣𝙘𝙪𝙧𝙧𝙚𝙣𝙘𝙮: " .. Http:Dec("v2rMuxConcurrency") .. [[


]]
      message = message .. "🔥 𝙏𝙪𝙣𝙣𝙚𝙡 𝙏𝙮𝙥𝙚: " .. Http:TunnelType() .. [[


]]
    else
      message = message .. "➔) 𝙎𝙎𝙃 𝙃𝙤𝙨𝙩: " .. Http:Dec("host") .. "\n"
      message = message .. "➔) 𝙋𝙤𝙧𝙩: " .. ehi.port .. "\n"
      message = message .. "➔) 𝙐𝙨𝙚𝙧𝙣𝙖𝙢𝙚: " .. Http:Dec("user") .. "\n"
      message = message .. "➔) 𝙋𝙖𝙨𝙨𝙬𝙤𝙧𝙙: " .. Http:Dec("password") .. [[


]]
 end
    if ehi.remoteProxy then
      if ehi.remoteProxyUsername and ehi.remoteProxyUsername ~= "" then
        message = message .. "➔) 𝙋𝙧𝙤𝙭𝙮: " .. Http:Dec("remoteProxy") .. "\n"
        message = message .. "➔) 𝙐𝙨𝙚𝙧𝙣𝙖𝙢𝙚 𝙚 𝙋𝙖𝙨𝙨𝙬𝙤𝙧𝙙 𝙋𝙧𝙤𝙭𝙮 𝘼𝙪𝙩𝙝: " .. Http:Dec("remoteProxyUsername") .. ":" .. Http:Dec("remoteProxyPassword") .. [[


]]
      end
      elseif ehi.overwriteServerData ~= "" then
      if ehi.tunnelType == "proxy_payload_ssh" then
    message = message .. "➔) 𝙋𝙧𝙤𝙭𝙮: " .. Http:Dec("remoteProxy") .. [[


]]
end
      elseif ehi.overwriteServerData ~= "" then
      if ehi.tunnelType == "ssl_proxy_payload_ssh" then
    message = message .. "➔) 𝙋𝙧𝙤𝙭𝙮: " .. Http:Dec("remoteProxy") .. [[


]]
message = message .. "➔) 𝙎𝙉𝙄: " .. Http:Dec("sniHostname") .. [[


]]
end
      elseif ehi.overwriteServerData ~= "" then
      if ehi.tunnelType == "proxy_ssh" then
    message = message .. "➔) 𝙋𝙧𝙤𝙭𝙮: " .. Http:Dec("remoteProxy") .. [[


]]
      end
    elseif ehi.overwriteServerData ~= "" then
    if ehi.tunnelType == "ssl_ssh" then
      message = message .. "➔) 𝙎𝙉𝙄: " .. Http:Dec("sniHostname") .. [[


]]
end
    elseif ehi.overwriteServerData ~= "" then
    if ehi.tunnelType == "sni_host_port" then
      message = message .. "➔) 𝙎𝙉𝙄: " .. Http:Dec("sniHostname") .. [[


]]

    end
    elseif ehi.tunnelType == "ssl_shadowsocks" then
    message = message .. "➔) 𝙎𝙝𝙖𝙙𝙤𝙬𝙨𝙤𝙘𝙠𝙨 𝙃𝙤𝙨𝙩: " .. Http:Dec("shadowsocksHost") .. "\n"
      message = message .. "➔) 𝙎𝙝𝙖𝙙𝙤𝙬𝙨𝙤𝙘𝙠𝙨 𝙋𝙤𝙧𝙩: " .. ehi.shadowsocksPort .. "\n"
      message = message .. "➔) 𝙎𝙝𝙖𝙙𝙤𝙬𝙨𝙤𝙘𝙠𝙨 𝙋𝙖𝙨𝙨𝙬𝙤𝙧𝙙: " .. Http:Dec("shadowsocksPassword") .. [[


]]
      message = message .. "➔) 𝙀𝙣𝙘𝙧𝙮𝙥𝙩𝙈𝙚𝙩𝙝𝙤𝙙: " .. string.upper(ehi.shadowsocksEncryptionMethod) .. [[


]]
      message = message .. "➔) 𝙎𝙉𝙄: " .. Http:Dec("sniHostname") .. [[


]]
      message = message .. "🔥 𝙏𝙪𝙣𝙣𝙚𝙡 𝙏𝙮𝙥𝙚: " .. Http:TunnelType() .. [[


]]
    end
    if ehi.tunnelType == "direct_payload_ssh" then
      message = message .. "╰┈[☞] 𝙋𝙖𝙮𝙡𝙤𝙖𝙙: " .. Http:Dec("payload") .. [[


]]
      message = message .. "🔥 𝙏𝙪𝙣𝙣𝙚𝙡 𝙏𝙮𝙥𝙚: " .. Http:TunnelType() .. [[


]]
    end
    if ehi.tunnelType == "ssl_proxy_ssh" then
    message = message .. "➔) 𝙋𝙧𝙤𝙭𝙮: " .. Http:Dec("remoteProxy") .. [[


]]
message = message .. "➔) 𝙎𝙉𝙄: " .. Http:Dec("sniHostname") .. [[


]]
      message = message .. "🔥 𝙏𝙪𝙣𝙣𝙚𝙡 𝙏𝙮𝙥𝙚: " .. Http:TunnelType() .. [[


]]
    end
    if ehi.tunnelType == "sni_host_port" then
    message = message .. "➔) 𝙎𝙉𝙄: " .. Http:Dec("sniHostname") .. [[


]]
      message = message .. "🔥 𝙏𝙪𝙣𝙣𝙚𝙡 𝙏𝙮𝙥𝙚: " .. Http:TunnelType() .. [[


]]
    end
    if ehi.tunnelType == "ssl_proxy_payload_ssh" then
    message = message .. "➔) 𝙋𝙧𝙤𝙭𝙮: " .. Http:Dec("remoteProxy") .. [[


]]
message = message .. "➔) 𝙎𝙉𝙄: " .. Http:Dec("sniHostname") .. [[


]]
      message = message .. "╰┈[☞] 𝙋𝙖𝙮𝙡𝙤𝙖𝙙: " .. Http:Dec("payload") .. [[


]]
      message = message .. "🔥 𝙏𝙪𝙣𝙣𝙚𝙡 𝙏𝙮𝙥𝙚: " .. Http:TunnelType() .. [[


]]
    end
    if ehi.tunnelType == "proxy_payload_ssh" then
    message = message .. "➔) 𝙋𝙧𝙤𝙭𝙮: " .. Http:Dec("remoteProxy") .. [[


]]
      message = message .. "╰┈[☞] 𝙋𝙖𝙮𝙡𝙤𝙖𝙙: " .. Http:Dec("payload") .. [[


]]
      message = message .. "🔥 𝙏𝙪𝙣𝙣𝙚𝙡 𝙏𝙮𝙥𝙚: " .. Http:TunnelType() .. [[


]]
    end
    if ehi.tunnelType == "proxy_ssh" then
    message = message .. "➔) 𝙋𝙧𝙤𝙭𝙮: " .. Http:Dec("remoteProxy") .. [[


]]
      message = message .. "🔥 𝙏𝙪𝙣𝙣𝙚𝙡 𝙏𝙮𝙥𝙚: " .. Http:TunnelType() .. [[


]]
    end
    if ehi.tunnelType == "ssl_ssh" then
    message = message .. "➔) 𝙎𝙉𝙄: " .. Http:Dec("sniHostname") .. [[


]]
      message = message .. "🔥 𝙏𝙪𝙣𝙣𝙚𝙡 𝙏𝙮𝙥𝙚: " .. Http:TunnelType() .. [[


]]
    end
    if ehi.tunnelType == "direct_ssh" then
      message = message .. "🔥 𝙏𝙪𝙣𝙣𝙚𝙡 𝙏𝙮𝙥𝙚: " .. Http:TunnelType() .. [[


]]
    end
    if ehi.tunnelType == "direct_v2r_vmess" then
      message = "➔) 𝙫2𝙧𝙍𝙖𝙬𝙅𝙨𝙤𝙣: " .. Http:Dec("v2rRawJson") .. [[


]]
      if ehi.v2rRawJson then
        v2json = Http:Dec("v2rRawJson")
        saveEhi(v2json)
        gg.copyText(v2json, false)
        gg.toast("copied to clipboard")
        print(message)
        return
      end
      message = message .. "➔) 𝙐𝙨𝙚𝙧 𝘼𝙡𝙩𝙚𝙧 𝙄𝘿: " .. Http:Dec("v2rAlterId") .. "\n"
      message = message .. "➔) 𝙑2𝙍𝙖𝙮 𝙃𝙤𝙨𝙩: " .. Http:Dec("v2rHost") .. "\n"
      message = message .. "➔) 𝙫2𝙧𝙆𝙘𝙥𝙃𝙚𝙖𝙙𝙚𝙧𝙏𝙮𝙥𝙚: " .. Http:Dec("v2rKcpHeaderType") .. "\n"
      message = message .. "➔) 𝙑2𝙧𝙈𝙪𝙭𝘾𝙤𝙣𝙘𝙪𝙧𝙧𝙚𝙣𝙘𝙮: " .. Http:Dec("v2rMuxConcurrency") .. "\n"
      message = message .. "➔) 𝙫2𝙧𝙋𝙖𝙨𝙨𝙬𝙤𝙧𝙙: " .. Http:Dec("v2rPassword") .. "\n"
      message = message .. "➔) 𝙫2𝙧𝙉𝙚𝙩𝙬𝙤𝙧𝙠: " .. Http:Dec("v2rNetwork") .. "\n"
      message = message .. "➔) 𝙫2𝙧𝙋𝙤𝙧𝙩: " .. Http:Dec("v2rPort") .. "\n"
      message = message .. "➔) 𝙫2𝙧𝙋𝙧𝙤𝙩𝙤𝙘𝙤𝙡: " .. Http:Dec("v2rProtocol") .. "\n"
      message = message .. "➔) 𝙫2𝙧𝙃2𝙃𝙤𝙨𝙩: " .. Http:Dec("v2rH2Host") .. "\n"
      message = message .. "➔) 𝙫2𝙧𝙃2𝙋𝙖𝙩𝙝: " .. Http:Dec("v2rH2Path") .. "\n"
      message = message .. "➔) 𝙫2𝙧𝙌𝙪𝙞𝙘𝙃𝙚𝙖𝙙𝙚𝙧𝙏𝙮𝙥𝙚: " .. Http:Dec("v2rQuicHeaderType") .. "\n"
      message = message .. "➔) 𝙫2𝙧𝙏𝙘𝙥𝙃𝙚𝙖𝙙𝙚𝙧𝙏𝙮𝙥𝙚: " .. Http:Dec("v2rTcpHeaderType") .. "\n"
      message = message .. "➔) 𝙫2𝙧𝙐𝙨𝙚𝙧𝙄𝙙: " .. Http:Dec("v2rUserId") .. "\n"
      message = message .. "➔) 𝙫2𝙧𝙏𝙡𝙨𝙎𝙣𝙞: " .. Http:Dec("v2rTlsSni") .. "\n"
      message = message .. "➔) 𝙫2𝙧𝙑𝙡𝙚𝙨𝙨𝙎𝙚𝙘𝙪𝙧𝙞𝙩𝙮: " .. Http:Dec("v2rVlessSecurity") .. "\n"
      message = message .. "➔) 𝙫2𝙧𝙑𝙢𝙚𝙨𝙨𝙎𝙚𝙘𝙪𝙧𝙞𝙩𝙮: " .. Http:Dec("v2rVmessSecurity") .. "\n"
      message = message .. "➔) 𝙫2𝙧𝙎𝙨𝙎𝙚𝙘𝙪𝙧𝙞𝙩𝙮: " .. Http:Dec("v2rSsSecurity") .. "\n"
      message = message .. "➔) 𝙫2𝙧𝙌𝙪𝙞𝙘𝙎𝙚𝙘𝙪𝙧𝙞𝙩𝙮: " .. Http:Dec("v2rQuicSecurity") .. "\n"
      message = message .. "➔) 𝙃𝙚𝙖𝙙𝙚𝙧 𝙒𝙨: " .. Http:Dec("v2rWsHeader") .. "\n"
      message = message .. "➔) 𝙫2𝙧𝙒𝙨𝙋𝙖𝙩𝙝: " .. Http:Dec("v2rWsPath") .. [[


]]
      message = message .. "➔) 𝙫2𝙧𝘾𝙤𝙧𝙚𝙏𝙮𝙥𝙚: " .. Http:Dec("v2rCoreType") .. [[


]]
      message = message .. "🔥 𝙏𝙪𝙣𝙣𝙚𝙡 𝙏𝙮𝙥𝙚: " .. Http:TunnelType() .. [[


]]
    end
    if ehi.tunnelType == "dnstt_ssh" then
      message = message .. "➔) 𝘿𝙉𝙎 𝙩𝙮𝙥𝙚: " .. ehi.dnsType .. "\n"
      message = message .. "➔) 𝘿𝙉𝙎 𝙍𝙚𝙨𝙤𝙡𝙫𝙚𝙧 𝘼𝙙𝙙𝙧𝙚𝙨𝙨: " .. Http:Dec("dnsttDnsResolverAddr") .. "\n"
      message = message .. "➔) 𝘿𝙉𝙎𝙏𝙏 𝙉𝙖𝙢𝙚𝙨𝙚𝙧𝙫𝙚𝙧: " .. Http:Dec("dnsttNameserver") .. "\n"
      message = message .. "➔) 𝘿𝙉𝙎𝙏𝙏 𝙋𝙪𝙗𝙡𝙞𝙘 𝙆𝙚𝙮: " .. Http:Dec("dnsttPublicKey") .. [[


]]
      message = message .. "🔥 𝙏𝙪𝙣𝙣𝙚𝙡 𝙏𝙮𝙥𝙚: " .. Http:TunnelType() .. [[


]]

   end
    gg.copyText(message, false)
    gg.toast(message .. [[

𝙘𝙤𝙥𝙞𝙤𝙪, 𝙛𝙖𝙧𝙞𝙣𝙝𝙖?]])
    print(message)
    saveEhi(message)
  end
  os.exit()
end

function ehievozi()
  limit = true
  gg.clearResults()
  gg.setVisible(false)
  gg.setRanges(gg.REGION_C_ALLOC)
  gg.searchNumber("h 7B 22 63 6F 6E 66 69 67 45 78 70 69 72 79 54 69 6D 65 73 74", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("File Not Found ❌: configExpiryTimest")
    ehi_2 = true
  end
  gg.searchNumber("h 7B 22 63 6F 6E 66 69 67 45 78 70 69 72 79 54 69 6D 65 73 74", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
        gg.toast("File Not Found ❌")
        ehi_2 = true
    end
    
    if ehi_2 then
        gg.searchNumber("h 7B 22 56 32 72 54 6C 73 41 6C 70 6E 22 3A", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
        local r = gg.getResults(1)
        if #r < 1 then
        gg.toast("File Not Found ❌: V2rTlsAlpn")
      print([[

calma barboleta]])
        ehi_3 = true
        end
        end
  if ehi_3 then
    gg.searchNumber("h 7B 22 63 6F 6E 66 69 67 49 64 65 6E 74 69 66 69 65 72 22 3A", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: configIdentifier")
      print([[

calma barboleta]])
      print("\nimport the file again, wait 3 seconds and start the fun script\n\n")
      os.exit()
    end
  end
  gg.searchNumber("h7B", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1000)
  readedMem = rwmem(r[1].address, 50000)
  save(hexdecode(readedMem))
  do
    do
      for SRD1_5_, SRD1_6_ in ipairs(r) do
        r[SRD1_5_].flags = gg.TYPE_FLOAT
        r[SRD1_5_].value = "1000"
      end
    end
  end
  gg.setValues(r)
  gg.clearResults()
  parseHttpInjector(readedMem)
end
  
if app == "com.evozi.injector" then
  ehievozi()
elseif app == "com.evozi.injector.lite" then
  ehievozi()
else
  gg.toast("don't let me see")
  print("\ntoday is not your lucky day\n\n")
end
gg.clearResults()
x9B()
end

function x9C()

limit = false
targetInfo = gg.getTargetInfo()
app = targetInfo.packageName
local utf8 = {}
local bit = {
  data32 = {}
}
do
  do
    for SRD1_5_ = 1, 32 do
      bit.data32[SRD1_5_] = 2 ^ (32 - SRD1_5_)
    end
  end
end
local toby = string.byte
function utf8.charbytes(s, i)
  i = i or 1
  local c = string.byte(s, i)
  if c > 0 and c <= 127 then
    do return 1 end
    return
  end
  if c >= 194 and c <= 223 then
    do return 2 end
    return
  end
  if c >= 224 and c <= 239 then
    do return 3 end
    return
  end
  if c >= 240 and c <= 244 then
    return 4
  end
  return 1
end

local ded
function bit:d2b(arg)
  if arg == nil then
    return
  end
  local tr, c = {}, arg < 0
  if c then
    arg = 0 - arg
  end
  do
    do
      for SRD1_7_ = 1, 32 do
        if arg >= self.data32[SRD1_7_] then
          tr[SRD1_7_] = 1
          arg = arg - self.data32[SRD1_7_]
        else
          tr[SRD1_7_] = 0
        end
      end
    end
  end
  if c then
    tr = self:_bnot(tr)
    tr = self:b2d(tr) + 1
    tr = self:d2b(tr)
  end
  return tr
end

function bit:b2d(arg, neg)
  local nr = 0
  if arg[1] == 1 and neg == true then
    arg = self:_bnot(arg)
    nr = self:b2d(arg) + 1
    nr = 0 - nr
  else
    do
      for SRD1_7_ = 1, 32 do
        if arg[SRD1_7_] == 1 then
          nr = nr + 2 ^ (32 - SRD1_7_)
        end
      end
    end
  end
  return nr
end

function bit:_and(a, b)
  local op1 = self:d2b(a)
  local op2 = self:d2b(b)
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == 1 and op2[SRD1_9_] == 1 then
          r[SRD1_9_] = 1
        else
          r[SRD1_9_] = 0
        end
      end
    end
  end
  return self:b2d(r, true)
end

function bit:_or(a, b)
  local op1 = self:d2b(a)
  local op2 = self:d2b(b)
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == 1 or op2[SRD1_9_] == 1 then
          r[SRD1_9_] = 1
        else
          r[SRD1_9_] = 0
        end
      end
    end
  end
  return self:b2d(r, true)
end

function bit:_xor(a, b)
  local op1 = self:d2b(a)
  if op1 == nil then
    return nil
  end
  local op2 = self:d2b(b)
  if op2 == nil then
    return nil
  end
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == op2[SRD1_9_] then
          r[SRD1_9_] = 0
        else
          r[SRD1_9_] = 1
        end
      end
    end
  end
  return self:b2d(r, true)
end

local switch = {
  [1] = function(s, pos)
    local c1 = toby(s, pos)
    return c1
  end
  ,
  [2] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local int1 = bit:_and(31, c1)
    local int2 = bit:_and(63, c2)
    return bit:_or(bit:_lshift(int1, 6), int2)
  end
  ,
  [3] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local c3 = toby(s, pos + 2)
    local int1 = bit:_and(15, c1)
    local int2 = bit:_and(63, c2)
    local int3 = bit:_and(63, c3)
    local o2 = bit:_or(bit:_lshift(int1, 12), bit:_lshift(int2, 6))
    local dt = bit:_or(o2, int3)
    return dt
  end
  ,
  [4] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local c3 = toby(s, pos + 2)
    local c4 = toby(s, pos + 3)
    local int1 = bit:_and(15, c1)
    local int2 = bit:_and(63, c2)
    local int3 = bit:_and(63, c3)
    local int4 = bit:_and(63, c4)
    local o2 = bit:_or(bit:_lshift(int1, 18), bit:_lshift(int2, 12))
    local o3 = bit:_or(o2, bit:_lshift(int3, 6))
    local o4 = bit:_or(o3, int4)
    return o4
  end
  
}
function bit:_bnot(op1)
  local r = {}
  do
    do
      for SRD1_6_ = 1, 32 do
        if op1[SRD1_6_] == 1 then
          r[SRD1_6_] = 0
        else
          r[SRD1_6_] = 1
        end
      end
    end
  end
  return r
end

function bit:_not(a)
  local op1 = self:d2b(a)
  local r = self:_bnot(op1)
  return self:b2d(r, true)
end

function bit:charCodeAt(s)
  local pos, int, H, L = 1, 0, 0, 0
  local slen = string.len(s)
  local allByte = {}
  while pos <= slen do
    local tLen = utf8.charbytes(s, pos)
    if tLen >= 1 and tLen <= 4 then
      if tLen == 4 then
        int = switch[4](s, pos)
        H = math.floor((int - 65536) / 1024) + 55296
        L = (int - 65536) % 1024 + 56320
        table.insert(allByte, H)
        table.insert(allByte, L)
      else
        int = switch[tLen](s, pos)
        table.insert(allByte, int)
      end
    end
    pos = pos + tLen
  end
  return allByte
end

function bit:_rshift(a, n)
  local r = 0
  if a < 0 then
    r = 0 - self:_frshift(0 - a, n)
  elseif a >= 0 then
    r = self:_frshift(a, n)
  end
  return r
end

function bit:_frshift(a, n)
  local op1 = self:d2b(a)
  local r = self:d2b(0)
  local left = 32 - n
  if n < 32 and n > 0 then
    do
      for SRD1_9_ = left, 1, -1 do
        r[SRD1_9_ + n] = op1[SRD1_9_]
      end
    end
  end
  return self:b2d(r)
end

function bit:_lshift(a, n)
  local op1 = self:d2b(a)
  local r = self:d2b(0)
  if n < 32 and n > 0 then
    do
      for SRD1_8_ = n, 31 do
        r[SRD1_8_ - n + 1] = op1[SRD1_8_ + 1]
      end
    end
  end
  return self:b2d(r, true)
end

function trim(s)
  return s:match("^%s*(.*)"):match("(.-)%s*$")
end

local json = {}
local kind_of = function(obj)
  if type(obj) ~= "table" then
    return type(obj)
  end
  local i = 1
  do
    do
      for SRD1_5_ in pairs(obj) do
        if obj[i] ~= nil then
          i = i + 1
        else
          return "table"
        end
      end
    end
  end
  if i == 1 then
    do return "table" end
    return
  end
  return "array"
end

local escape_str = function(s)
  local in_char = {
    "\\",
    "\"",
    "/",
    "\b",
    "\f",
    "\n",
    "\r",
    "\t"
  }
  local out_char = {
    "\\",
    "\"",
    "/",
    "b",
    "f",
    "n",
    "r",
    "t"
  }
  do
    do
      for SRD1_6_, SRD1_7_ in ipairs(in_char) do
        s = s:gsub(SRD1_7_, "\\" .. out_char[SRD1_6_])
      end
    end
  end
  return s
end

local skip_delim = function(str, pos, delim, err_if_missing)
  pos = pos + #str:match("^%s*", pos)
  if str:sub(pos, pos) ~= delim then
    if err_if_missing then
      error("Expected " .. delim .. " close position " .. pos)
    end
    return pos, false
  end
  return pos + 1, true
end

local function parse_str_val(str, pos, val)
  val = val or ""
  local early_end_error = "End of input encountered during string parsing."
  if pos > #str then
    error(early_end_error)
  end
  local c = str:sub(pos, pos)
  if c == "\"" then
    return val, pos + 1
  end
  if c ~= "\\" then
    return parse_str_val(str, pos + 1, val .. c)
  end
  local esc_map = {
    b = "\b",
    f = "\f",
    n = "\n",
    r = "\r",
    t = "\t"
  }
  local nextc = str:sub(pos + 1, pos + 1)
  if not nextc then
    error(early_end_error)
  end
  return parse_str_val(str, pos + 2, val .. (esc_map[nextc] or nextc))
end

local parse_num_val = function(str, pos)
  local num_str = str:match("^-?%d+%.?%d*[eE]?[+-]?%d*", pos)
  local val = tonumber(num_str)
  if not val then
    error("Error parsing number at position " .. pos .. ".")
  end
  return val, pos + #num_str
end

function json.stringify(obj, as_key)
  local s = {}
  local kind = kind_of(obj)
  if kind == "array" then
    if as_key then
      error("Unable to encode array as key.")
    end
    s[#s + 1] = "["
    do
      do
        for SRD1_7_, SRD1_8_ in ipairs(obj) do
          if SRD1_7_ > 1 then
            s[#s + 1] = ", "
          end
          s[#s + 1] = json.stringify(SRD1_8_)
        end
      end
    end
    s[#s + 1] = "]"
  elseif kind == "table" then
    if as_key then
      error("Unable to key encode table.")
    end
    s[#s + 1] = "{"
    do
      do
        for SRD1_7_, SRD1_8_ in pairs(obj) do
          if #s > 1 then
            s[#s + 1] = ", "
          end
          s[#s + 1] = json.stringify(SRD1_7_, true)
          s[#s + 1] = ":"
          s[#s + 1] = json.stringify(SRD1_8_)
        end
      end
    end
    s[#s + 1] = "}"
  else
    if kind == "string" then
      do return "\"" .. escape_str(obj) .. "\"" end
      return
    end
    if kind == "number" then
      if as_key then
        return "\"" .. tostring(obj) .. "\""
      end
      do return tostring(obj) end
      return
    end
    if kind == "boolean" then
      do return tostring(obj) end
      return
    end
    if kind == "nil" then
      do return "null" end
      return
    end
    error("unjsonifiable type,: " .. kind .. ".")
  end
  return table.concat(s)
end

json.null = {}
function json.parse(str, pos, end_delim)
  pos = pos or 1
  if pos > #str then
    error("Reached unexpected end of input ")
  end
  local pos = pos + #str:match("^%s*", pos)
  local first = str:sub(pos, pos)
  if first == "{" then
    do
      local obj, key, delim_found = {}, true, true
      pos = pos + 1
      while true do
        key, pos = json.parse(str, pos, "}")
        if key == nil then
          return obj, pos
        end
        if not delim_found then
          error("Missing comma between object items.")
        end
        pos = skip_delim(str, pos, ":", true)
        obj[key], pos = json.parse(str, pos)
        pos, delim_found = skip_delim(str, pos, ",")
      end
    end
    return
  end
  if first == "[" then
    do
      local arr, val, delim_found = {}, true, true
      pos = pos + 1
      while true do
        val, pos = json.parse(str, pos, "]")
        if val == nil then
          return arr, pos
        end
        if not delim_found then
          error("Missing comma between array items.")
        end
        arr[#arr + 1] = val
        pos, delim_found = skip_delim(str, pos, ",")
      end
    end
    return
  end
  if first == "\"" then
    do return parse_str_val(str, pos + 1) end
    return
  end
  if first == "-" or first:match("%d") then
    do return parse_num_val(str, pos) end
    return
  end
  if first == end_delim then
    do return nil, pos + 1 end
    return
  end
  do
    local literals = {
      ["true"] = true,
      ["false"] = false,
      null = json.null
    }
    do
      do
        for SRD1_9_, SRD1_10_ in pairs(literals) do
          local lit_end = pos + #SRD1_9_ - 1
          if str:sub(pos, lit_end) == SRD1_9_ then
            return SRD1_10_, lit_end + 1
          end
        end
      end
    end
    local pos_info_str = "position " .. pos .. ": " .. str:sub(pos, pos + 10)
    error("Invalid json syntax starting at " .. pos_info_str)
  end
end

function enc(data, b)
  return (data:gsub(".", function(x)
    local r, b = "", x:byte()
    do
      do
        for SRD1_6_ = 8, 1, -1 do
          r = r .. (b % 2 ^ SRD1_6_ - b % 2 ^ (SRD1_6_ - 1) > 0 and "1" or "0")
        end
      end
    end
    return r
  end
  ) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(x)
    if #x < 6 then
      return ""
    end
    local c = 0
    do
      do
        for SRD1_5_ = 1, 6 do
          c = c + (x:sub(SRD1_5_, SRD1_5_) == "1" and 2 ^ (6 - SRD1_5_) or 0)
        end
      end
    end
    return b:sub(c + 1, c + 1)
  end
  ) .. ({
    "",
    "??",
    "?"
  })[#data % 3 + 1]
end

function dec(data, b)
  data = string.gsub(data, "[^" .. b .. "=]", "")
  return (data:gsub(".", function(x)
    if x == "?" then
      return ""
    end
    local r, f = "", b:find(x) - 1
    do
      do
        for SRD1_6_ = 6, 1, -1 do
          r = r .. (f % 2 ^ SRD1_6_ - f % 2 ^ (SRD1_6_ - 1) > 0 and "1" or "0")
        end
      end
    end
    return r
  end
  ):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(x)
    if #x ~= 8 then
      return ""
    end
    local c = 0
    do
      do
        for SRD1_5_ = 1, 8 do
          c = c + (x:sub(SRD1_5_, SRD1_5_) == "1" and 2 ^ (8 - SRD1_5_) or 0)
        end
      end
    end
    return string.char(c)
  end
  ))
end

function ehix9(key, data)
  local preData, result
  preData = ""
  result = ""
  local bit_key = bit:charCodeAt(key)
  do
    local c = 0
    local c2 = 1
    while c < #data and not (c >= #data) do
      preData = preData .. string.char(tonumber(string.sub(data, c2, c + 2), 16))
      c = c + 2
      c2 = c2 + 2
    end
  end
  local bit_data = bit:charCodeAt(preData)
  do
    local a = 0
    local b = 0
    while a < #preData do
      if b >= #key then
        b = 0
      end
      a = a + 1
      b = b + 1
      local xor = bit:_xor(bit_data[a], bit_key[b])
      if xor ~= nil and xor < 256 then
        result = result .. string.char(bit:_xor(bit_data[a], bit_key[b]))
      end
    end
  end
  return result
end

function decryptEhi(salt, data)
  data = dec(string.reverse(data), "RkLC2QaVMPYgGJW/A4f7qzDb9e+t6Hr0Zp8OlNyjuxKcTw1o5EIimhBn3UvdSFXs?")
  return ehix9(salt, string.sub(data, 1, #data))
end

function decryptEhil(salt, data)
  data = dec(string.reverse(data), "t6uxKcTwhBn3UvRkLC2QaVM1o5A4f7Hr0Zp8OyjqzDb9e+dSFXsEIimPYgGJW/lN?")
  return ehix9(salt, string.sub(data, 1, #data))
end

function rwmem(Address, SizeOrBuffer)
  assert(Address ~= nil, "[rwmem]: error, given address is null.")
  _rw = {}
  if type(SizeOrBuffer) == "number" then
    _ = ""
    do
      do
        for SRD1_5_ = 1, SizeOrBuffer do
          _rw[SRD1_5_] = {
            address = Address - 1 + SRD1_5_,
            flags = gg.TYPE_BYTE
          }
        end
      end
    end
    do
      do
        for SRD1_5_, SRD1_6_ in ipairs(gg.getValues(_rw)) do
          if SRD1_6_.value == 0 and limit == true then
            return _
          end
          _ = _ .. string.format("%02X", SRD1_6_.value & 255)
        end
      end
    end
    return _
  end
  Byte = {}
  SizeOrBuffer:gsub("..", function(x)
    Byte[#Byte + 1] = x
    _rw[#Byte] = {
      address = Address - 1 + #Byte,
      flags = gg.TYPE_BYTE,
      value = x .. "h"
    }
  end
  )
  gg.setValues(_rw)
end

function hexdecode(hex)
  return (hex:gsub("%x%x", function(digits)
    return string.char(tonumber(digits, 16))
  end
  ))
end

function hexencode(str)
  return (str:gsub(".", function(char)
    return string.format("%2x", char:byte())
  end
  ))
end

function Dec2Hex(nValue)
  nHexVal = string.format("%X", nValue)
  sHexVal = nHexVal .. ""
  return sHexVal
end

function ToInteger(number)
  return math.floor(tonumber(number) or error("It was not possible transmitir '" .. tostring(number) .. "' enumerate.'"))
end

function save(data)
  io.open(gg.EXT_STORAGE .. "/decrypt.txt", "w"):write(data)
  gg.toast("I got you Lionel Richie!")
end

function save2(data)
  io.open(gg.EXT_STORAGE .. "/decrypt.txt", "w"):write(json.stringify(data))
  gg.toast("I got you Lionel Richie!")
end

function hc(data)
  io.open(gg.EXT_STORAGE .. "/hc.txt", "w"):write(data)
  gg.toast("I got you Lionel Richie!")
end

function v2json(data)
  io.open(gg.EXT_STORAGE .. "/v2ray.txt", "w"):write(data)
end

function saveEhi(data)
  io.open(gg.EXT_STORAGE .. "/ehi.txt", "w"):write(data)
end

local ehi, configSalt
local Http = {}
function Http:New(data)
  ehi = data
  if data.configSalt == "" then
    configSalt = "EVZJNI"
  else
    configSalt = data.configSalt
  end
end

function Http:Dec(key)
  if ehi.configVersionCode > 10000 then
    if ehi[key] then
      do return decryptEhil(configSalt, ehi[key]) end
      return
    end
    do return "N/A" end
    return
  end
  if ehi[key] then
    do return decryptEhi(configSalt, ehi[key]) end
    return
  end
  return "N/A"
end

function Http:TunnelType()
  if ehi.tunnelType == "ssl_proxy_payload_ssh" then
    do return "𝙎𝙎𝙃 ➔ 𝙏𝙇𝙎/𝙎𝙎𝙇 + 𝙋𝙧𝙤𝙭𝙮 ➔ 𝘾𝙪𝙨𝙩𝙤𝙢 𝙋𝙖𝙮𝙡𝙤𝙖𝙙" end
    return
  end
  if ehi.tunnelType == "http_obfs_shadowsocks" then
    do return "𝙃𝙏𝙏𝙋 (𝙊𝙗𝙛𝙨) ➔ 𝙎𝙝𝙖𝙙𝙤𝙬𝙨𝙤𝙘𝙠𝙨" end
    return
  end
  if ehi.tunnelType == "ssl_ssh" then
    do return "𝙎𝙎𝙇/𝙏𝙇𝙎 ➔ 𝙎𝙎𝙃" end
    return
  end
  if ehi.tunnelType == "proxy_payload_ssh" then
    do return "𝙎𝙎𝙃 ➔ 𝙃𝙏𝙏𝙋 𝙋𝙧𝙤𝙭𝙮 ➔ 𝘾𝙪𝙨𝙩𝙤𝙢 𝙋𝙖𝙮𝙡𝙤𝙖𝙙" end
    return
  end
  if ehi.tunnelType == "proxy_ssh" then
    do return "𝙎𝙎𝙃 ➔ 𝙃𝙏𝙏𝙋 𝙋𝙧𝙤𝙭𝙮" end
    return
  end
  if ehi.tunnelType == "direct_ssh" then
    do return "𝙎𝙎𝙃 (𝘿𝙞𝙧𝙚𝙘𝙩)" end
    return
  end
  if ehi.tunnelType == "direct_shadowsocks" then
    do return "𝙎𝙝𝙖𝙙𝙤𝙬𝙨𝙤𝙘𝙠𝙨 (𝘿𝙞𝙧𝙚𝙘𝙩)" end
    return
  end
  if ehi.tunnelType == "dnstt_ssh" then
    do return "𝘿𝙉𝙎 ➔ 𝘿𝙉𝙎𝙏𝙏 ➔ 𝙎𝙎𝙃" end
    return
  end
  if ehi.tunnelType == "ssl_proxy_ssh" then
    do return "𝙃𝙏𝙏𝙋 𝙋𝙧𝙤𝙭𝙮 ➔ 𝙎𝙎𝙇 ➔ 𝙎𝙎𝙃" end
    return
  end
  if ehi.tunnelType == "ssl_shadowsocks" then
    do return "𝙎𝙎𝙇/𝙏𝙇𝙎 (𝙎𝙩𝙪𝙣𝙣𝙚𝙡) ➔ 𝙎𝙝𝙖𝙙𝙤𝙬𝙨𝙤𝙘𝙠𝙨" end
    return
  end
  if ehi.tunnelType == "tls_obfs_shadowsocks" then
    do return "𝙎𝙎𝙇/𝙏𝙇𝙎 (𝙊𝙗𝙛𝙨) ➔ 𝙎𝙝𝙖𝙙𝙤𝙬𝙨𝙤𝙘𝙠𝙨" end
    return
  end
  if ehi.tunnelType == "proxy_shadowsocks" then
    do return "𝙃𝙏𝙏𝙋 𝙋𝙧𝙤𝙭𝙮 ➔ 𝙎𝙝𝙖𝙙𝙤𝙬𝙨𝙤𝙘𝙠𝙨" end
    return
  end
  if ehi.tunnelType == "proxy_payload_shadowsocks" then
    do return "𝙃𝙏𝙏𝙋 𝙋𝙧𝙤𝙭𝙮 ➔ 𝙎𝙝𝙖𝙙𝙤𝙬𝙨𝙤𝙘𝙠𝙨 (𝘾𝙪𝙨𝙩𝙤𝙢 𝙋𝙖𝙮𝙡𝙤𝙖𝙙)" end
    return
  end
  if ehi.v2ray_all_settings == "v2ray_all_settings" then
    do return "𝙑2𝙍𝙖𝙮" end
    return
  end
  if ehi.tunnelType == "direct_dnsurgent" then
    do return "𝘿𝙞𝙧𝙚𝙘𝙩 𝘿𝙣𝙨𝙪𝙧𝙜𝙚𝙣𝙩" end
    return
  end
  if ehi.tunnelType == "sni_host_port" then
    do return "𝙎𝙎𝙇/𝙏𝙇𝙎" end
    return
  end
  if ehi.tunnelType == "direct_v2r_vmess" then
    do return "𝙑2𝙍𝙖𝙮" end
    return
  end
  if ehi.tunnelType == "v2rRawJson" then
    do return "𝙫2𝙟𝙨𝙤𝙣 ➔ 𝙑2𝙧𝙖𝙮" end
    return
  end
  if ehi.tunnelType == "lock_all" then
    do return "𝙡𝙤𝙘𝙠 ➔ 𝙑2𝙧𝙖𝙮" end
    return
  end
  if ehi.tunnelType == "unknown" then
    do return "𝙃𝙏𝙏𝙋 𝙋𝙧𝙤𝙭𝙮 ➔ 𝙎𝙎𝙃 (𝘾𝙪𝙨𝙩𝙤𝙢 𝙋𝙖𝙮𝙡𝙤𝙖𝙙)" end
    return
  end
  if ehi.tunnelType == "http_obfs" then
    do return "𝙎𝙝𝙖𝙙𝙤𝙬𝙨𝙤𝙘𝙠𝙨 ➔ 𝙃𝙏𝙏𝙋 𝙊𝙗𝙛𝙨" end
    return
  end
  if ehi.tunnelType == "direct_payload_ssh" then
    do return "𝙎𝙎𝙃 ➔ 𝘿𝙞𝙧𝙚𝙘𝙩 ➔ 𝘾𝙪𝙨𝙩𝙤𝙢 𝙋𝙖𝙮𝙡𝙤𝙖𝙙" end
    return
  end
  return ehi.tunnelType
end

local includes = function(tab, val)
  do
    do
      for SRD1_5_, SRD1_6_ in ipairs(tab) do
        if SRD1_6_ == val then
          return true
        end
      end
    end
  end
  return false
end

local ssh_mode = {
  "ssl_proxy_payload_ssh",
  "direct_payload_ssh",
  "proxy_payload_ssh",
  "proxy_ssh",
  "dnstt_ssh",
  "ssl_shadowsocks",
  "tls_obfs_shadowsocks",
  "proxy_shadowsocks",
  "proxy_payload_shadowsocks",
  "direct_dnsurgent",
  "direct_v2r_vmess",
  "unknown",
  "v2rRawJson",
  "v2ray_all_settings",
  "http_obfs_shadowsocks",
  "direct_shadowsocks",
  "ssl_proxy_ssh",
  "direct_ssh",
  "sni_host_port",
  "ssl_ssh",
  "lock_all",
  "http_obfs"
}
function parseHttpInjector(data)
  local jsonData = json.parse(hexdecode(data))
  gg.toast("it's show time")
  
  Http:New(jsonData)
  if includes(ssh_mode, ehi.tunnelType) then
    message = ""
    if ehi.overwriteServerData ~= "" then
      serverData = json.parse(ehi.overwriteServerData)
      message = message .. "➔) 𝙍𝙚𝙥𝙡𝙖𝙘𝙚 𝙨𝙚𝙧𝙫𝙚𝙧 𝙙𝙖𝙩𝙖: " .. ehi.overwriteServerData .. [[


]]
      message = message .. "➔) 𝙊𝙫𝙚𝙧𝙧𝙞𝙙𝙚 𝙨𝙚𝙧𝙫𝙚𝙧 𝙥𝙧𝙤𝙭𝙮 𝙥𝙤𝙧𝙩: " .. ehi.overwriteServerProxyPort .. [[


]]
      message = message .. "➔) 𝙊𝙫𝙚𝙧𝙬𝙧𝙞𝙩𝙚 𝙎𝙚𝙧𝙫𝙚𝙧 𝙏𝙮𝙥𝙚: " .. ehi.overwriteServerType .. [[


]]
      message = message .. "➔) 𝙚𝙫𝙤𝙯𝙞 𝙨𝙚𝙧𝙫𝙚𝙧: " .. serverData.name .. " (" .. serverData.ip .. [[
)

]]
elseif ehi.tunnelType == "direct_shadowsocks" then
      message = message .. "➔) 𝙃𝙏𝙏𝙋 𝙊𝙗𝙛𝙨 𝙎𝙚𝙩𝙩𝙞𝙣𝙜𝙨:: " .. Http:Dec("httpObfsSettings") .. [[


]]
      message = message .. "➔) 𝙎𝙝𝙖𝙙𝙤𝙬𝙨𝙤𝙘𝙠𝙨 𝙃𝙤𝙨𝙩: " .. Http:Dec("shadowsocksHost") .. "\n"
      message = message .. "➔) 𝙎𝙝𝙖𝙙𝙤𝙬𝙨𝙤𝙘𝙠𝙨 𝙋𝙤𝙧𝙩: " .. ehi.shadowsocksPort .. "\n"
      message = message .. "➔) 𝙎𝙝𝙖𝙙𝙤𝙬𝙨𝙤𝙘𝙠𝙨 𝙋𝙖𝙨𝙨𝙬𝙤𝙧𝙙: " .. Http:Dec("shadowsocksPassword") .. [[


]]
      message = message .. "➔) 𝙀𝙣𝙘𝙧𝙮𝙥𝙩𝙈𝙚𝙩𝙝𝙤𝙙: " .. string.upper(ehi.shadowsocksEncryptionMethod) .. [[


]]
      message = message .. "➔) 𝙑2𝙧𝙈𝙪𝙭𝘾𝙤𝙣𝙘𝙪𝙧𝙧𝙚𝙣𝙘𝙮: " .. Http:Dec("v2rMuxConcurrency") .. [[


]]
      message = message .. "🔥 𝙏𝙪𝙣𝙣𝙚𝙡 𝙏𝙮𝙥𝙚: " .. Http:TunnelType() .. [[


]]
elseif ehi.tunnelType == "tls_obfs_shadowsocks" then
      message = message .. "➔) 𝙃𝙏𝙏𝙋 𝙊𝙗𝙛𝙨 𝙎𝙚𝙩𝙩𝙞𝙣𝙜𝙨:: " .. Http:Dec("httpObfsSettings") .. [[


]]
message = message .. "➔) 𝙎𝙝𝙖𝙙𝙤𝙬𝙨𝙤𝙘𝙠𝙨 𝙃𝙤𝙨𝙩: " .. Http:Dec("shadowsocksHost") .. "\n"
      message = message .. "➔) 𝙎𝙝𝙖𝙙𝙤𝙬𝙨𝙤𝙘𝙠𝙨 𝙋𝙤𝙧𝙩: " .. ehi.shadowsocksPort .. "\n"
      message = message .. "➔) 𝙎𝙝𝙖𝙙𝙤𝙬𝙨𝙤𝙘𝙠𝙨 𝙋𝙖𝙨𝙨𝙬𝙤𝙧𝙙: " .. Http:Dec("shadowsocksPassword") .. [[


]]
      message = message .. "➔) 𝙀𝙣𝙘𝙧𝙮𝙥𝙩𝙈𝙚𝙩𝙝𝙤𝙙: " .. string.upper(ehi.shadowsocksEncryptionMethod) .. [[


]]
      message = message .. "➔) 𝙑2𝙧𝙈𝙪𝙭𝘾𝙤𝙣𝙘𝙪𝙧𝙧𝙚𝙣𝙘𝙮: " .. Http:Dec("v2rMuxConcurrency") .. [[


]]
      message = message .. "➔) 𝙎𝙉𝙄: " .. Http:Dec("sniHostname") .. [[


]]
      message = message .. "🔥 𝙏𝙪𝙣𝙣𝙚𝙡 𝙏𝙮𝙥𝙚: " .. Http:TunnelType() .. [[


]]
elseif ehi.tunnelType == "http_obfs_shadowsocks" then
      message = message .. "➔) 𝙃𝙏𝙏𝙋 𝙊𝙗𝙛𝙨 𝙎𝙚𝙩𝙩𝙞𝙣𝙜𝙨:: " .. Http:Dec("httpObfsSettings") .. [[


]]
      message = message .. "➔) 𝙎𝙝𝙖𝙙𝙤𝙬𝙨𝙤𝙘𝙠𝙨 𝙃𝙤𝙨𝙩: " .. Http:Dec("shadowsocksHost") .. "\n"
      message = message .. "➔) 𝙎𝙝𝙖𝙙𝙤𝙬𝙨𝙤𝙘𝙠𝙨 𝙋𝙤𝙧𝙩: " .. ehi.shadowsocksPort .. "\n"
      message = message .. "➔) 𝙎𝙝𝙖𝙙𝙤𝙬𝙨𝙤𝙘𝙠𝙨 𝙋𝙖𝙨𝙨𝙬𝙤𝙧𝙙: " .. Http:Dec("shadowsocksPassword") .. [[


]]
      message = message .. "➔) 𝙀𝙣𝙘𝙧𝙮𝙥𝙩𝙈𝙚𝙩𝙝𝙤𝙙: " .. string.upper(ehi.shadowsocksEncryptionMethod) .. [[


]]
      message = message .. "➔) 𝙑2𝙧𝙈𝙪𝙭𝘾𝙤𝙣𝙘𝙪𝙧𝙧𝙚𝙣𝙘𝙮: " .. Http:Dec("v2rMuxConcurrency") .. [[


]]
      message = message .. "🔥 𝙏𝙪𝙣𝙣𝙚𝙡 𝙏𝙮𝙥𝙚: " .. Http:TunnelType() .. [[


]]
    else
      message = message .. "➔) 𝙎𝙎𝙃 𝙃𝙤𝙨𝙩: " .. Http:Dec("host") .. "\n"
      message = message .. "➔) 𝙋𝙤𝙧𝙩: " .. ehi.port .. "\n"
      message = message .. "➔) 𝙐𝙨𝙚𝙧𝙣𝙖𝙢𝙚: " .. Http:Dec("user") .. "\n"
      message = message .. "➔) 𝙋𝙖𝙨𝙨𝙬𝙤𝙧𝙙: " .. Http:Dec("password") .. [[


]]
 end
    if ehi.remoteProxy then
      if ehi.remoteProxyUsername and ehi.remoteProxyUsername ~= "" then
        message = message .. "➔) 𝙋𝙧𝙤𝙭𝙮: " .. Http:Dec("remoteProxy") .. "\n"
        message = message .. "➔) 𝙐𝙨𝙚𝙧𝙣𝙖𝙢𝙚 𝙚 𝙋𝙖𝙨𝙨𝙬𝙤𝙧𝙙 𝙋𝙧𝙤𝙭𝙮 𝘼𝙪𝙩𝙝: " .. Http:Dec("remoteProxyUsername") .. ":" .. Http:Dec("remoteProxyPassword") .. [[


]]
      end
      elseif ehi.overwriteServerData ~= "" then
      if ehi.tunnelType == "proxy_payload_ssh" then
    message = message .. "➔) 𝙋𝙧𝙤𝙭𝙮: " .. Http:Dec("remoteProxy") .. [[


]]
end
      elseif ehi.overwriteServerData ~= "" then
      if ehi.tunnelType == "ssl_proxy_payload_ssh" then
    message = message .. "➔) 𝙋𝙧𝙤𝙭𝙮: " .. Http:Dec("remoteProxy") .. [[


]]
message = message .. "➔) 𝙎𝙉𝙄: " .. Http:Dec("sniHostname") .. [[


]]
end
      elseif ehi.overwriteServerData ~= "" then
      if ehi.tunnelType == "proxy_ssh" then
    message = message .. "➔) 𝙋𝙧𝙤𝙭𝙮: " .. Http:Dec("remoteProxy") .. [[


]]
      end
    elseif ehi.overwriteServerData ~= "" then
    if ehi.tunnelType == "ssl_ssh" then
      message = message .. "➔) 𝙎𝙉𝙄: " .. Http:Dec("sniHostname") .. [[


]]
end
    elseif ehi.overwriteServerData ~= "" then
    if ehi.tunnelType == "sni_host_port" then
      message = message .. "➔) 𝙎𝙉𝙄: " .. Http:Dec("sniHostname") .. [[


]]

    end
    elseif ehi.tunnelType == "ssl_shadowsocks" then
    message = message .. "➔) 𝙎𝙝𝙖𝙙𝙤𝙬𝙨𝙤𝙘𝙠𝙨 𝙃𝙤𝙨𝙩: " .. Http:Dec("shadowsocksHost") .. "\n"
      message = message .. "➔) 𝙎𝙝𝙖𝙙𝙤𝙬𝙨𝙤𝙘𝙠𝙨 𝙋𝙤𝙧𝙩: " .. ehi.shadowsocksPort .. "\n"
      message = message .. "➔) 𝙎𝙝𝙖𝙙𝙤𝙬𝙨𝙤𝙘𝙠𝙨 𝙋𝙖𝙨𝙨𝙬𝙤𝙧𝙙: " .. Http:Dec("shadowsocksPassword") .. [[


]]
      message = message .. "➔) 𝙀𝙣𝙘𝙧𝙮𝙥𝙩𝙈𝙚𝙩𝙝𝙤𝙙: " .. string.upper(ehi.shadowsocksEncryptionMethod) .. [[


]]
      message = message .. "➔) 𝙎𝙉𝙄: " .. Http:Dec("sniHostname") .. [[


]]
      message = message .. "🔥 𝙏𝙪𝙣𝙣𝙚𝙡 𝙏𝙮𝙥𝙚: " .. Http:TunnelType() .. [[


]]
    end
    if ehi.tunnelType == "direct_payload_ssh" then
      message = message .. "╰┈[☞] 𝙋𝙖𝙮𝙡𝙤𝙖𝙙: " .. Http:Dec("payload") .. [[


]]
      message = message .. "🔥 𝙏𝙪𝙣𝙣𝙚𝙡 𝙏𝙮𝙥𝙚: " .. Http:TunnelType() .. [[


]]
    end
    if ehi.tunnelType == "ssl_proxy_ssh" then
    message = message .. "➔) 𝙋𝙧𝙤𝙭𝙮: " .. Http:Dec("remoteProxy") .. [[


]]
message = message .. "➔) 𝙎𝙉𝙄: " .. Http:Dec("sniHostname") .. [[


]]
      message = message .. "🔥 𝙏𝙪𝙣𝙣𝙚𝙡 𝙏𝙮𝙥𝙚: " .. Http:TunnelType() .. [[


]]
    end
    if ehi.tunnelType == "sni_host_port" then
    message = message .. "➔) 𝙎𝙉𝙄: " .. Http:Dec("sniHostname") .. [[


]]
      message = message .. "🔥 𝙏𝙪𝙣𝙣𝙚𝙡 𝙏𝙮𝙥𝙚: " .. Http:TunnelType() .. [[


]]
    end
    if ehi.tunnelType == "ssl_proxy_payload_ssh" then
    message = message .. "➔) 𝙋𝙧𝙤𝙭𝙮: " .. Http:Dec("remoteProxy") .. [[


]]
message = message .. "➔) 𝙎𝙉𝙄: " .. Http:Dec("sniHostname") .. [[


]]
      message = message .. "╰┈[☞] 𝙋𝙖𝙮𝙡𝙤𝙖𝙙: " .. Http:Dec("payload") .. [[


]]
      message = message .. "🔥 𝙏𝙪𝙣𝙣𝙚𝙡 𝙏𝙮𝙥𝙚: " .. Http:TunnelType() .. [[


]]
    end
    if ehi.tunnelType == "proxy_payload_ssh" then
    message = message .. "➔) 𝙋𝙧𝙤𝙭𝙮: " .. Http:Dec("remoteProxy") .. [[


]]
      message = message .. "╰┈[☞] 𝙋𝙖𝙮𝙡𝙤𝙖𝙙: " .. Http:Dec("payload") .. [[


]]
      message = message .. "🔥 𝙏𝙪𝙣𝙣𝙚𝙡 𝙏𝙮𝙥𝙚: " .. Http:TunnelType() .. [[


]]
    end
    if ehi.tunnelType == "proxy_ssh" then
    message = message .. "➔) 𝙋𝙧𝙤𝙭𝙮: " .. Http:Dec("remoteProxy") .. [[


]]
      message = message .. "🔥 𝙏𝙪𝙣𝙣𝙚𝙡 𝙏𝙮𝙥𝙚: " .. Http:TunnelType() .. [[


]]
    end
    if ehi.tunnelType == "ssl_ssh" then
    message = message .. "➔) 𝙎𝙉𝙄: " .. Http:Dec("sniHostname") .. [[


]]
      message = message .. "🔥 𝙏𝙪𝙣𝙣𝙚𝙡 𝙏𝙮𝙥𝙚: " .. Http:TunnelType() .. [[


]]
    end
    if ehi.tunnelType == "direct_ssh" then
      message = message .. "🔥 𝙏𝙪𝙣𝙣𝙚𝙡 𝙏𝙮𝙥𝙚: " .. Http:TunnelType() .. [[


]]
    end
    if ehi.tunnelType == "direct_v2r_vmess" then
      message = "➔) 𝙫2𝙧𝙍𝙖𝙬𝙅𝙨𝙤𝙣: " .. Http:Dec("v2rRawJson") .. [[


]]
      if ehi.v2rRawJson then
        v2json = Http:Dec("v2rRawJson")
        saveEhi(v2json)
        gg.copyText(v2json, false)
        gg.toast("copied to clipboard")
        print(message)
        return
      end
      message = message .. "➔) 𝙐𝙨𝙚𝙧 𝘼𝙡𝙩𝙚𝙧 𝙄𝘿: " .. Http:Dec("v2rAlterId") .. "\n"
      message = message .. "➔) 𝙑2𝙍𝙖𝙮 𝙃𝙤𝙨𝙩: " .. Http:Dec("v2rHost") .. "\n"
      message = message .. "➔) 𝙫2𝙧𝙆𝙘𝙥𝙃𝙚𝙖𝙙𝙚𝙧𝙏𝙮𝙥𝙚: " .. Http:Dec("v2rKcpHeaderType") .. "\n"
      message = message .. "➔) 𝙑2𝙧𝙈𝙪𝙭𝘾𝙤𝙣𝙘𝙪𝙧𝙧𝙚𝙣𝙘𝙮: " .. Http:Dec("v2rMuxConcurrency") .. "\n"
      message = message .. "➔) 𝙫2𝙧𝙋𝙖𝙨𝙨𝙬𝙤𝙧𝙙: " .. Http:Dec("v2rPassword") .. "\n"
      message = message .. "➔) 𝙫2𝙧𝙉𝙚𝙩𝙬𝙤𝙧𝙠: " .. Http:Dec("v2rNetwork") .. "\n"
      message = message .. "➔) 𝙫2𝙧𝙋𝙤𝙧𝙩: " .. Http:Dec("v2rPort") .. "\n"
      message = message .. "➔) 𝙫2𝙧𝙋𝙧𝙤𝙩𝙤𝙘𝙤𝙡: " .. Http:Dec("v2rProtocol") .. "\n"
      message = message .. "➔) 𝙫2𝙧𝙃2𝙃𝙤𝙨𝙩: " .. Http:Dec("v2rH2Host") .. "\n"
      message = message .. "➔) 𝙫2𝙧𝙃2𝙋𝙖𝙩𝙝: " .. Http:Dec("v2rH2Path") .. "\n"
      message = message .. "➔) 𝙫2𝙧𝙌𝙪𝙞𝙘𝙃𝙚𝙖𝙙𝙚𝙧𝙏𝙮𝙥𝙚: " .. Http:Dec("v2rQuicHeaderType") .. "\n"
      message = message .. "➔) 𝙫2𝙧𝙏𝙘𝙥𝙃𝙚𝙖𝙙𝙚𝙧𝙏𝙮𝙥𝙚: " .. Http:Dec("v2rTcpHeaderType") .. "\n"
      message = message .. "➔) 𝙫2𝙧𝙐𝙨𝙚𝙧𝙄𝙙: " .. Http:Dec("v2rUserId") .. "\n"
      message = message .. "➔) 𝙫2𝙧𝙏𝙡𝙨𝙎𝙣𝙞: " .. Http:Dec("v2rTlsSni") .. "\n"
      message = message .. "➔) 𝙫2𝙧𝙑𝙡𝙚𝙨𝙨𝙎𝙚𝙘𝙪𝙧𝙞𝙩𝙮: " .. Http:Dec("v2rVlessSecurity") .. "\n"
      message = message .. "➔) 𝙫2𝙧𝙑𝙢𝙚𝙨𝙨𝙎𝙚𝙘𝙪𝙧𝙞𝙩𝙮: " .. Http:Dec("v2rVmessSecurity") .. "\n"
      message = message .. "➔) 𝙫2𝙧𝙎𝙨𝙎𝙚𝙘𝙪𝙧𝙞𝙩𝙮: " .. Http:Dec("v2rSsSecurity") .. "\n"
      message = message .. "➔) 𝙫2𝙧𝙌𝙪𝙞𝙘𝙎𝙚𝙘𝙪𝙧𝙞𝙩𝙮: " .. Http:Dec("v2rQuicSecurity") .. "\n"
      message = message .. "➔) 𝙃𝙚𝙖𝙙𝙚𝙧 𝙒𝙨: " .. Http:Dec("v2rWsHeader") .. "\n"
      message = message .. "➔) 𝙫2𝙧𝙒𝙨𝙋𝙖𝙩𝙝: " .. Http:Dec("v2rWsPath") .. [[


]]
      message = message .. "➔) 𝙫2𝙧𝘾𝙤𝙧𝙚𝙏𝙮𝙥𝙚: " .. Http:Dec("v2rCoreType") .. [[


]]
      message = message .. "🔥 𝙏𝙪𝙣𝙣𝙚𝙡 𝙏𝙮𝙥𝙚: " .. Http:TunnelType() .. [[


]]
    end
    if ehi.tunnelType == "dnstt_ssh" then
      message = message .. "➔) 𝘿𝙉𝙎 𝙩𝙮𝙥𝙚: " .. ehi.dnsType .. "\n"
      message = message .. "➔) 𝘿𝙉𝙎 𝙍𝙚𝙨𝙤𝙡𝙫𝙚𝙧 𝘼𝙙𝙙𝙧𝙚𝙨𝙨: " .. Http:Dec("dnsttDnsResolverAddr") .. "\n"
      message = message .. "➔) 𝘿𝙉𝙎𝙏𝙏 𝙉𝙖𝙢𝙚𝙨𝙚𝙧𝙫𝙚𝙧: " .. Http:Dec("dnsttNameserver") .. "\n"
      message = message .. "➔) 𝘿𝙉𝙎𝙏𝙏 𝙋𝙪𝙗𝙡𝙞𝙘 𝙆𝙚𝙮: " .. Http:Dec("dnsttPublicKey") .. [[


]]
      message = message .. "🔥 𝙏𝙪𝙣𝙣𝙚𝙡 𝙏𝙮𝙥𝙚: " .. Http:TunnelType() .. [[


]]

   end
    gg.copyText(message, false)
    gg.toast(message .. [[

𝙘𝙤𝙥𝙞𝙤𝙪, 𝙛𝙖𝙧𝙞𝙣𝙝𝙖?]])
    print(message)
    saveEhi(message)
  end
  os.exit()
end

function HttpInjector()
  limit = true
  gg.clearResults()
  gg.setVisible(false)
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC)
  gg.searchNumber("h 7B 22 63 6F 6E 66 69 67 45 78 70 69 72 79 54 69 6D 65 73 74", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("File Not Found ❌: configExpiryTimest")
    ehi_2 = true
  end
  if ehi_2 then
        gg.searchNumber("h 7B 22 56 32 72 54 6C 73 41 6C 70 6E 22 3A", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
        local r = gg.getResults(1)
        if #r < 1 then
        gg.toast("File Not Found ❌: V2rTlsAlpn")
      print([[

calma barboleta]])
        ehi_3 = true
        end
        end
  if ehi_3 then
    gg.searchNumber("h 7B 22 63 6F 6E 66 69 67 49 64 65 6E 74 69 66 69 65 72 22 3A", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: configIdentifier")
      print([[

calma barboleta]])
      print("\nimport the file again, wait 3 seconds and start the fun script\n\n")
      os.exit()
    end
  end
  gg.searchNumber("h7B", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1000)
  readedMem = rwmem(r[1].address, 50000)
  save(hexdecode(readedMem))
  do
    do
      for SRD1_5_, SRD1_6_ in ipairs(r) do
        r[SRD1_5_].flags = gg.TYPE_FLOAT
        r[SRD1_5_].value = "1000"
      end
    end
  end
  gg.setValues(r)
  gg.clearResults()
  parseHttpInjector(readedMem)
end

function HTTPCustom()
  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("::443@", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("File Not Found ❌: 443")
    hc_2 = true
  end
  if hc_2 then
    gg.searchNumber("h 3A 38 30 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: 80")
      hc_3 = true
    end
  end
  if hc_3 then
    gg.searchNumber("h 3A 38 30 38 30 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: 8080")
      hc_4 = true
    end
  end
  if hc_4 then
    gg.searchNumber("h 3a 32 32 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: 22")
      hc_5 = true
    end
  end
  if hc_5 then
    limit = false
    gg.searchNumber("h 3a 32 32 32 32 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: 2222")
      hc_6 = true
    end
  end
  if hc_6 then
    limit = false
    gg.searchNumber("h 3a 34 34 34 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: 444")
      hc_7 = true
    end
  end
  if hc_7 then
    limit = false
    gg.searchNumber("h 3A 35 33 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: 53")
      hc_8 = true
    end
  end
  if hc_8 then
    limit = false
    gg.searchNumber("h 55 70 67 72 61 64 65 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: Upgrade")
      hc_9 = true
    end
  end
  if hc_9 then
    limit = false
    gg.searchNumber("h 5B 73 70 6C 69 74 50 73 69 70 68 6F 6E 5D 5B 73 70 6C 69 74 50 73 69 70 68 6F 6E 5D", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: splitPsiphon splitPsiphon")
      hc_10 = true
    end
  end
  if hc_10 then
    limit = false
    gg.searchNumber("h 23 20 43 6F 6E 66 69 67 20 66 6F 72 20 4F 70 65 6E 56 50 4E 20 32 2E 78", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: config for OpenVPN 2x")
      hc_11 = true
    end
  end
  if hc_11 then
    limit = false
    gg.searchNumber("h 5B 00 73 00 70 00 6C 00 69 00 74 00 43 00 6F 00 6E 00 66 00 69 00 67 00 5D", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: splitConfig")
      hc_12 = true
    end
  end
  if hc_12 then
    limit = false
    gg.searchNumber("h 22 69 73 4c 6f 67 69 6e 48 77 69 64 22 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: isLoginHwid")
      hc_13 = true
    end
  end
  if hc_13 then
    limit = false
    gg.searchNumber("h 20 22 64 6e 73 22 3a 20 7b", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: dns")
      hc_14 = true
    end
  end
  if hc_14 then
    limit = false
    gg.searchNumber("h 5b 63 72 6c 66 5d 48 6f 73 74 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: crlf Host")
      hc_15 = true
    end
  end
  if hc_15 then
    limit = false
    gg.searchNumber("h 7B 0A 09 09 22 69 6E 62 6F 75 6E 64", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: inbound")
      hc_16 = true
    end
  end
  if hc_16 then
    limit = false
    gg.searchNumber("h 75 70 67 72 61 64 65 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: upgrade")
      hc_17 = true
    end
  end
  if hc_17 then
    limit = false
    gg.searchNumber("h 41 43 4c 20 2f 20 48 54 54 50 2f", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: ACL HTTP")
      hc_18 = true
    end
  end
  if hc_18 then
    limit = false
    gg.searchNumber("h 43 4f 4e 4e 45 43 54 20 5b", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: CONNECT")
      hc_19 = true
    end
  end
  if hc_19 then
    limit = false
    gg.searchNumber("h 48 6f 73 74 3a 5b 72 6f 74 61 74 65 3d", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: rotate")
      hc_20 = true
    end
  end
  if hc_20 then
    gg.toast("File Not Found ❌")
    print("edit your search, use new keywords or reload the application and configuration again\n")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == false then
    r[1].address = r[1].address - 8192
  end
  readedMem = rwmem(r[1].address, 68000)
  save(hexdecode(readedMem))
  gg.toast("File Found ✓")
  print("I got you Lionel Richie!\n\nThe file is at: /sdcard/decrypt.txt")
  gg.clearResults()
end

function hc_ssc()
  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("h 7B 22 61 62 22 3A", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("File Not Found ❌: ab")
    ssc_2 = true
  end
  if ssc_2 then
    gg.searchNumber("h 55 70 67 72 61 64 65 3A", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: Upgrade")
      ssc_3 = true
    end
  end
  if ssc_3 then
    gg.searchNumber("h 3A 38 30 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: 80")
      ssc_4 = true
    end
  end
  if ssc_4 then
    gg.searchNumber("h 7B 0A 09 09 22 69 6E 62 6F 75 6E 64", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: inbound")
      ssc_5 = true
    end
  end
  if ssc_5 then
    gg.searchNumber("h 7B 0A 20 20 22 64 6E 73 22 3A 20 7B 0A 20 20 20 20 22 68 6F 73 74 73 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: dns hosts")
      ssc_6 = true
    end
  end
  if ssc_6 then
    gg.searchNumber("::443@", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: 443")
      ssc_7 = true
    end
  end
  if ssc_7 then
    gg.searchNumber(":[crlf][crlf]", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: crlf")
      ssc_8 = true
    end
  end
  if ssc_8 then
    gg.searchNumber("h 48 6f 73 74 3a 5b 72 6f 74 61 74 65 3d", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: rotate")
      ssc_9 = true
    end
  end
  if ssc_9 then
    gg.toast("File Not Found ❌")
    print("edit your search, use new keywords or reload the application and configuration again\n")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == false then
    r[1].address = r[1].address - 8192
  end
  readedMem = rwmem(r[1].address, 40000)
  save(hexdecode(readedMem))
  gg.toast("File Found ✓")
  print("I got you Lionel Richie!\n\nThe file is at: /sdcard/decrypt.txt")
  gg.clearResults()
end

function TLSTunnel()
  limit = false
  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("h 3A 30 3A 30 3A 74 72 75 65 3A", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("File Not Found ❌: versi")
    tls_2 = true
  end
  if tls_2 then
    limit = false
    gg.searchNumber("h 33 35 39 3A 30 3A 30", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: 359 h")
      tls_3 = true
    end
  end
  if tls_3 then
    gg.searchNumber("h 00 00 7b 00 22 00 41 00 22 00 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: A")
      tls_4 = true
    end
  end
  if tls_4 then
    limit = false
    gg.searchNumber(":357:0:0:", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("357")
      tls_5 = true
    end
  end
  if tls_5 then
    gg.searchNumber("h 63 69 70 68 65 72 31 2e 64 6f 46 69 6e 61 6c 28 63 72 79 70 74 6f 29", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: cipher1 doFinal crypto")
      tls_6 = true
    end
  end
  if tls_6 then
    limit = false
    gg.searchNumber("h 75 00 70 00 77 00 73 00", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: upws")
      tls_7 = true
    end
  end
  if tls_7 then
    limit = false
    gg.searchNumber("h 55 70 67 72 61 64 65 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: Upgrade")
      tls_8 = true
    end
  end
  if tls_8 then
    limit = false
    gg.searchNumber("h 47 45 54 20 77 73", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: GET ws")
      tls_9 = true
    end
  end
  if tls_9 then
    limit = false
    gg.searchNumber("h 47 45 54 20 73 68 69", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: GET shi")
      tls_10 = true
    end
  end
  if tls_10 then
    limit = false
    gg.searchNumber("h 5b 68 6f 73 74 5d 5b 63 72 6c 66 5d", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: host crlf")
      tls_11 = true
    end
  end
  if tls_11 then
    gg.toast("File Not Found ❌")
    print("cousins ​​first.")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == false then
    r[1].address = r[1].address - 8192
  end
  readedMem = rwmem(r[1].address, 50000)
  save(hexdecode(readedMem))
  gg.toast("File Found ✓")
  print("I got you Lionel Richie!\n\nThe file is at: /sdcard/decrypt.txt")
  gg.clearResults()
end

function eV2ray()
  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("h 7B 0A 20 20 22 69 6E 62 6F 75 6E 64", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("File Not Found ❌: inbound")
    epro_2 = true
  end
  if epro_2 then
    gg.searchNumber("h 64 6e 73 22 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: dns")
      epro_3 = true
    end
  end
  if epro_3 then
    gg.searchNumber("h 6f 75 74 62 6f 75 6e 64 73 22 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: aspas outbounds")
      epro_4 = true
    end
  end
  if epro_4 then
    gg.searchNumber("h 22 69 6e 62 6f 75 6e 64 73 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: apsas inbounds")
      epro_5 = true
    end
  end
  if epro_5 then
    gg.toast("File Not Found ❌")
    print("\nCalm down, bitch, refresh your memory, re-import the file or start the VPN if you want")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == false then
    r[1].address = r[1].address - 0x400
  end
  readedMem = rwmem(r[1].address, 50000)
  save(hexdecode(readedMem))
  gg.toast("File Found ✓")
  print("I got you Lionel Richie!\n\nThe file is at: /sdcard/decrypt.txt")
  gg.clearResults()
end

function NapsternetV()
  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("h 22 76 65 72 73 69 6f 6e 69 6e 67 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("File Not Found ❌: versioning")
    npv_2 = true
  end
  if npv_2 then
    gg.searchNumber("h 55 70 67 72 61 64 65 3A", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: Upgrade")
      npv_3 = true
    end
  end
  if npv_3 then
    gg.searchNumber("h 7B 0A 09 09 22 69 6E 62 6F 75 6E 64", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: inbound")
      npv_4 = true
    end
  end
  if npv_4 then
    gg.searchNumber("h 70 73 69 70 68 6f 6e 43 6f 6e 66 69 67 22 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: psiphonConfig")
      npv_5 = true
    end
  end
  if npv_5 then
    limit = false
    gg.searchNumber("h 22 76 65 72 73 69 6f 6e 69 6e 67 22 65 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: versioning e")
      npv_6 = true
    end
  end
  if npv_6 then
    limit = false
    gg.searchNumber("h 7b 22 76 65 72 73 69 6f 6e 69 6e 67 22 3a 7b 22 63 6f 6e 66 69 67 54 79 70 65 22 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: versioning configType")
      npv_7 = true
    end
  end
  if npv_7 then
    gg.toast("File Not Found ❌")
    print("cousins ​​first.")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == false then
    r[1].address = r[1].address - 8192
  end
  readedMem = rwmem(r[1].address, 50000)
  save(hexdecode(readedMem))
  gg.toast("File Found ✓")
  print("I got you Lionel Richie!\n\nThe file is at: /sdcard/decrypt.txt")
  gg.clearResults()
end

function HATunnel()
  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("h 7b 22 75 73 65 72 5f 69 64 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("File Not Found ❌: user id")
    hat_2 = true
  end
  if hat_2 then
    gg.searchNumber("h 7b 5c 22 63 6f 6e 6e 65 63 74 69 6f 6e 5f 6d 6f 64 65 5c 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: connecion mode")
      hat_3 = true
    end
  end
  if hat_3 then
    limit = false
    gg.searchNumber("h7b22757365725f696422", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: id")
      hat_4 = true
    end
  end
  if hat_4 then
    limit = false
    gg.searchNumber("h 5c 22 6f 76 65 72 72 69 64 65 5f 70 72 69 6d 61 72 79 5f 68 6f 73 74 5c", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: override primary host")
      hat_5 = true
    end
  end
  if hat_5 then
    limit = false
    gg.searchNumber("h 61 63 63 65 73 73 5f 63 6f 64 65 22 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: acess code")
      hat_6 = true
    end
  end
  if hat_6 then
    gg.toast("File Not Found ❌")
    print("cousins ​​first.")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == false then
    r[1].address = r[1].address - 8192
  end
  readedMem = rwmem(r[1].address, 50000)
  save(hexdecode(readedMem))
  gg.toast("File Found ✓")
  print("I got you Lionel Richie!\n\nThe file is at: /sdcard/decrypt.txt")
  gg.clearResults()
end

function SocksHttpPlus()
  limit = true
  gg.clearResults()
  gg.setVisible(false)
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.searchNumber("h 7b 22 69 64 22 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("File Not Found ❌")
    print("cousins ​​first.")
    os.exit()
  end
  gg.searchNumber("h7B", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1000)
  readedMem = rwmem(r[1].address, 50000)
  save(hexdecode(readedMem))
  gg.toast("File Found ✓")
  print("I got you Lionel Richie!\n\nThe file is at: /sdcard/decrypt.txt")
  gg.clearResults()
end

function DarkTunnel()
  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("h537368436F6E6669674C6F636B6564C3A9537368436F6E666967", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("File Not Found ❌: SshConfigLockedeSshConfig")
    dark_2 = true
  end
  if dark_2 then
    gg.searchNumber(":SshConfigLockedéSshConfig", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: SshConfigLockedÃ©SshConfig")
      dark_3 = true
    end
  end
  if dark_3 then
    gg.searchNumber(":SshConfigLocked", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: SshConfigLocked")
      dark_4 = true
    end
  end
  if dark_4 then
    gg.searchNumber("h 53 73 68 43 6F 6E 66 69 67 4C 6F 63 6B 65 64 C3 A9 53 73 68 43 6F 6E 66 69 67", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: SshConfigLockedÃ©SshConfig")
      dark_5 = true
    end
  end
  if dark_5 then
    gg.searchNumber("h 53 73 68 43 6F 6E 66 69 67 4C 6F 63 6B 65 64 C3 A9 53 73 68 43 6F 6E 66 69 67", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: SshConfigLockedÃ©SshConfig")
      dark_6 = true
    end
  end
  if dark_6 then
    gg.searchNumber("h 53 73 68 43 6F 6E 66 69 67 4C 6F 63 6B 65 64 C3 A9 53 73 68 43 6F 6E 66 69 67", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: SshConfigLockedÃ©SshConfig")
      dark_7 = true
    end
  end
  if dark_7 then
    gg.searchNumber("h 4d 65 73 73 61 67 65 22 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: Message")
      dark_8 = true
    end
  end
  if dark_8 then
    gg.searchNumber("h 55 70 67 72 61 64 65 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: Upgrade")
      dark_9 = true
    end
  end
  if dark_9 then
    gg.searchNumber("h 7b 22 48 6f 73 74 22 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: Host")
      dark_10 = true
    end
  end
  if dark_10 then
    gg.searchNumber("h 69 6e 62 6f 75 6e 64 73", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: inbound")
      dark_11 = true
    end
  end
  if dark_11 then
    gg.toast("File Not Found ❌")
    print("cousins ​​first.")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == false then
    r[1].address = r[1].address - 0x400
  end
  readedMem = rwmem(r[1].address, 40000)
  save(hexdecode(readedMem))
  gg.toast("File Found ✓")
  print("I got you Lionel Richie!\n\nThe file is at: /sdcard/decrypt.txt")
  gg.clearResults()
end

function SocksHttp()
  limit = true
  gg.clearResults()
  gg.setVisible(false)
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.searchNumber("h 7b 22 73 73 68 53 65 72 76 65 72 22 3a 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("File Not Found ❌")
    print("cousins ​​first.")
    os.exit()
  end
  gg.searchNumber("h7B", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1000)
  if limit == false then
    r[1].address = r[1].address - 0x
    end
  readedMem = rwmem(r[1].address, 40000)
  save(hexdecode(readedMem))
  gg.toast("File Found ✓")
  print("I got you Lionel Richie!\n\nThe file is at: /sdcard/decrypt.txt")
  gg.clearResults()
end

function NetModSyna()
  limit = true
  gg.clearResults()
  gg.setVisible(false)
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA )
  gg.searchNumber("h 7B 22 50 61 79 6C 6F 61 64 22 3A 7B 22 56 61 6C 75 65 22 3A", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("File Not Found ❌")
    print("cousins ​​first.")
    os.exit()
  end
  gg.searchNumber("7Bh", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  readedMem = rwmem(r[1].address, 50000)
  save(hexdecode(readedMem))
  gg.toast("File Found ✓")
  print("I got you Lionel Richie!\n\nThe file is at: /sdcard/decrypt.txt")
  gg.clearResults()
end

function RezTunnel()
  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("h 7B 5C 22 50 53 49 6E 73 74 61 6C 6C 5C 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("File Not Found ❌: install")
    rez_2 = true
  end
  if rez_2 then
    gg.searchNumber("h 7b 22 50 53 49 6e 73 74 61 6c 6c 22 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: PSInstall 1")
      rez_3 = true
    end
  end
  if rez_3 then
    gg.searchNumber("h 50 53 49 6e 73 74 61 6c 6c 22 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: PSInstall 2")
      rez_4 = true
    end
  end
  if rez_4 then
    gg.searchNumber("h 48 6f 73 74 3a 5b 72 6f 74 61 74 65 3d", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌:  rotate")
      rez_5 = true
    end
  end
  if rez_5 then
    gg.searchNumber("h 7B 0A 20 20 20 20 22 56 65 72 73 69 6F 6E 22 3A 20", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: Version Config full")
      rez_6 = true
    end
  end
  if rez_6 then
    gg.searchNumber("h 53 53 48 48 6f 73 74 22 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: SSHHost")
      rez_7 = true
    end
  end
  if rez_7 then
    gg.searchNumber("h 55 70 67 72 61 64 65 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: Version Upgrade")
      rez_8 = true
    end
  end
  if rez_8 then
    gg.toast("File Not Found ❌")
    print("cousins ​​first.")
    os.exit()
  end
  local r = gg.getResults(1)
  if limit == true then
    r[1].address = r[1].address - 8192
  end
  readedMem = rwmem(r[1].address, 50000)
  save(hexdecode(readedMem))
  gg.toast("File Found ✓")
  print("I got you Lionel Richie!\n\nThe file is at: /sdcard/decrypt.txt")
  gg.clearResults()
end

function ApkCustom()
  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("h 3A 34 34 33 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("File Not Found ❌: 443")
    acm_2 = true
  end
  if acm_2 then
    gg.searchNumber("h 55 70 67 72 61 64 65 3A", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: Upgrade")
      acm_3 = true
    end
  end
  if acm_3 then
    gg.searchNumber("h 3A 38 30 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: 80")
      acm_4 = true
    end
  end
  if acm_4 then
    limit = true
    gg.searchNumber("h 7B 0A 09 09 22 69 6E 62 6F 75 6E 64", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: inbound")
      acm_5 = true
    end
  end
  if acm_5 then
    limit = false
    gg.searchNumber("h 7B 0A 20 20 22 64 6E 73 22 3A 20 7B 0A 20 20 20 20 22 68 6F 73 74 73 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: dns hosts")
      acm_6 = true
    end
  end
  if acm_6 then
    limit = false
    gg.searchNumber("h 3A 35 33 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: 53")
      acm_7 = true
    end
  end
  if acm_7 then
    limit = false
    gg.searchNumber("h 5B 73 70 6C 69 74 50 73 69 70 68 6F 6E 5D 5B 73 70 6C 69 74 50 73 69 70 68 6F 6E 5D", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: splitPsiphon")
      acm_8 = true
    end
  end
  if acm_8 then
    gg.toast("File Not Found ❌")
    print("cousins ​​first.")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == false then
    r[1].address = r[1].address - 8192
  end
  readedMem = rwmem(r[1].address, 50000)
  save(hexdecode(readedMem))
  gg.toast("File Found ✓")
  print("I got you Lionel Richie!\n\nThe file is at: /sdcard/decrypt.txt")
  gg.clearResults()
end

function SocksIP()
  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("h6E6577746F6F6C73776F726B732E636F6D2E736F636B7369702E7574696C732E536572536F636B73495068", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("File Not Found ❌: network sip")
    sip_2 = true
  end
  if sip_2 then
    gg.searchNumber("h 55 70 67 72 61 64 65 3A", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: Upgrade")
      sip_3 = true
    end
  end
  if sip_3 then
    gg.searchNumber("h 73 73 68 6f 63 65 61 6e", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: sshocean")
      sip_4 = true
    end
  end
  if sip_4 then
    gg.searchNumber("h 3A 38 30 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: 80")
      sip_5 = true
    end
  end
  if sip_5 then
    limit = false
    gg.searchNumber("h 7B 0A 09 09 22 69 6E 62 6F 75 6E 64", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: inbound")
      sip_6 = true
    end
  end
  if sip_6 then
    limit = false
    gg.searchNumber("h 73 70 65 65 64 79 73 73 68 2e", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: dns hosts")
      sip_7 = true
    end
  end
  if sip_7 then
    limit = false
    gg.searchNumber("h 3A 35 33 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: 53")
      sip_8 = true
    end
  end
  if sip_8 then
    limit = false
    gg.searchNumber("h 47 45 54 20 77", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: GET w")
      sip_9 = true
    end
  end
  if sip_9 then
    limit = false
    gg.searchNumber("h 5b 63 72 6c 66 5d 48 6f 73 74 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: crlf host")
      sip_10 = true
    end
  end
  if sip_10 then
    limit = false
    gg.searchNumber("h 48 6f 73 74 3a 5b 72 6f 74 61 74 65 3d", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: rotate")
      sip_11 = true
    end
  end
  if sip_11 then
    limit = false
    gg.searchNumber("h 3A 34 34 33 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: 443")
      sip_12 = true
    end
  end
  if sip_12 then
    gg.toast("File Not Found ❌")
    print("cousins ​​first.")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == false then
    r[1].address = r[1].address - 8192
  end
  readedMem = rwmem(r[1].address, 20000)
  save(hexdecode(readedMem))
  gg.toast("File Found ✓")
  print("I got you Lionel Richie!\n\nThe file is at: /sdcard/decrypt.txt")
  gg.clearResults()
end

function StarkVPN()
  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("h 7B 5C 22 63 6F 6E 66 69 67 5C 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("File Not Found ❌: config barra")
    stk_2 = true
  end
  if stk_2 then
    gg.searchNumber("h 63 6f 6e 66 69 67 22 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: config aspas")
      stk_3 = true
    end
  end
  if stk_3 then
    limit = false
    gg.searchNumber("h 63 6f 6e 6e 65 63 74 69 6f 6e 5f 6d 6f 64 65 22 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: connection mode")
      stk_4 = true
    end
  end
  if stk_4 then
    gg.toast("File Not Found ❌")
    print("cousins ​​first.")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == false then
    r[1].address = r[1].address - 8192
  end
  readedMem = rwmem(r[1].address, 50000)
  save(hexdecode(readedMem))
  gg.toast("File Found ✓")
  print("I got you Lionel Richie!\n\nThe file is at: /sdcard/decrypt.txt")
  gg.clearResults()
end

function configjson()
limit = true
  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("h 7B 09 22 56 65 72 73 69 6F 6E 22 3A 20 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("File Not Found ❌: Version")
    json_2 = true
  end
  if json_2 then
    gg.searchNumber("h 7B 0A 20 20 20 20 22 56 65 72 73 69 6F 6E", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: Version")
      json_3 = true
    end
  end
  if json_3 then
    gg.searchNumber("h 7b a 9 22 56 65 72 73 69 6f 6e 22 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: Version")
      json_4 = true
    end
  end
  if json_4 then
    gg.searchNumber("h 7b a 20 20 22 56 65 72 73 69 6f 6e 22 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: Version")
      json_5 = true
    end
  end
  if json_5 then
    gg.searchNumber("h 22 56 65 72 73 69", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: Versi")
      json_6 = true
    end
  end
  if json_6 then
  limit = false
    gg.searchNumber("h 7B 0A 20 20 22 56 65 72 73 69 6F 6E 22 3A 20 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: version aspas")
      json_7 = true
    end
  end
  if json_7 then
    gg.searchNumber("h 7B 5C 22 56 65 72 73 69 6F 6E 5C 22 3A 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: version barra")
      json_8 = true
    end
  end
  if json_8 then
    gg.searchNumber("h 22 2c 22 52 65 6c 65 61 73 65 4e 6f 74 65 73 22 3a 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: ReleaseNotes")
      json_9 = true
    end
  end
  if json_9 then
    gg.toast("File Not Found ❌")
    print("cousins ​​first.")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == false then
    r[1].address = r[1].address - 0x
  end
  readedMem = rwmem(r[1].address, 150000)
  save(hexdecode(readedMem))
  gg.toast("File Found ✓")
  print("I got you Lionel Richie!\n\nThe file is at: /sdcard/decrypt.txt")
  gg.clearResults()
end

function TunnelCat()
  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("h 7B 5C 22 65 78 70 6F 72 74 44 65 74 61 69 6C 73 5C 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("File Not Found ❌: export D")
    cat_2 = true
  end
  if cat_2 then
    gg.searchNumber("h 7b 5c 22 65 78 70 6f 72 74 44 65 74 61 69 6c 73 5c 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: exportDetails")
      cat_3 = true
    end
  end
  if cat_3 then
    gg.searchNumber(";exportDetails", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: exportDe")
      cat_4 = true
    end
  end
  if cat_4 then
    gg.searchNumber("h 55 70 67 72 61 64 65 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: Upgrade")
      cat_5 = true
    end
  end
  if cat_5 then
    gg.searchNumber("h 69 6e 62 6f 75 6e 64 73", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: inbound")
      cat_6 = true
    end
  end
  if cat_6 then
    gg.toast("File Not Found ❌")
    print("cousins ​​first.")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == false then
    r[1].address = r[1].address - 8192
  end
  readedMem = rwmem(r[1].address, 20000)
  save(hexdecode(readedMem))
  gg.toast("File Found ✓")
  print("I got you Lionel Richie!\n\nThe file is at: /sdcard/decrypt.txt")
  gg.clearResults()
end

function v2rayHybrid()
  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("h 7B 5C 22 61 64 64 65 64 54 69 6D 65 5C 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("File Not Found ❌: addedtime")
    hy_2 = true
  end
  if hy_2 then
    gg.searchNumber("h 7b 5c 22 61 64 64 65 64 54 69 6d 65 5c 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: added Time")
      hy_3 = true
    end
  end
  if hy_3 then
    gg.searchNumber(";addedTime", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: addedTime")
      hy_4 = true
    end
  end
  if hy_4 then
    gg.searchNumber("h 55 70 67 72 61 64 65 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: Upgrade")
      cat_5 = true
    end
  end
  if hy_5 then
    gg.searchNumber("h 69 6e 62 6f 75 6e 64 73", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: inbound")
      hy_6 = true
    end
  end
  if hy_6 then
    gg.toast("File Not Found ❌")
    print("cousins ​​first.")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == false then
    r[1].address = r[1].address - 8192
  end
  readedMem = rwmem(r[1].address, 20000)
  save(hexdecode(readedMem))
  gg.toast("File Found ✓")
  print("I got you Lionel Richie!\n\nThe file is at: /sdcard/decrypt.txt")
  gg.clearResults()
end

function ARMod()
  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber(":[{\"AlterID\"", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("File Not Found ❌: alter id")
    armo_2 = true
  end
  if armo_2 then
    gg.searchNumber("h 5b 7b 5c 22 41 6c 74 65 72 49 44 5c 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: alter")
      armo_3 = true
    end
  end
  if armo_3 then
    gg.searchNumber(";AlterID", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: addedTime")
      armo_4 = true
    end
  end
  if armo_4 then
    gg.searchNumber("h 55 70 67 72 61 64 65 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: Upgrade")
      armo_5 = true
    end
  end
  if armo_5 then
    gg.searchNumber("h 69 6e 62 6f 75 6e 64 73", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: inbound")
      armo_6 = true
    end
  end
  if armo_6 then
    gg.toast("File Not Found ❌")
    print("cousins ​​first.")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == false then
    r[1].address = r[1].address - 8192
  end
  readedMem = rwmem(r[1].address, 20000)
  save(hexdecode(readedMem))
  gg.toast("File Found ✓")
  print("I got you Lionel Richie!\n\nThe file is at: /sdcard/decrypt.txt")
  gg.clearResults()
end

function WeTunnel()
  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("h 7B 5C 22 50 53 49 6E 73 74 61 6C 6C 5C 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("File Not Found ❌: install")
    we_2 = true
  end
  if we_2 then
    gg.searchNumber("h 7b 22 50 53 49 6e 73 74 61 6c 6c 22 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: PSInstall 1")
      we_3 = true
    end
  end
  if we_3 then
    gg.searchNumber("h 50 53 49 6e 73 74 61 6c 6c 22 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: PSInstall 2")
      we_4 = true
    end
  end
  if we_4 then
    gg.searchNumber("h 7B 5C 22 50 53 49 6E 73 74 61 6C 6C 5C 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌:  install 2")
      we_5 = true
    end
  end
  if we_5 then
    gg.searchNumber("h 7B 0A 20 20 20 20 22 56 65 72 73 69 6F 6E 22 3A 20", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: Version Config full")
      we_6 = true
    end
  end
  if we_6 then
    gg.searchNumber("h 53 53 48 48 6f 73 74 22 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: SSHHost")
      we_7 = true
    end
  end
  if we_7 then
    gg.searchNumber("h 55 70 67 72 61 64 65 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: Version Upgrade")
      we_8 = true
    end
  end
  if we_8 then
    gg.toast("File Not Found ❌")
    print("cousins ​​first.")
    os.exit()
  end
  local r = gg.getResults(1)
  if limit == true then
    r[1].address = r[1].address - 8192
  end
  readedMem = rwmem(r[1].address, 50000)
  save(hexdecode(readedMem))
  gg.toast("File Found ✓")
  print("I got you Lionel Richie!\n\nThe file is at: /sdcard/decrypt.txt")
  gg.clearResults()
end

function XrayPB()
  gg.clearResults()
  gg.setVisible(false)
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.searchNumber(";{\"addedTime\"", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("File Not Found ❌: addedTime")
    pb_2 = true
  end
  if pb_2 then
    gg.searchNumber("h 7B 5C 22 61 64 64 65 64 54 69 6D 65 5C 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: added")
      pb_3 = true
    end
  end
  if pb_3 then
    gg.toast("File Not Found ❌")
    print("cousins ​​first.")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == true then
    r[1].address = r[1].address - 8192
  end
  readedMem = rwmem(r[1].address, 20000)
  save(hexdecode(readedMem))
  gg.toast("File Found ✓")
  print("I got you Lionel Richie!\n\nThe file is at: /sdcard/decrypt.txt")
  gg.clearResults()
end

function OpenTunnel()
  gg.clearResults()
  gg.setVisible(false)
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.searchNumber("h 3C 2F 65 6E 74 72 79 3E 0A 3C 65 6E 74 72 79 20 6B 65 79 3D", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("File Not Found ❌: addedTime")
    tnl_2 = true
  end
  if tnl_2 then
    gg.searchNumber("h 3C 2F 65 6E 74 72 79 3E 0A 3C 65 6E 74 72 79 20 6B 65 79 3D", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: added")
      tnl_3 = true
    end
  end
  if tnl_3 then
    gg.toast("File Not Found ❌")
    print("cousins ​​first.")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == true then
    r[1].address = r[1].address - 8192
  end
  readedMem = rwmem(r[1].address, 20000)
  save(hexdecode(readedMem))
  gg.toast("File Found ✓")
  print("I got you Lionel Richie!\n\nThe file is at: /sdcard/decrypt.txt")
  gg.clearResults()
end

function sopass()
  gg.clearResults()
  gg.setVisible(false)
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.searchNumber(";{\"Password\"", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("File Not Found ❌: pass")
    efbd_2 = true
  end
  if efbd_2 then
    gg.searchNumber("h 7b 5c 22 50 61 73 73 77 6f 72 64 5c 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: Password barra")
      efbd_3 = true
    end
  end
  if efbd_3 then
    gg.toast("File Not Found ❌")
    print("cousins ​​first.")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == true then
    r[1].address = r[1].address - 8192
  end
  readedMem = rwmem(r[1].address, 40000)
  save(hexdecode(readedMem))
  gg.toast("File Found ✓")
  print("I got you Lionel Richie!\n\nThe file is at: /sdcard/decrypt.txt")
  gg.clearResults()
end

function kobra()
  gg.clearResults()
  gg.setVisible(false)
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.searchNumber(":Servidores", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("File Not Found ❌: servidores")
    kobras_2 = true
  end
  if kobras_2 then
    gg.searchNumber(":Upgrade:", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: Upgrade")
      kobras_3 = true
    end
  end
  if kobras_3 then
    gg.toast("File Not Found ❌")
    print("cousins ​​first.")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == false then
    r[1].address = r[1].address - 8192
  end
  readedMem = rwmem(r[1].address, 50000)
  save(hexdecode(readedMem))
  gg.toast("File Found ✓")
  print("I got you Lionel Richie!\n\nThe file is at: /sdcard/decrypt.txt")
  gg.clearResults()
  end

function kobras()
  limit = true
  gg.clearResults()
  gg.setVisible(false)
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.searchNumber("h 7B 0A 20 20 20 20 22 53 65 72 76 69 64 6F 72 65 73 22 3A", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("File Not Found ❌")
    print("cousins ​​first.")
    os.exit()
  end
  gg.searchNumber("h7B", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1000)
  readedMem = rwmem(r[1].address, 50000)
  save(hexdecode(readedMem))
  gg.toast("File Found ✓")
  print("I got you Lionel Richie!\n\nThe file is at: /sdcard/decrypt.txt")
  gg.clearResults()
end
  
if app == "com.evozi.injector" then
  HttpInjector()
elseif app == "com.evozi.injector.lite" then
  HttpInjector()
elseif app == "xyz.easypro.httpcustom" then
  HTTPCustom()
elseif app == "com.tlsvpn.tlstunnel" then
  TLSTunnel()
elseif app == "dev.epro.ssc" then
  hc_ssc()
elseif app == "dev.epro.e_v2ray" then
  eV2ray()
elseif app == "com.napsternetlabs.napsternetv" then
  NapsternetV()
elseif app == "com.newtoolsworks.sockstunnel" then
  SocksIP()
elseif app == "com.slipkprojects.sockshttp" then
  SocksHttp()
elseif app == "com.slipkprojects.sksplus" then
  SocksHttpPlus()
elseif app == "com.hatunnel.plus" then
  HATunnel()
elseif app == "team.dev.epro.apkcustom" then
  ApkCustom()
elseif app == "com.techoragontcptun" then
  RezTunnel()
elseif app == "net.darktunnel.app" then
  DarkTunnel()
elseif app == "com.tunnelcatvpn.android" then
  TunnelCat()
elseif app == "com.v2ray.hybrid" then
  v2rayHybrid()
elseif app == "com.one.vpnapp" then
  configjson()
  elseif app == "mau.miracle.mau" then
  configjson()
  elseif app == "onnet.miracle" then
  configjson()
  elseif app == "com.conecta4g.vpn" then
  configjson()
elseif app == "com.hybrid.tunnel" then
  configjson()
elseif app == "com.gdmnetpro.vpn" then
  jsonum()
elseif app == "com.trrorcloud.br" then
  configjson()
elseif app == "com.lockproig.vpn" then
  configjson()
elseif app == "app.hackkcah.xyz" then
  configjson()
elseif app == "com.handy.vpn" then
  configjson()
elseif app == "com.socketclay.http" then
  configjson()
elseif app == "com.internetinfinito.http" then
  configjson()
elseif app == "com.socketconexion.vps" then
  configjson()
elseif app == "com.fenix.vpn" then
  configjson()
elseif app == "com.turbovpn.app" then
  configjson()
elseif app == "com.mastercloudvpn.http" then
  configjson()
elseif app == "com.godiesan.vpn" then
  configjson()
elseif app == "com.cloud.focus" then
  configjson()
  elseif app == "com.upnet4gbr.telecom" then
  configjson()
  elseif app == "com.internetvpn.vpnff" then
  configjson()
elseif app == "com.doriaxvpn.http" then
  configjson()
elseif app == "com.sockslitepro.net" then
  socksliteP()
elseif app == "com.mnjnet.rev" then
  configjson()
elseif app == "br.com.litesshbrasil" then
  jsonum()
  elseif app == "com.hunter.net" then
  revhunter()
elseif app == "istark.vpn.starkreloaded" then
  StarkVPN()
elseif app == "com.Internetshub.socks" then
  WeTunnel()
elseif app == "com.sihiver.xraypb" then
  XrayPB()
elseif app == "com.opentunnel.app" then
  OpenTunnel()
elseif app == "com.artunnel57" then
  ARMod()
elseif app == "com.ar.dev.bdvpninject" then
  sopass()
elseif app == "com.ef.dev.eftunnel" then
  sopass()
  elseif app == "kobras.vpn.ultra.max.miguel.pro" then
  kobras()
elseif app == "com.netmod.syna" then
  NetModSyna()
else
  gg.toast("don't let me see")
  print("\ntoday is not your lucky day\n\n")
end
gg.clearResults()
os.exit()
pcall(load(x9C))
prima()
end

function hc()

limit = false
targetInfo = gg.getTargetInfo()
app = targetInfo.packageName
local utf8 = {}
local bit = {
  data32 = {}
}
do
  do
    for SRD1_5_ = 1, 32 do
      bit.data32[SRD1_5_] = 2 ^ (32 - SRD1_5_)
    end
  end
end
local toby = string.byte
function utf8.charbytes(s, i)
  i = i or 1
  local c = string.byte(s, i)
  if c > 0 and c <= 127 then
    do return 1 end
    return
  end
  if c >= 194 and c <= 223 then
    do return 2 end
    return
  end
  if c >= 224 and c <= 239 then
    do return 3 end
    return
  end
  if c >= 240 and c <= 244 then
    return 4
  end
  return 1
end

local ded
function bit:d2b(arg)
  if arg == nil then
    return
  end
  local tr, c = {}, arg < 0
  if c then
    arg = 0 - arg
  end
  do
    do
      for SRD1_7_ = 1, 32 do
        if arg >= self.data32[SRD1_7_] then
          tr[SRD1_7_] = 1
          arg = arg - self.data32[SRD1_7_]
        else
          tr[SRD1_7_] = 0
        end
      end
    end
  end
  if c then
    tr = self:_bnot(tr)
    tr = self:b2d(tr) + 1
    tr = self:d2b(tr)
  end
  return tr
end

function bit:b2d(arg, neg)
  local nr = 0
  if arg[1] == 1 and neg == true then
    arg = self:_bnot(arg)
    nr = self:b2d(arg) + 1
    nr = 0 - nr
  else
    do
      for SRD1_7_ = 1, 32 do
        if arg[SRD1_7_] == 1 then
          nr = nr + 2 ^ (32 - SRD1_7_)
        end
      end
    end
  end
  return nr
end

function bit:_and(a, b)
  local op1 = self:d2b(a)
  local op2 = self:d2b(b)
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == 1 and op2[SRD1_9_] == 1 then
          r[SRD1_9_] = 1
        else
          r[SRD1_9_] = 0
        end
      end
    end
  end
  return self:b2d(r, true)
end

function bit:_or(a, b)
  local op1 = self:d2b(a)
  local op2 = self:d2b(b)
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == 1 or op2[SRD1_9_] == 1 then
          r[SRD1_9_] = 1
        else
          r[SRD1_9_] = 0
        end
      end
    end
  end
  return self:b2d(r, true)
end

function bit:_xor(a, b)
  local op1 = self:d2b(a)
  if op1 == nil then
    return nil
  end
  local op2 = self:d2b(b)
  if op2 == nil then
    return nil
  end
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == op2[SRD1_9_] then
          r[SRD1_9_] = 0
        else
          r[SRD1_9_] = 1
        end
      end
    end
  end
  return self:b2d(r, true)
end

local switch = {
  [1] = function(s, pos)
    local c1 = toby(s, pos)
    return c1
  end
  ,
  [2] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local int1 = bit:_and(31, c1)
    local int2 = bit:_and(63, c2)
    return bit:_or(bit:_lshift(int1, 6), int2)
  end
  ,
  [3] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local c3 = toby(s, pos + 2)
    local int1 = bit:_and(15, c1)
    local int2 = bit:_and(63, c2)
    local int3 = bit:_and(63, c3)
    local o2 = bit:_or(bit:_lshift(int1, 12), bit:_lshift(int2, 6))
    local dt = bit:_or(o2, int3)
    return dt
  end
  ,
  [4] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local c3 = toby(s, pos + 2)
    local c4 = toby(s, pos + 3)
    local int1 = bit:_and(15, c1)
    local int2 = bit:_and(63, c2)
    local int3 = bit:_and(63, c3)
    local int4 = bit:_and(63, c4)
    local o2 = bit:_or(bit:_lshift(int1, 18), bit:_lshift(int2, 12))
    local o3 = bit:_or(o2, bit:_lshift(int3, 6))
    local o4 = bit:_or(o3, int4)
    return o4
  end
  
}
function bit:_bnot(op1)
  local r = {}
  do
    do
      for SRD1_6_ = 1, 32 do
        if op1[SRD1_6_] == 1 then
          r[SRD1_6_] = 0
        else
          r[SRD1_6_] = 1
        end
      end
    end
  end
  return r
end

function bit:_not(a)
  local op1 = self:d2b(a)
  local r = self:_bnot(op1)
  return self:b2d(r, true)
end

function bit:charCodeAt(s)
  local pos, int, H, L = 1, 0, 0, 0
  local slen = string.len(s)
  local allByte = {}
  while pos <= slen do
    local tLen = utf8.charbytes(s, pos)
    if tLen >= 1 and tLen <= 4 then
      if tLen == 4 then
        int = switch[4](s, pos)
        H = math.floor((int - 65536) / 1024) + 55296
        L = (int - 65536) % 1024 + 56320
        table.insert(allByte, H)
        table.insert(allByte, L)
      else
        int = switch[tLen](s, pos)
        table.insert(allByte, int)
      end
    end
    pos = pos + tLen
  end
  return allByte
end

function bit:_rshift(a, n)
  local r = 0
  if a < 0 then
    r = 0 - self:_frshift(0 - a, n)
  elseif a >= 0 then
    r = self:_frshift(a, n)
  end
  return r
end

function bit:_frshift(a, n)
  local op1 = self:d2b(a)
  local r = self:d2b(0)
  local left = 32 - n
  if n < 32 and n > 0 then
    do
      for SRD1_9_ = left, 1, -1 do
        r[SRD1_9_ + n] = op1[SRD1_9_]
      end
    end
  end
  return self:b2d(r)
end

function bit:_lshift(a, n)
  local op1 = self:d2b(a)
  local r = self:d2b(0)
  if n < 32 and n > 0 then
    do
      for SRD1_8_ = n, 31 do
        r[SRD1_8_ - n + 1] = op1[SRD1_8_ + 1]
      end
    end
  end
  return self:b2d(r, true)
end

function trim(s)
  return s:match("^%s*(.*)"):match("(.-)%s*$")
end

local json = {}
local kind_of = function(obj)
  if type(obj) ~= "table" then
    return type(obj)
  end
  local i = 1
  do
    do
      for SRD1_5_ in pairs(obj) do
        if obj[i] ~= nil then
          i = i + 1
        else
          return "table"
        end
      end
    end
  end
  if i == 1 then
    do return "table" end
    return
  end
  return "array"
end

local escape_str = function(s)
  local in_char = {
    "\\",
    "\"",
    "/",
    "\b",
    "\f",
    "\n",
    "\r",
    "\t"
  }
  local out_char = {
    "\\",
    "\"",
    "/",
    "b",
    "f",
    "n",
    "r",
    "t"
  }
  do
    do
      for SRD1_6_, SRD1_7_ in ipairs(in_char) do
        s = s:gsub(SRD1_7_, "\\" .. out_char[SRD1_6_])
      end
    end
  end
  return s
end

local skip_delim = function(str, pos, delim, err_if_missing)
  pos = pos + #str:match("^%s*", pos)
  if str:sub(pos, pos) ~= delim then
    if err_if_missing then
      error("Expected " .. delim .. " close position " .. pos)
    end
    return pos, false
  end
  return pos + 1, true
end

local function parse_str_val(str, pos, val)
  val = val or ""
  local early_end_error = "End of input encountered during string parsing."
  if pos > #str then
    error(early_end_error)
  end
  local c = str:sub(pos, pos)
  if c == "\"" then
    return val, pos + 1
  end
  if c ~= "\\" then
    return parse_str_val(str, pos + 1, val .. c)
  end
  local esc_map = {
    b = "\b",
    f = "\f",
    n = "\n",
    r = "\r",
    t = "\t"
  }
  local nextc = str:sub(pos + 1, pos + 1)
  if not nextc then
    error(early_end_error)
  end
  return parse_str_val(str, pos + 2, val .. (esc_map[nextc] or nextc))
end

local parse_num_val = function(str, pos)
  local num_str = str:match("^-?%d+%.?%d*[eE]?[+-]?%d*", pos)
  local val = tonumber(num_str)
  if not val then
    error("Error parsing number at position " .. pos .. ".")
  end
  return val, pos + #num_str
end

function json.stringify(obj, as_key)
  local s = {}
  local kind = kind_of(obj)
  if kind == "array" then
    if as_key then
      error("Unable to encode array as key.")
    end
    s[#s + 1] = "["
    do
      do
        for SRD1_7_, SRD1_8_ in ipairs(obj) do
          if SRD1_7_ > 1 then
            s[#s + 1] = ", "
          end
          s[#s + 1] = json.stringify(SRD1_8_)
        end
      end
    end
    s[#s + 1] = "]"
  elseif kind == "table" then
    if as_key then
      error("Unable to key encode table.")
    end
    s[#s + 1] = "{"
    do
      do
        for SRD1_7_, SRD1_8_ in pairs(obj) do
          if #s > 1 then
            s[#s + 1] = ", "
          end
          s[#s + 1] = json.stringify(SRD1_7_, true)
          s[#s + 1] = ":"
          s[#s + 1] = json.stringify(SRD1_8_)
        end
      end
    end
    s[#s + 1] = "}"
  else
    if kind == "string" then
      do return "\"" .. escape_str(obj) .. "\"" end
      return
    end
    if kind == "number" then
      if as_key then
        return "\"" .. tostring(obj) .. "\""
      end
      do return tostring(obj) end
      return
    end
    if kind == "boolean" then
      do return tostring(obj) end
      return
    end
    if kind == "nil" then
      do return "null" end
      return
    end
    error("unjsonifiable type,: " .. kind .. ".")
  end
  return table.concat(s)
end

json.null = {}
function json.parse(str, pos, end_delim)
  pos = pos or 1
  if pos > #str then
    error("Reached unexpected end of input ")
  end
  local pos = pos + #str:match("^%s*", pos)
  local first = str:sub(pos, pos)
  if first == "{" then
    do
      local obj, key, delim_found = {}, true, true
      pos = pos + 1
      while true do
        key, pos = json.parse(str, pos, "}")
        if key == nil then
          return obj, pos
        end
        if not delim_found then
          error("Missing comma between object items.")
        end
        pos = skip_delim(str, pos, ":", true)
        obj[key], pos = json.parse(str, pos)
        pos, delim_found = skip_delim(str, pos, ",")
      end
    end
    return
  end
  if first == "[" then
    do
      local arr, val, delim_found = {}, true, true
      pos = pos + 1
      while true do
        val, pos = json.parse(str, pos, "]")
        if val == nil then
          return arr, pos
        end
        if not delim_found then
          error("Missing comma between array items.")
        end
        arr[#arr + 1] = val
        pos, delim_found = skip_delim(str, pos, ",")
      end
    end
    return
  end
  if first == "\"" then
    do return parse_str_val(str, pos + 1) end
    return
  end
  if first == "-" or first:match("%d") then
    do return parse_num_val(str, pos) end
    return
  end
  if first == end_delim then
    do return nil, pos + 1 end
    return
  end
  do
    local literals = {
      ["true"] = true,
      ["false"] = false,
      null = json.null
    }
    do
      do
        for SRD1_9_, SRD1_10_ in pairs(literals) do
          local lit_end = pos + #SRD1_9_ - 1
          if str:sub(pos, lit_end) == SRD1_9_ then
            return SRD1_10_, lit_end + 1
          end
        end
      end
    end
    local pos_info_str = "position " .. pos .. ": " .. str:sub(pos, pos + 10)
    error("Invalid json syntax starting at " .. pos_info_str)
  end
end

function enc(data, b)
  return (data:gsub(".", function(x)
    local r, b = "", x:byte()
    do
      do
        for SRD1_6_ = 8, 1, -1 do
          r = r .. (b % 2 ^ SRD1_6_ - b % 2 ^ (SRD1_6_ - 1) > 0 and "1" or "0")
        end
      end
    end
    return r
  end
  ) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(x)
    if #x < 6 then
      return ""
    end
    local c = 0
    do
      do
        for SRD1_5_ = 1, 6 do
          c = c + (x:sub(SRD1_5_, SRD1_5_) == "1" and 2 ^ (6 - SRD1_5_) or 0)
        end
      end
    end
    return b:sub(c + 1, c + 1)
  end
  ) .. ({
    "",
    "??",
    "?"
  })[#data % 3 + 1]
end

function dec(data, b)
  data = string.gsub(data, "[^" .. b .. "=]", "")
  return (data:gsub(".", function(x)
    if x == "?" then
      return ""
    end
    local r, f = "", b:find(x) - 1
    do
      do
        for SRD1_6_ = 6, 1, -1 do
          r = r .. (f % 2 ^ SRD1_6_ - f % 2 ^ (SRD1_6_ - 1) > 0 and "1" or "0")
        end
      end
    end
    return r
  end
  ):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(x)
    if #x ~= 8 then
      return ""
    end
    local c = 0
    do
      do
        for SRD1_5_ = 1, 8 do
          c = c + (x:sub(SRD1_5_, SRD1_5_) == "1" and 2 ^ (8 - SRD1_5_) or 0)
        end
      end
    end
    return string.char(c)
  end
  ))
end

function rwmem(Address, SizeOrBuffer)
  assert(Address ~= nil, "[rwmem]: error, given address is null.")
  _rw = {}
  if type(SizeOrBuffer) == "number" then
    _ = ""
    do
      do
        for SRD1_5_ = 1, SizeOrBuffer do
          _rw[SRD1_5_] = {
            address = Address - 1 + SRD1_5_,
            flags = gg.TYPE_BYTE
          }
        end
      end
    end
    do
      do
        for SRD1_5_, SRD1_6_ in ipairs(gg.getValues(_rw)) do
          if SRD1_6_.value == 0 and limit == true then
            return _
          end
          _ = _ .. string.format("%02X", SRD1_6_.value & 255)
        end
      end
    end
    return _
  end
  Byte = {}
  SizeOrBuffer:gsub("..", function(x)
    Byte[#Byte + 1] = x
    _rw[#Byte] = {
      address = Address - 1 + #Byte,
      flags = gg.TYPE_BYTE,
      value = x .. "h"
    }
  end
  )
  gg.setValues(_rw)
end

function hexdecode(hex)
  return (hex:gsub("%x%x", function(digits)
    return string.char(tonumber(digits, 16))
  end
  ))
end

function hexencode(str)
  return (str:gsub(".", function(char)
    return string.format("%2x", char:byte())
  end
  ))
end

function Dec2Hex(nValue)
  nHexVal = string.format("%X", nValue)
  sHexVal = nHexVal .. ""
  return sHexVal
end

function ToInteger(number)
  return math.floor(tonumber(number) or error("It was not possible transmitir '" .. tostring(number) .. "' enumerate.'"))
end

function conta(data)
  io.open(gg.EXT_STORAGE .. "/conta_hc.txt", "w"):write(data)
  gg.toast("I got you Lionel Richie!")
end

function save2(data)
  io.open(gg.EXT_STORAGE .. "/decrypt.txt", "w"):write(json.stringify(data))
  gg.toast("I got you Lionel Richie!")
end

function hc(data)
  io.open(gg.EXT_STORAGE .. "/hc.txt", "w"):write(data)
  gg.toast("I got you Lionel Richie!")
end

function v2json(data)
  io.open(gg.EXT_STORAGE .. "/v2ray.txt", "w"):write(data)
end

function contahc()
  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("h 3A 34 34 33 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("File Not Found ❌: 443")
    hc_2 = true
  end
  if hc_2 then
  limit = false
    gg.searchNumber("h 3A 38 30 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: 80")
      hc_3 = true
    end
  end
  if hc_3 then
  limit = false
    gg.searchNumber("h 3A 38 30 38 30 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: 8080")
      hc_4 = true
    end
  end
  if hc_4 then
  limit = false
    gg.searchNumber("h 3a 32 32 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: 22")
      hc_5 = true
    end
  end
  if hc_5 then
    limit = false
    gg.searchNumber("h 3a 32 32 32 32 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: 2222")
      hc_6 = true
    end
  end
  if hc_6 then
    limit = false
    gg.searchNumber("h 3a 34 34 34 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: 444")
      hc_7 = true
    end
  end
  if hc_7 then
    limit = false
    gg.searchNumber("h 3A 35 33 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: 53")
      hc_8 = true
    end
  end
  if hc_8 then
    limit = false
    gg.searchNumber("h 3a 31 31 39 34 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: 1194")
      hc_9 = true
    end
  end
  if hc_9 then
    limit = false
    gg.searchNumber("h 3a 38 37 39 39 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: 8799")
      hc_10 = true
    end
  end
  if hc_10 then
    limit = false
    gg.searchNumber("h 3a 38 30 38 38 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: 8088")
      hc_11 = true
    end
  end
  if hc_11 then
    limit = false
    gg.searchNumber("h 3a 32 30 35 32 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: 2052")
      hc_12 = true
    end
  end
  if hc_12 then
    limit = false
    gg.searchNumber("h 3a 32 30 35 32 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: 143")
      hc_13 = true
    end
  end
  if hc_13 then
    limit = false
    gg.searchNumber("h 3a 32 30 38 32 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: 2082")
      hc_14 = true
    end
  end
  if hc_14 then
    limit = false
    gg.searchNumber("h 3a 34 34 32 40", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: 442")
      hc_15 = true
    end
  end
  if hc_15 then
    limit = false
    gg.searchNumber("h 2e 6d 79 2e 69 64 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: my id")
      hc_16 = true
    end
  end
  if hc_16 then
    limit = false
    gg.searchNumber("h 2e 6f 6e 6c 69 6e 65 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: online")
      hc_17 = true
    end
  end
  if hc_17 then
    limit = false
    gg.searchNumber("h 2e 6e 65 74 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: net")
      hc_18 = true
    end
  end
  if hc_18 then
    limit = false
    gg.searchNumber("h 2e 6d 6c 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: ml")
      hc_19 = true
    end
  end
  if hc_19 then
    limit = false
    gg.searchNumber("h 2e 63 6c 6f 75 64 66 72 6f 6e 74 2e 6e 65 74 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: cloudfront")
      hc_20 = true
    end
  end
  if hc_20 then
    gg.toast("File Not Found ❌")
    print("edit your search, use new keywords or reload the application and configuration again\n")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == false then
    r[1].address = r[1].address - 1000
  end
  readedMem = rwmem(r[1].address, 10000)
  conta(hexdecode(readedMem))
  gg.toast("File Found ✓")
  print("I got you Lionel Richie!\n\nThe file is at: /sdcard/conta_hc.txt")
  gg.clearResults()
end
  
if app == "xyz.easypro.httpcustom" then
  contahc()
elseif app == "xyz.easypro.httpcustom" then
  contahc()
else
  gg.toast("accidentally kicked")
  print("\nwhat will be my challenge today?\n\n")
end
gg.clearResults()
pcall(load(Payload))
prima()
end

function Payload()

limit = false

local utf8 = {}
local bit = {
  data32 = {}
}
do
  do
    for SRD1_5_ = 1, 32 do
      bit.data32[SRD1_5_] = 2 ^ (32 - SRD1_5_)
    end
  end
end
local toby = string.byte
function utf8.charbytes(s, i)
  i = i or 1
  local c = string.byte(s, i)
  if c > 0 and c <= 127 then
    do return 1 end
    return
  end
  if c >= 194 and c <= 223 then
    do return 2 end
    return
  end
  if c >= 224 and c <= 239 then
    do return 3 end
    return
  end
  if c >= 240 and c <= 244 then
    return 4
  end
  return 1
end

local ded
function bit:d2b(arg)
  if arg == nil then
    return
  end
  local tr, c = {}, arg < 0
  if c then
    arg = 0 - arg
  end
  do
    do
      for SRD1_7_ = 1, 32 do
        if arg >= self.data32[SRD1_7_] then
          tr[SRD1_7_] = 1
          arg = arg - self.data32[SRD1_7_]
        else
          tr[SRD1_7_] = 0
        end
      end
    end
  end
  if c then
    tr = self:_bnot(tr)
    tr = self:b2d(tr) + 1
    tr = self:d2b(tr)
  end
  return tr
end

function bit:b2d(arg, neg)
  local nr = 0
  if arg[1] == 1 and neg == true then
    arg = self:_bnot(arg)
    nr = self:b2d(arg) + 1
    nr = 0 - nr
  else
    do
      for SRD1_7_ = 1, 32 do
        if arg[SRD1_7_] == 1 then
          nr = nr + 2 ^ (32 - SRD1_7_)
        end
      end
    end
  end
  return nr
end

function bit:_and(a, b)
  local op1 = self:d2b(a)
  local op2 = self:d2b(b)
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == 1 and op2[SRD1_9_] == 1 then
          r[SRD1_9_] = 1
        else
          r[SRD1_9_] = 0
        end
      end
    end
  end
  return self:b2d(r, true)
end

function bit:_or(a, b)
  local op1 = self:d2b(a)
  local op2 = self:d2b(b)
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == 1 or op2[SRD1_9_] == 1 then
          r[SRD1_9_] = 1
        else
          r[SRD1_9_] = 0
        end
      end
    end
  end
  return self:b2d(r, true)
end

function bit:_xor(a, b)
  local op1 = self:d2b(a)
  if op1 == nil then
    return nil
  end
  local op2 = self:d2b(b)
  if op2 == nil then
    return nil
  end
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == op2[SRD1_9_] then
          r[SRD1_9_] = 0
        else
          r[SRD1_9_] = 1
        end
      end
    end
  end
  return self:b2d(r, true)
end

local switch = {
  [1] = function(s, pos)
    local c1 = toby(s, pos)
    return c1
  end
  ,
  [2] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local int1 = bit:_and(31, c1)
    local int2 = bit:_and(63, c2)
    return bit:_or(bit:_lshift(int1, 6), int2)
  end
  ,
  [3] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local c3 = toby(s, pos + 2)
    local int1 = bit:_and(15, c1)
    local int2 = bit:_and(63, c2)
    local int3 = bit:_and(63, c3)
    local o2 = bit:_or(bit:_lshift(int1, 12), bit:_lshift(int2, 6))
    local dt = bit:_or(o2, int3)
    return dt
  end
  ,
  [4] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local c3 = toby(s, pos + 2)
    local c4 = toby(s, pos + 3)
    local int1 = bit:_and(15, c1)
    local int2 = bit:_and(63, c2)
    local int3 = bit:_and(63, c3)
    local int4 = bit:_and(63, c4)
    local o2 = bit:_or(bit:_lshift(int1, 18), bit:_lshift(int2, 12))
    local o3 = bit:_or(o2, bit:_lshift(int3, 6))
    local o4 = bit:_or(o3, int4)
    return o4
  end
  
}
function bit:_bnot(op1)
  local r = {}
  do
    do
      for SRD1_6_ = 1, 32 do
        if op1[SRD1_6_] == 1 then
          r[SRD1_6_] = 0
        else
          r[SRD1_6_] = 1
        end
      end
    end
  end
  return r
end

function bit:_not(a)
  local op1 = self:d2b(a)
  local r = self:_bnot(op1)
  return self:b2d(r, true)
end

function bit:charCodeAt(s)
  local pos, int, H, L = 1, 0, 0, 0
  local slen = string.len(s)
  local allByte = {}
  while pos <= slen do
    local tLen = utf8.charbytes(s, pos)
    if tLen >= 1 and tLen <= 4 then
      if tLen == 4 then
        int = switch[4](s, pos)
        H = math.floor((int - 65536) / 1024) + 55296
        L = (int - 65536) % 1024 + 56320
        table.insert(allByte, H)
        table.insert(allByte, L)
      else
        int = switch[tLen](s, pos)
        table.insert(allByte, int)
      end
    end
    pos = pos + tLen
  end
  return allByte
end

function bit:_rshift(a, n)
  local r = 0
  if a < 0 then
    r = 0 - self:_frshift(0 - a, n)
  elseif a >= 0 then
    r = self:_frshift(a, n)
  end
  return r
end

function bit:_frshift(a, n)
  local op1 = self:d2b(a)
  local r = self:d2b(0)
  local left = 32 - n
  if n < 32 and n > 0 then
    do
      for SRD1_9_ = left, 1, -1 do
        r[SRD1_9_ + n] = op1[SRD1_9_]
      end
    end
  end
  return self:b2d(r)
end

function bit:_lshift(a, n)
  local op1 = self:d2b(a)
  local r = self:d2b(0)
  if n < 32 and n > 0 then
    do
      for SRD1_8_ = n, 31 do
        r[SRD1_8_ - n + 1] = op1[SRD1_8_ + 1]
      end
    end
  end
  return self:b2d(r, true)
end

function trim(s)
  return s:match("^%s*(.*)"):match("(.-)%s*$")
end

local json = {}
local kind_of = function(obj)
  if type(obj) ~= "table" then
    return type(obj)
  end
  local i = 1
  do
    do
      for SRD1_5_ in pairs(obj) do
        if obj[i] ~= nil then
          i = i + 1
        else
          return "table"
        end
      end
    end
  end
  if i == 1 then
    do return "table" end
    return
  end
  return "array"
end

local escape_str = function(s)
  local in_char = {
    "\\",
    "\"",
    "/",
    "\b",
    "\f",
    "\n",
    "\r",
    "\t"
  }
  local out_char = {
    "\\",
    "\"",
    "/",
    "b",
    "f",
    "n",
    "r",
    "t"
  }
  do
    do
      for SRD1_6_, SRD1_7_ in ipairs(in_char) do
        s = s:gsub(SRD1_7_, "\\" .. out_char[SRD1_6_])
      end
    end
  end
  return s
end

local skip_delim = function(str, pos, delim, err_if_missing)
  pos = pos + #str:match("^%s*", pos)
  if str:sub(pos, pos) ~= delim then
    if err_if_missing then
      error("Expected " .. delim .. " close position " .. pos)
    end
    return pos, false
  end
  return pos + 1, true
end

local function parse_str_val(str, pos, val)
  val = val or ""
  local early_end_error = "End of input encountered during string parsing."
  if pos > #str then
    error(early_end_error)
  end
  local c = str:sub(pos, pos)
  if c == "\"" then
    return val, pos + 1
  end
  if c ~= "\\" then
    return parse_str_val(str, pos + 1, val .. c)
  end
  local esc_map = {
    b = "\b",
    f = "\f",
    n = "\n",
    r = "\r",
    t = "\t"
  }
  local nextc = str:sub(pos + 1, pos + 1)
  if not nextc then
    error(early_end_error)
  end
  return parse_str_val(str, pos + 2, val .. (esc_map[nextc] or nextc))
end

local parse_num_val = function(str, pos)
  local num_str = str:match("^-?%d+%.?%d*[eE]?[+-]?%d*", pos)
  local val = tonumber(num_str)
  if not val then
    error("Error parsing number at position " .. pos .. ".")
  end
  return val, pos + #num_str
end

function json.stringify(obj, as_key)
  local s = {}
  local kind = kind_of(obj)
  if kind == "array" then
    if as_key then
      error("Unable to encode array as key.")
    end
    s[#s + 1] = "["
    do
      do
        for SRD1_7_, SRD1_8_ in ipairs(obj) do
          if SRD1_7_ > 1 then
            s[#s + 1] = ", "
          end
          s[#s + 1] = json.stringify(SRD1_8_)
        end
      end
    end
    s[#s + 1] = "]"
  elseif kind == "table" then
    if as_key then
      error("Unable to key encode table.")
    end
    s[#s + 1] = "{"
    do
      do
        for SRD1_7_, SRD1_8_ in pairs(obj) do
          if #s > 1 then
            s[#s + 1] = ", "
          end
          s[#s + 1] = json.stringify(SRD1_7_, true)
          s[#s + 1] = ":"
          s[#s + 1] = json.stringify(SRD1_8_)
        end
      end
    end
    s[#s + 1] = "}"
  else
    if kind == "string" then
      do return "\"" .. escape_str(obj) .. "\"" end
      return
    end
    if kind == "number" then
      if as_key then
        return "\"" .. tostring(obj) .. "\""
      end
      do return tostring(obj) end
      return
    end
    if kind == "boolean" then
      do return tostring(obj) end
      return
    end
    if kind == "nil" then
      do return "null" end
      return
    end
    error("unjsonifiable type,: " .. kind .. ".")
  end
  return table.concat(s)
end

json.null = {}
function json.parse(str, pos, end_delim)
  pos = pos or 1
  if pos > #str then
    error("Reached unexpected end of input ")
  end
  local pos = pos + #str:match("^%s*", pos)
  local first = str:sub(pos, pos)
  if first == "{" then
    do
      local obj, key, delim_found = {}, true, true
      pos = pos + 1
      while true do
        key, pos = json.parse(str, pos, "}")
        if key == nil then
          return obj, pos
        end
        if not delim_found then
          error("Missing comma between object items.")
        end
        pos = skip_delim(str, pos, ":", true)
        obj[key], pos = json.parse(str, pos)
        pos, delim_found = skip_delim(str, pos, ",")
      end
    end
    return
  end
  if first == "[" then
    do
      local arr, val, delim_found = {}, true, true
      pos = pos + 1
      while true do
        val, pos = json.parse(str, pos, "]")
        if val == nil then
          return arr, pos
        end
        if not delim_found then
          error("Missing comma between array items.")
        end
        arr[#arr + 1] = val
        pos, delim_found = skip_delim(str, pos, ",")
      end
    end
    return
  end
  if first == "\"" then
    do return parse_str_val(str, pos + 1) end
    return
  end
  if first == "-" or first:match("%d") then
    do return parse_num_val(str, pos) end
    return
  end
  if first == end_delim then
    do return nil, pos + 1 end
    return
  end
  do
    local literals = {
      ["true"] = true,
      ["false"] = false,
      null = json.null
    }
    do
      do
        for SRD1_9_, SRD1_10_ in pairs(literals) do
          local lit_end = pos + #SRD1_9_ - 1
          if str:sub(pos, lit_end) == SRD1_9_ then
            return SRD1_10_, lit_end + 1
          end
        end
      end
    end
    local pos_info_str = "position " .. pos .. ": " .. str:sub(pos, pos + 10)
    error("Invalid json syntax starting at " .. pos_info_str)
  end
end

function enc(data, b)
  return (data:gsub(".", function(x)
    local r, b = "", x:byte()
    do
      do
        for SRD1_6_ = 8, 1, -1 do
          r = r .. (b % 2 ^ SRD1_6_ - b % 2 ^ (SRD1_6_ - 1) > 0 and "1" or "0")
        end
      end
    end
    return r
  end
  ) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(x)
    if #x < 6 then
      return ""
    end
    local c = 0
    do
      do
        for SRD1_5_ = 1, 6 do
          c = c + (x:sub(SRD1_5_, SRD1_5_) == "1" and 2 ^ (6 - SRD1_5_) or 0)
        end
      end
    end
    return b:sub(c + 1, c + 1)
  end
  ) .. ({
    "",
    "??",
    "?"
  })[#data % 3 + 1]
end

function dec(data, b)
  data = string.gsub(data, "[^" .. b .. "=]", "")
  return (data:gsub(".", function(x)
    if x == "?" then
      return ""
    end
    local r, f = "", b:find(x) - 1
    do
      do
        for SRD1_6_ = 6, 1, -1 do
          r = r .. (f % 2 ^ SRD1_6_ - f % 2 ^ (SRD1_6_ - 1) > 0 and "1" or "0")
        end
      end
    end
    return r
  end
  ):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(x)
    if #x ~= 8 then
      return ""
    end
    local c = 0
    do
      do
        for SRD1_5_ = 1, 8 do
          c = c + (x:sub(SRD1_5_, SRD1_5_) == "1" and 2 ^ (8 - SRD1_5_) or 0)
        end
      end
    end
    return string.char(c)
  end
  ))
end

function rwmem(Address, SizeOrBuffer)
  assert(Address ~= nil, "[rwmem]: error, given address is null.")
  _rw = {}
  if type(SizeOrBuffer) == "number" then
    _ = ""
    do
      do
        for SRD1_5_ = 1, SizeOrBuffer do
          _rw[SRD1_5_] = {
            address = Address - 1 + SRD1_5_,
            flags = gg.TYPE_BYTE
          }
        end
      end
    end
    do
      do
        for SRD1_5_, SRD1_6_ in ipairs(gg.getValues(_rw)) do
          if SRD1_6_.value == 0 and limit == true then
            return _
          end
          _ = _ .. string.format("%02X", SRD1_6_.value & 255)
        end
      end
    end
    return _
  end
  Byte = {}
  SizeOrBuffer:gsub("..", function(x)
    Byte[#Byte + 1] = x
    _rw[#Byte] = {
      address = Address - 1 + #Byte,
      flags = gg.TYPE_BYTE,
      value = x .. "h"
    }
  end
  )
  gg.setValues(_rw)
end

function hexdecode(hex)
  return (hex:gsub("%x%x", function(digits)
    return string.char(tonumber(digits, 16))
  end
  ))
end

function hexencode(str)
  return (str:gsub(".", function(char)
    return string.format("%2x", char:byte())
  end
  ))
end

function Dec2Hex(nValue)
  nHexVal = string.format("%X", nValue)
  sHexVal = nHexVal .. ""
  return sHexVal
end

function ToInteger(number)
  return math.floor(tonumber(number) or error("It was not possible transmitir '" .. tostring(number) .. "' enumerate.'"))
end

function payload(data)
  io.open(gg.EXT_STORAGE .. "/payload.txt", "w"):write(data)
  gg.toast("I got you Lionel Richie!")
end

function save2(data)
  io.open(gg.EXT_STORAGE .. "/decrypt.txt", "w"):write(json.stringify(data))
  gg.toast("I got you Lionel Richie!")
end

function hc(data)
  io.open(gg.EXT_STORAGE .. "/hc.txt", "w"):write(data)
  gg.toast("I got you Lionel Richie!")
end

function v2json(data)
  io.open(gg.EXT_STORAGE .. "/v2ray.txt", "w"):write(data)
end

limit = false

  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("h 55 70 67 72 61 64 65 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("File Not Found ❌: Upgrade")
    hc_2 = true
  end
  if hc_2 then
    gg.searchNumber("h 75 70 67 72 61 64 65 3a", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: upgrade")
      hc_3 = true
    end
  end
  if hc_3 then
    gg.searchNumber("h 47 45 54 20 77 73", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: GET ws")
      hc_4 = true
    end
  end
  if hc_4 then
    gg.searchNumber("h 43 4F 4E 4E 45 43 54 20 5B 68 6F 73 74 5F 70 6F 72 74 5D", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: connect crlf")
      hc_5 = true
    end
  end
  if hc_5 then
    gg.searchNumber("h 5B 72 6F 74 61 74 69 6F 6E 3D", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: rotation")
      hc_6 = true
    end
  end
  if hc_6 then
    gg.searchNumber("h 5B 72 61 6E 64 6F 6D 3D", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: random")
      hc_7 = true
    end
  end
  if hc_7 then
    gg.searchNumber("h 5B 63 72 6C 66 5D 50 72 6F 78 79 2D 43 6F 6E 6E 65 63 74 69 6F 6E", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: proxy connection")
      hc_8 = true
    end
  end
  if hc_8 then
    gg.searchNumber("h 5B 72 6F 74 61 74 65 3D", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: rotate")
      hc_9 = true
    end
  end
  if hc_9 then
    gg.searchNumber("h 5B 63 72 6C 66 5D 20 5B 63 72 6C 66 5D", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: crlf esp")
      hc_10 = true
    end
  end
  if hc_10 then
    gg.searchNumber("h 5B 70 72 6F 74 6F 63 6F 6C 5D 5B 63 72 6C 66 5D", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: protocol crlf")
      hc_11 = true
    end
  end
  if hc_11 then
    gg.searchNumber("h 5B 63 72 6C 66 5D 48 6F 73 74 3A", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: crlf host")
      hc_12 = true
    end
  end
  if hc_12 then
    gg.searchNumber("h 5C 6E 48 6F 73 74 3A", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: n crlf")
      hc_13 = true
    end
  end
  if hc_13 then
    gg.searchNumber("h 50 55 54 20 2F 3F", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: p u int")
      hc_14 = true
    end
  end
  if hc_14 then
    gg.searchNumber("h 45 78 70 65 63 74 3A 20 31 30 30 2D 63 6F 6E 74 69 6E 75 65", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: exp 100 con")
      hc_15 = true
    end
  end
  if hc_15 then
    gg.searchNumber("h 5B 6C 66 5D 5B 73 70 6C 69 74 5D", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: lf split")
      hc_16 = true
    end
  end
  if hc_16 then
    gg.searchNumber("h 58 2D 4F 6E 6C 69 6E 65 2D 48 6F 73 74 3A", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: x online")
      hc_17 = true
    end
  end
  if hc_17 then
    gg.searchNumber("h 5C 6E 5C 6E", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: n n")
      hc_18 = true
    end
  end
  if hc_18 then
    gg.searchNumber("h 5B 6E 65 74 44 61 74 61 5D 5C 72 0A 5C 72", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: netdata r split")
      hc_19 = true
    end
  end
  if hc_19 then
    gg.searchNumber("h 2E 67 6F 76 5B 63 72 6C 66 5D", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: gov crlf")
      hc_20 = true
    end
  end
  if hc_20 then
    gg.toast("File Not Found ❌")
    print("edit your search, use new keywords or reload the application and configuration again\n")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == false then
    r[1].address = r[1].address - 1000
  end
  readedMem = rwmem(r[1].address, 10000)
  payload(hexdecode(readedMem))
  gg.toast("File Found ✓")
  print("I got you Lionel Richie!\n\nThe file is at: /sdcard/payoload.txt")
  gg.clearResults()
  gg.toast("don't let me see")
  print("\ntoday is not your lucky day\n\n")
gg.clearResults()
os.exit()
pcall(load(Payload))
prima()
end

function login()
limit = false

local utf8 = {}
local bit = {
  data32 = {}
}
do
  do
    for SRD1_5_ = 1, 32 do
      bit.data32[SRD1_5_] = 2 ^ (32 - SRD1_5_)
    end
  end
end
local toby = string.byte
function utf8.charbytes(s, i)
  i = i or 1
  local c = string.byte(s, i)
  if c > 0 and c <= 127 then
    do return 1 end
    return
  end
  if c >= 194 and c <= 223 then
    do return 2 end
    return
  end
  if c >= 224 and c <= 239 then
    do return 3 end
    return
  end
  if c >= 240 and c <= 244 then
    return 4
  end
  return 1
end

local ded
function bit:d2b(arg)
  if arg == nil then
    return
  end
  local tr, c = {}, arg < 0
  if c then
    arg = 0 - arg
  end
  do
    do
      for SRD1_7_ = 1, 32 do
        if arg >= self.data32[SRD1_7_] then
          tr[SRD1_7_] = 1
          arg = arg - self.data32[SRD1_7_]
        else
          tr[SRD1_7_] = 0
        end
      end
    end
  end
  if c then
    tr = self:_bnot(tr)
    tr = self:b2d(tr) + 1
    tr = self:d2b(tr)
  end
  return tr
end

function bit:b2d(arg, neg)
  local nr = 0
  if arg[1] == 1 and neg == true then
    arg = self:_bnot(arg)
    nr = self:b2d(arg) + 1
    nr = 0 - nr
  else
    do
      for SRD1_7_ = 1, 32 do
        if arg[SRD1_7_] == 1 then
          nr = nr + 2 ^ (32 - SRD1_7_)
        end
      end
    end
  end
  return nr
end

function bit:_and(a, b)
  local op1 = self:d2b(a)
  local op2 = self:d2b(b)
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == 1 and op2[SRD1_9_] == 1 then
          r[SRD1_9_] = 1
        else
          r[SRD1_9_] = 0
        end
      end
    end
  end
  return self:b2d(r, true)
end

function bit:_or(a, b)
  local op1 = self:d2b(a)
  local op2 = self:d2b(b)
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == 1 or op2[SRD1_9_] == 1 then
          r[SRD1_9_] = 1
        else
          r[SRD1_9_] = 0
        end
      end
    end
  end
  return self:b2d(r, true)
end

function bit:_xor(a, b)
  local op1 = self:d2b(a)
  if op1 == nil then
    return nil
  end
  local op2 = self:d2b(b)
  if op2 == nil then
    return nil
  end
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == op2[SRD1_9_] then
          r[SRD1_9_] = 0
        else
          r[SRD1_9_] = 1
        end
      end
    end
  end
  return self:b2d(r, true)
end

local switch = {
  [1] = function(s, pos)
    local c1 = toby(s, pos)
    return c1
  end
  ,
  [2] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local int1 = bit:_and(31, c1)
    local int2 = bit:_and(63, c2)
    return bit:_or(bit:_lshift(int1, 6), int2)
  end
  ,
  [3] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local c3 = toby(s, pos + 2)
    local int1 = bit:_and(15, c1)
    local int2 = bit:_and(63, c2)
    local int3 = bit:_and(63, c3)
    local o2 = bit:_or(bit:_lshift(int1, 12), bit:_lshift(int2, 6))
    local dt = bit:_or(o2, int3)
    return dt
  end
  ,
  [4] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local c3 = toby(s, pos + 2)
    local c4 = toby(s, pos + 3)
    local int1 = bit:_and(15, c1)
    local int2 = bit:_and(63, c2)
    local int3 = bit:_and(63, c3)
    local int4 = bit:_and(63, c4)
    local o2 = bit:_or(bit:_lshift(int1, 18), bit:_lshift(int2, 12))
    local o3 = bit:_or(o2, bit:_lshift(int3, 6))
    local o4 = bit:_or(o3, int4)
    return o4
  end
  
}
function bit:_bnot(op1)
  local r = {}
  do
    do
      for SRD1_6_ = 1, 32 do
        if op1[SRD1_6_] == 1 then
          r[SRD1_6_] = 0
        else
          r[SRD1_6_] = 1
        end
      end
    end
  end
  return r
end

function bit:_not(a)
  local op1 = self:d2b(a)
  local r = self:_bnot(op1)
  return self:b2d(r, true)
end

function bit:charCodeAt(s)
  local pos, int, H, L = 1, 0, 0, 0
  local slen = string.len(s)
  local allByte = {}
  while pos <= slen do
    local tLen = utf8.charbytes(s, pos)
    if tLen >= 1 and tLen <= 4 then
      if tLen == 4 then
        int = switch[4](s, pos)
        H = math.floor((int - 65536) / 1024) + 55296
        L = (int - 65536) % 1024 + 56320
        table.insert(allByte, H)
        table.insert(allByte, L)
      else
        int = switch[tLen](s, pos)
        table.insert(allByte, int)
      end
    end
    pos = pos + tLen
  end
  return allByte
end

function bit:_rshift(a, n)
  local r = 0
  if a < 0 then
    r = 0 - self:_frshift(0 - a, n)
  elseif a >= 0 then
    r = self:_frshift(a, n)
  end
  return r
end

function bit:_frshift(a, n)
  local op1 = self:d2b(a)
  local r = self:d2b(0)
  local left = 32 - n
  if n < 32 and n > 0 then
    do
      for SRD1_9_ = left, 1, -1 do
        r[SRD1_9_ + n] = op1[SRD1_9_]
      end
    end
  end
  return self:b2d(r)
end

function bit:_lshift(a, n)
  local op1 = self:d2b(a)
  local r = self:d2b(0)
  if n < 32 and n > 0 then
    do
      for SRD1_8_ = n, 31 do
        r[SRD1_8_ - n + 1] = op1[SRD1_8_ + 1]
      end
    end
  end
  return self:b2d(r, true)
end

function trim(s)
  return s:match("^%s*(.*)"):match("(.-)%s*$")
end

local json = {}
local kind_of = function(obj)
  if type(obj) ~= "table" then
    return type(obj)
  end
  local i = 1
  do
    do
      for SRD1_5_ in pairs(obj) do
        if obj[i] ~= nil then
          i = i + 1
        else
          return "table"
        end
      end
    end
  end
  if i == 1 then
    do return "table" end
    return
  end
  return "array"
end

local escape_str = function(s)
  local in_char = {
    "\\",
    "\"",
    "/",
    "\b",
    "\f",
    "\n",
    "\r",
    "\t"
  }
  local out_char = {
    "\\",
    "\"",
    "/",
    "b",
    "f",
    "n",
    "r",
    "t"
  }
  do
    do
      for SRD1_6_, SRD1_7_ in ipairs(in_char) do
        s = s:gsub(SRD1_7_, "\\" .. out_char[SRD1_6_])
      end
    end
  end
  return s
end

local skip_delim = function(str, pos, delim, err_if_missing)
  pos = pos + #str:match("^%s*", pos)
  if str:sub(pos, pos) ~= delim then
    if err_if_missing then
      error("Expected " .. delim .. " close position " .. pos)
    end
    return pos, false
  end
  return pos + 1, true
end

local function parse_str_val(str, pos, val)
  val = val or ""
  local early_end_error = "End of input encountered during string parsing."
  if pos > #str then
    error(early_end_error)
  end
  local c = str:sub(pos, pos)
  if c == "\"" then
    return val, pos + 1
  end
  if c ~= "\\" then
    return parse_str_val(str, pos + 1, val .. c)
  end
  local esc_map = {
    b = "\b",
    f = "\f",
    n = "\n",
    r = "\r",
    t = "\t"
  }
  local nextc = str:sub(pos + 1, pos + 1)
  if not nextc then
    error(early_end_error)
  end
  return parse_str_val(str, pos + 2, val .. (esc_map[nextc] or nextc))
end

local parse_num_val = function(str, pos)
  local num_str = str:match("^-?%d+%.?%d*[eE]?[+-]?%d*", pos)
  local val = tonumber(num_str)
  if not val then
    error("Error parsing number at position " .. pos .. ".")
  end
  return val, pos + #num_str
end

function json.stringify(obj, as_key)
  local s = {}
  local kind = kind_of(obj)
  if kind == "array" then
    if as_key then
      error("Unable to encode array as key.")
    end
    s[#s + 1] = "["
    do
      do
        for SRD1_7_, SRD1_8_ in ipairs(obj) do
          if SRD1_7_ > 1 then
            s[#s + 1] = ", "
          end
          s[#s + 1] = json.stringify(SRD1_8_)
        end
      end
    end
    s[#s + 1] = "]"
  elseif kind == "table" then
    if as_key then
      error("Unable to key encode table.")
    end
    s[#s + 1] = "{"
    do
      do
        for SRD1_7_, SRD1_8_ in pairs(obj) do
          if #s > 1 then
            s[#s + 1] = ", "
          end
          s[#s + 1] = json.stringify(SRD1_7_, true)
          s[#s + 1] = ":"
          s[#s + 1] = json.stringify(SRD1_8_)
        end
      end
    end
    s[#s + 1] = "}"
  else
    if kind == "string" then
      do return "\"" .. escape_str(obj) .. "\"" end
      return
    end
    if kind == "number" then
      if as_key then
        return "\"" .. tostring(obj) .. "\""
      end
      do return tostring(obj) end
      return
    end
    if kind == "boolean" then
      do return tostring(obj) end
      return
    end
    if kind == "nil" then
      do return "null" end
      return
    end
    error("unjsonifiable type,: " .. kind .. ".")
  end
  return table.concat(s)
end

json.null = {}
function json.parse(str, pos, end_delim)
  pos = pos or 1
  if pos > #str then
    error("Reached unexpected end of input ")
  end
  local pos = pos + #str:match("^%s*", pos)
  local first = str:sub(pos, pos)
  if first == "{" then
    do
      local obj, key, delim_found = {}, true, true
      pos = pos + 1
      while true do
        key, pos = json.parse(str, pos, "}")
        if key == nil then
          return obj, pos
        end
        if not delim_found then
          error("Missing comma between object items.")
        end
        pos = skip_delim(str, pos, ":", true)
        obj[key], pos = json.parse(str, pos)
        pos, delim_found = skip_delim(str, pos, ",")
      end
    end
    return
  end
  if first == "[" then
    do
      local arr, val, delim_found = {}, true, true
      pos = pos + 1
      while true do
        val, pos = json.parse(str, pos, "]")
        if val == nil then
          return arr, pos
        end
        if not delim_found then
          error("Missing comma between array items.")
        end
        arr[#arr + 1] = val
        pos, delim_found = skip_delim(str, pos, ",")
      end
    end
    return
  end
  if first == "\"" then
    do return parse_str_val(str, pos + 1) end
    return
  end
  if first == "-" or first:match("%d") then
    do return parse_num_val(str, pos) end
    return
  end
  if first == end_delim then
    do return nil, pos + 1 end
    return
  end
  do
    local literals = {
      ["true"] = true,
      ["false"] = false,
      null = json.null
    }
    do
      do
        for SRD1_9_, SRD1_10_ in pairs(literals) do
          local lit_end = pos + #SRD1_9_ - 1
          if str:sub(pos, lit_end) == SRD1_9_ then
            return SRD1_10_, lit_end + 1
          end
        end
      end
    end
    local pos_info_str = "position " .. pos .. ": " .. str:sub(pos, pos + 10)
    error("Invalid json syntax starting at " .. pos_info_str)
  end
end

function enc(data, b)
  return (data:gsub(".", function(x)
    local r, b = "", x:byte()
    do
      do
        for SRD1_6_ = 8, 1, -1 do
          r = r .. (b % 2 ^ SRD1_6_ - b % 2 ^ (SRD1_6_ - 1) > 0 and "1" or "0")
        end
      end
    end
    return r
  end
  ) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(x)
    if #x < 6 then
      return ""
    end
    local c = 0
    do
      do
        for SRD1_5_ = 1, 6 do
          c = c + (x:sub(SRD1_5_, SRD1_5_) == "1" and 2 ^ (6 - SRD1_5_) or 0)
        end
      end
    end
    return b:sub(c + 1, c + 1)
  end
  ) .. ({
    "",
    "??",
    "?"
  })[#data % 3 + 1]
end

function dec(data, b)
  data = string.gsub(data, "[^" .. b .. "=]", "")
  return (data:gsub(".", function(x)
    if x == "?" then
      return ""
    end
    local r, f = "", b:find(x) - 1
    do
      do
        for SRD1_6_ = 6, 1, -1 do
          r = r .. (f % 2 ^ SRD1_6_ - f % 2 ^ (SRD1_6_ - 1) > 0 and "1" or "0")
        end
      end
    end
    return r
  end
  ):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(x)
    if #x ~= 8 then
      return ""
    end
    local c = 0
    do
      do
        for SRD1_5_ = 1, 8 do
          c = c + (x:sub(SRD1_5_, SRD1_5_) == "1" and 2 ^ (8 - SRD1_5_) or 0)
        end
      end
    end
    return string.char(c)
  end
  ))
end

function rwmem(Address, SizeOrBuffer)
  assert(Address ~= nil, "[rwmem]: error, given address is null.")
  _rw = {}
  if type(SizeOrBuffer) == "number" then
    _ = ""
    do
      do
        for SRD1_5_ = 1, SizeOrBuffer do
          _rw[SRD1_5_] = {
            address = Address - 1 + SRD1_5_,
            flags = gg.TYPE_BYTE
          }
        end
      end
    end
    do
      do
        for SRD1_5_, SRD1_6_ in ipairs(gg.getValues(_rw)) do
          if SRD1_6_.value == 0 and limit == true then
            return _
          end
          _ = _ .. string.format("%02X", SRD1_6_.value & 255)
        end
      end
    end
    return _
  end
  Byte = {}
  SizeOrBuffer:gsub("..", function(x)
    Byte[#Byte + 1] = x
    _rw[#Byte] = {
      address = Address - 1 + #Byte,
      flags = gg.TYPE_BYTE,
      value = x .. "h"
    }
  end
  )
  gg.setValues(_rw)
end

function hexdecode(hex)
  return (hex:gsub("%x%x", function(digits)
    return string.char(tonumber(digits, 16))
  end
  ))
end

function hexencode(str)
  return (str:gsub(".", function(char)
    return string.format("%2x", char:byte())
  end
  ))
end

function Dec2Hex(nValue)
  nHexVal = string.format("%X", nValue)
  sHexVal = nHexVal .. ""
  return sHexVal
end

function ToInteger(number)
  return math.floor(tonumber(number) or error("It was not possible transmitir '" .. tostring(number) .. "' enumerate.'"))
end

function logins(data)
  io.open(gg.EXT_STORAGE .. "/login.txt", "w"):write(data)
  gg.toast("I got you Lionel Richie!")
end

limit = false

  gg.clearResults()
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.processPause()
  gg.searchNumber(":ssh-connection   password", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
  gg.processResume()
    gg.toast("File Not Found ❌: ssh-connection")
    logins_2 = true
  end
  if logins_2 then
  limit = false
    gg.searchNumber("h 0E 73 73 68 2D 63 6F 6E 6E 65 63 74 69 6F 6E 00 00 00 08 70 61 73 73 77 6F 72 64", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: ssh-connection")
  gg.processResume()
  return
  end
  x9B()
  end
  
  local r = gg.getResults(1000)
  if limit == false then
    r[1].address = r[1].address - 0x400
  end
  readedMem = rwmem(r[1].address, 10000)
  logins(hexdecode(readedMem))
  gg.toast("File Found ✓")
  print("I got you Lionel Richie!\n\nThe file is at: /sdcard/login.txt")
  gg.clearResults()
  gg.toast("don't let me see")
  print("\ntoday is your lucky day\n\n")
gg.clearResults()
gg.processResume()
return
x9B()
end
function V2Ray()

limit = true

local utf8 = {}
local bit = {
  data32 = {}
}
do
  do
    for SRD1_5_ = 1, 32 do
      bit.data32[SRD1_5_] = 2 ^ (32 - SRD1_5_)
    end
  end
end
local toby = string.byte
function utf8.charbytes(s, i)
  i = i or 1
  local c = string.byte(s, i)
  if c > 0 and c <= 127 then
    do return 1 end
    return
  end
  if c >= 194 and c <= 223 then
    do return 2 end
    return
  end
  if c >= 224 and c <= 239 then
    do return 3 end
    return
  end
  if c >= 240 and c <= 244 then
    return 4
  end
  return 1
end

local ded
function bit:d2b(arg)
  if arg == nil then
    return
  end
  local tr, c = {}, arg < 0
  if c then
    arg = 0 - arg
  end
  do
    do
      for SRD1_7_ = 1, 32 do
        if arg >= self.data32[SRD1_7_] then
          tr[SRD1_7_] = 1
          arg = arg - self.data32[SRD1_7_]
        else
          tr[SRD1_7_] = 0
        end
      end
    end
  end
  if c then
    tr = self:_bnot(tr)
    tr = self:b2d(tr) + 1
    tr = self:d2b(tr)
  end
  return tr
end

function bit:b2d(arg, neg)
  local nr = 0
  if arg[1] == 1 and neg == true then
    arg = self:_bnot(arg)
    nr = self:b2d(arg) + 1
    nr = 0 - nr
  else
    do
      for SRD1_7_ = 1, 32 do
        if arg[SRD1_7_] == 1 then
          nr = nr + 2 ^ (32 - SRD1_7_)
        end
      end
    end
  end
  return nr
end

function bit:_and(a, b)
  local op1 = self:d2b(a)
  local op2 = self:d2b(b)
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == 1 and op2[SRD1_9_] == 1 then
          r[SRD1_9_] = 1
        else
          r[SRD1_9_] = 0
        end
      end
    end
  end
  return self:b2d(r, true)
end

function bit:_or(a, b)
  local op1 = self:d2b(a)
  local op2 = self:d2b(b)
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == 1 or op2[SRD1_9_] == 1 then
          r[SRD1_9_] = 1
        else
          r[SRD1_9_] = 0
        end
      end
    end
  end
  return self:b2d(r, true)
end

function bit:_xor(a, b)
  local op1 = self:d2b(a)
  if op1 == nil then
    return nil
  end
  local op2 = self:d2b(b)
  if op2 == nil then
    return nil
  end
  local r = {}
  do
    do
      for SRD1_9_ = 1, 32 do
        if op1[SRD1_9_] == op2[SRD1_9_] then
          r[SRD1_9_] = 0
        else
          r[SRD1_9_] = 1
        end
      end
    end
  end
  return self:b2d(r, true)
end

local switch = {
  [1] = function(s, pos)
    local c1 = toby(s, pos)
    return c1
  end
  ,
  [2] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local int1 = bit:_and(31, c1)
    local int2 = bit:_and(63, c2)
    return bit:_or(bit:_lshift(int1, 6), int2)
  end
  ,
  [3] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local c3 = toby(s, pos + 2)
    local int1 = bit:_and(15, c1)
    local int2 = bit:_and(63, c2)
    local int3 = bit:_and(63, c3)
    local o2 = bit:_or(bit:_lshift(int1, 12), bit:_lshift(int2, 6))
    local dt = bit:_or(o2, int3)
    return dt
  end
  ,
  [4] = function(s, pos)
    local c1 = toby(s, pos)
    local c2 = toby(s, pos + 1)
    local c3 = toby(s, pos + 2)
    local c4 = toby(s, pos + 3)
    local int1 = bit:_and(15, c1)
    local int2 = bit:_and(63, c2)
    local int3 = bit:_and(63, c3)
    local int4 = bit:_and(63, c4)
    local o2 = bit:_or(bit:_lshift(int1, 18), bit:_lshift(int2, 12))
    local o3 = bit:_or(o2, bit:_lshift(int3, 6))
    local o4 = bit:_or(o3, int4)
    return o4
  end
  
}
function bit:_bnot(op1)
  local r = {}
  do
    do
      for SRD1_6_ = 1, 32 do
        if op1[SRD1_6_] == 1 then
          r[SRD1_6_] = 0
        else
          r[SRD1_6_] = 1
        end
      end
    end
  end
  return r
end

function bit:_not(a)
  local op1 = self:d2b(a)
  local r = self:_bnot(op1)
  return self:b2d(r, true)
end

function bit:charCodeAt(s)
  local pos, int, H, L = 1, 0, 0, 0
  local slen = string.len(s)
  local allByte = {}
  while pos <= slen do
    local tLen = utf8.charbytes(s, pos)
    if tLen >= 1 and tLen <= 4 then
      if tLen == 4 then
        int = switch[4](s, pos)
        H = math.floor((int - 65536) / 1024) + 55296
        L = (int - 65536) % 1024 + 56320
        table.insert(allByte, H)
        table.insert(allByte, L)
      else
        int = switch[tLen](s, pos)
        table.insert(allByte, int)
      end
    end
    pos = pos + tLen
  end
  return allByte
end

function bit:_rshift(a, n)
  local r = 0
  if a < 0 then
    r = 0 - self:_frshift(0 - a, n)
  elseif a >= 0 then
    r = self:_frshift(a, n)
  end
  return r
end

function bit:_frshift(a, n)
  local op1 = self:d2b(a)
  local r = self:d2b(0)
  local left = 32 - n
  if n < 32 and n > 0 then
    do
      for SRD1_9_ = left, 1, -1 do
        r[SRD1_9_ + n] = op1[SRD1_9_]
      end
    end
  end
  return self:b2d(r)
end

function bit:_lshift(a, n)
  local op1 = self:d2b(a)
  local r = self:d2b(0)
  if n < 32 and n > 0 then
    do
      for SRD1_8_ = n, 31 do
        r[SRD1_8_ - n + 1] = op1[SRD1_8_ + 1]
      end
    end
  end
  return self:b2d(r, true)
end

function trim(s)
  return s:match("^%s*(.*)"):match("(.-)%s*$")
end

local json = {}
local kind_of = function(obj)
  if type(obj) ~= "table" then
    return type(obj)
  end
  local i = 1
  do
    do
      for SRD1_5_ in pairs(obj) do
        if obj[i] ~= nil then
          i = i + 1
        else
          return "table"
        end
      end
    end
  end
  if i == 1 then
    do return "table" end
    return
  end
  return "array"
end

local escape_str = function(s)
  local in_char = {
    "\\",
    "\"",
    "/",
    "\b",
    "\f",
    "\n",
    "\r",
    "\t"
  }
  local out_char = {
    "\\",
    "\"",
    "/",
    "b",
    "f",
    "n",
    "r",
    "t"
  }
  do
    do
      for SRD1_6_, SRD1_7_ in ipairs(in_char) do
        s = s:gsub(SRD1_7_, "\\" .. out_char[SRD1_6_])
      end
    end
  end
  return s
end

local skip_delim = function(str, pos, delim, err_if_missing)
  pos = pos + #str:match("^%s*", pos)
  if str:sub(pos, pos) ~= delim then
    if err_if_missing then
      error("Expected " .. delim .. " close position " .. pos)
    end
    return pos, false
  end
  return pos + 1, true
end

local function parse_str_val(str, pos, val)
  val = val or ""
  local early_end_error = "End of input encountered during string parsing."
  if pos > #str then
    error(early_end_error)
  end
  local c = str:sub(pos, pos)
  if c == "\"" then
    return val, pos + 1
  end
  if c ~= "\\" then
    return parse_str_val(str, pos + 1, val .. c)
  end
  local esc_map = {
    b = "\b",
    f = "\f",
    n = "\n",
    r = "\r",
    t = "\t"
  }
  local nextc = str:sub(pos + 1, pos + 1)
  if not nextc then
    error(early_end_error)
  end
  return parse_str_val(str, pos + 2, val .. (esc_map[nextc] or nextc))
end

local parse_num_val = function(str, pos)
  local num_str = str:match("^-?%d+%.?%d*[eE]?[+-]?%d*", pos)
  local val = tonumber(num_str)
  if not val then
    error("Error parsing number at position " .. pos .. ".")
  end
  return val, pos + #num_str
end

function json.stringify(obj, as_key)
  local s = {}
  local kind = kind_of(obj)
  if kind == "array" then
    if as_key then
      error("Unable to encode array as key.")
    end
    s[#s + 1] = "["
    do
      do
        for SRD1_7_, SRD1_8_ in ipairs(obj) do
          if SRD1_7_ > 1 then
            s[#s + 1] = ", "
          end
          s[#s + 1] = json.stringify(SRD1_8_)
        end
      end
    end
    s[#s + 1] = "]"
  elseif kind == "table" then
    if as_key then
      error("Unable to key encode table.")
    end
    s[#s + 1] = "{"
    do
      do
        for SRD1_7_, SRD1_8_ in pairs(obj) do
          if #s > 1 then
            s[#s + 1] = ", "
          end
          s[#s + 1] = json.stringify(SRD1_7_, true)
          s[#s + 1] = ":"
          s[#s + 1] = json.stringify(SRD1_8_)
        end
      end
    end
    s[#s + 1] = "}"
  else
    if kind == "string" then
      do return "\"" .. escape_str(obj) .. "\"" end
      return
    end
    if kind == "number" then
      if as_key then
        return "\"" .. tostring(obj) .. "\""
      end
      do return tostring(obj) end
      return
    end
    if kind == "boolean" then
      do return tostring(obj) end
      return
    end
    if kind == "nil" then
      do return "null" end
      return
    end
    error("unjsonifiable type,: " .. kind .. ".")
  end
  return table.concat(s)
end

json.null = {}
function json.parse(str, pos, end_delim)
  pos = pos or 1
  if pos > #str then
    error("Reached unexpected end of input ")
  end
  local pos = pos + #str:match("^%s*", pos)
  local first = str:sub(pos, pos)
  if first == "{" then
    do
      local obj, key, delim_found = {}, true, true
      pos = pos + 1
      while true do
        key, pos = json.parse(str, pos, "}")
        if key == nil then
          return obj, pos
        end
        if not delim_found then
          error("Missing comma between object items.")
        end
        pos = skip_delim(str, pos, ":", true)
        obj[key], pos = json.parse(str, pos)
        pos, delim_found = skip_delim(str, pos, ",")
      end
    end
    return
  end
  if first == "[" then
    do
      local arr, val, delim_found = {}, true, true
      pos = pos + 1
      while true do
        val, pos = json.parse(str, pos, "]")
        if val == nil then
          return arr, pos
        end
        if not delim_found then
          error("Missing comma between array items.")
        end
        arr[#arr + 1] = val
        pos, delim_found = skip_delim(str, pos, ",")
      end
    end
    return
  end
  if first == "\"" then
    do return parse_str_val(str, pos + 1) end
    return
  end
  if first == "-" or first:match("%d") then
    do return parse_num_val(str, pos) end
    return
  end
  if first == end_delim then
    do return nil, pos + 1 end
    return
  end
  do
    local literals = {
      ["true"] = true,
      ["false"] = false,
      null = json.null
    }
    do
      do
        for SRD1_9_, SRD1_10_ in pairs(literals) do
          local lit_end = pos + #SRD1_9_ - 1
          if str:sub(pos, lit_end) == SRD1_9_ then
            return SRD1_10_, lit_end + 1
          end
        end
      end
    end
    local pos_info_str = "position " .. pos .. ": " .. str:sub(pos, pos + 10)
    error("Invalid json syntax starting at " .. pos_info_str)
  end
end

function enc(data, b)
  return (data:gsub(".", function(x)
    local r, b = "", x:byte()
    do
      do
        for SRD1_6_ = 8, 1, -1 do
          r = r .. (b % 2 ^ SRD1_6_ - b % 2 ^ (SRD1_6_ - 1) > 0 and "1" or "0")
        end
      end
    end
    return r
  end
  ) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(x)
    if #x < 6 then
      return ""
    end
    local c = 0
    do
      do
        for SRD1_5_ = 1, 6 do
          c = c + (x:sub(SRD1_5_, SRD1_5_) == "1" and 2 ^ (6 - SRD1_5_) or 0)
        end
      end
    end
    return b:sub(c + 1, c + 1)
  end
  ) .. ({
    "",
    "??",
    "?"
  })[#data % 3 + 1]
end

function dec(data, b)
  data = string.gsub(data, "[^" .. b .. "=]", "")
  return (data:gsub(".", function(x)
    if x == "?" then
      return ""
    end
    local r, f = "", b:find(x) - 1
    do
      do
        for SRD1_6_ = 6, 1, -1 do
          r = r .. (f % 2 ^ SRD1_6_ - f % 2 ^ (SRD1_6_ - 1) > 0 and "1" or "0")
        end
      end
    end
    return r
  end
  ):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(x)
    if #x ~= 8 then
      return ""
    end
    local c = 0
    do
      do
        for SRD1_5_ = 1, 8 do
          c = c + (x:sub(SRD1_5_, SRD1_5_) == "1" and 2 ^ (8 - SRD1_5_) or 0)
        end
      end
    end
    return string.char(c)
  end
  ))
end

function rwmem(Address, SizeOrBuffer)
  assert(Address ~= nil, "[rwmem]: error, given address is null.")
  _rw = {}
  if type(SizeOrBuffer) == "number" then
    _ = ""
    do
      do
        for SRD1_5_ = 1, SizeOrBuffer do
          _rw[SRD1_5_] = {
            address = Address - 1 + SRD1_5_,
            flags = gg.TYPE_BYTE
          }
        end
      end
    end
    do
      do
        for SRD1_5_, SRD1_6_ in ipairs(gg.getValues(_rw)) do
          if SRD1_6_.value == 0 and limit == true then
            return _
          end
          _ = _ .. string.format("%02X", SRD1_6_.value & 255)
        end
      end
    end
    return _
  end
  Byte = {}
  SizeOrBuffer:gsub("..", function(x)
    Byte[#Byte + 1] = x
    _rw[#Byte] = {
      address = Address - 1 + #Byte,
      flags = gg.TYPE_BYTE,
      value = x .. "h"
    }
  end
  )
  gg.setValues(_rw)
end

function hexdecode(hex)
  return (hex:gsub("%x%x", function(digits)
    return string.char(tonumber(digits, 16))
  end
  ))
end

function hexencode(str)
  return (str:gsub(".", function(char)
    return string.format("%2x", char:byte())
  end
  ))
end

function Dec2Hex(nValue)
  nHexVal = string.format("%X", nValue)
  sHexVal = nHexVal .. ""
  return sHexVal
end

function ToInteger(number)
  return math.floor(tonumber(number) or error("It was not possible transmitir '" .. tostring(number) .. "' enumerate.'"))
end

function v2ray(data)
  io.open(gg.EXT_STORAGE .. "/v2ray.txt", "w"):write(data)
  gg.toast("I got you Lionel Richie!")
end

function save2(data)
  io.open(gg.EXT_STORAGE .. "/decrypt.txt", "w"):write(json.stringify(data))
  gg.toast("I got you Lionel Richie!")
end

function hc(data)
  io.open(gg.EXT_STORAGE .. "/hc.txt", "w"):write(data)
  gg.toast("I got you Lionel Richie!")
end

function v2json(data)
  io.open(gg.EXT_STORAGE .. "/v2ray.txt", "w"):write(data)
end

  limit = true
  gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_C_DATA)
  gg.setVisible(false)
  gg.searchNumber("h 7B 0A 09 09 22 69 6E 62 6F 75 6E 64", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
  local r = gg.getResults(1)
  if #r < 1 then
    gg.toast("File Not Found ❌: inbounds")
    hc_2 = true
  end
  if hc_2 then 
    gg.searchNumber("h 7B 0A 09 09 22 64 6E 73 22", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: dns")
      hc_3 = true
    end
  end
  if hc_3 then
    gg.searchNumber("h 20 22 64 6e 73 22 3a 20 7b", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: dns t")
      hc_4 = true
    end
  end
  if hc_4 then
    gg.searchNumber("h 7B 0A 09 09 09 09 09 09 09 09 09 09 09 09 22 61 64 64 72 65 73 73 22 3A", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    local r = gg.getResults(1)
    if #r < 1 then
      gg.toast("File Not Found ❌: address")
      hc_5 = true
    end
  end
  
  if hc_5 then
    gg.toast("File Not Found ❌")
    print("edit your search, use new keywords or reload the application and configuration again\n")
    os.exit()
  end
  local r = gg.getResults(1000)
  if limit == false then
    r[1].address = r[1].address - 0x400
  end
  readedMem = rwmem(r[1].address, 50000)
  v2ray(hexdecode(readedMem))
  gg.toast("File Found ✓")
  print("I got you Lionel Richie!\n\nThe file is at: /sdcard/v2ray.txt")
  gg.clearResults()
os.exit()
pcall(load(V2Ray))
prima()
end

function Dump()

function rwmem2(Address, SizeOrBuffer)
assert(Address ~= nil, "[rwmem]: error, given address is null.")
_rw = {}
if type(SizeOrBuffer) == "number" then
_ = ""
for _ = 1, SizeOrBuffer do _rw[_] = {address = (Address - 1) + _, flags = gg.TYPE_BYTE} end
for v, __ in ipairs(gg.getValues(_rw)) do
 if __.value == 00 then  
end
_ = _ .. string.format("%02X", __.value & 0xFF)
end
return _
end
Byte = {} SizeOrBuffer:gsub("..", function(x)
Byte[#Byte + 1] = x _rw[#Byte] = {address = (Address - 1) + #Byte, flags = gg.TYPE_BYTE, value = x .. "h"}
end)
gg.setValues(_rw)
end
local function hexdecode2(hex)
return (hex:gsub("%x%x", function(digits) return string.char(tonumber(digits, 16)) end))
end
local function hexencode2(str)
return (str:gsub(".", function(char) return string.format("%2x", char:byte()) end))
end
function Dec2Hex2(nValue)
nHexVal = string.format("%X", nValue);
sHexVal = nHexVal.."";
return sHexVal;
end
function ToInteger2(number)
return math.floor(tonumber(number) or error("It was not possible transmitir '" .. tostring(number) .. "' enumerate.'"))
end
gg.clearResults()
options = gg.prompt({ "Paste the address here below:" }, {[1]=""}, {[1]='text'})

gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_JAVA_HEAP | gg.REGION_ANONYMOUS | gg.REGION_JAVA | gg.REGION_C_HEAP | gg.REGION_PPSSPP | gg.REGION_C_DATA | gg.REGION_C_BSS | gg.REGION_STACK | gg.REGION_ASHMEM | gg.REGION_BAD | gg.REGION_OTHER)
readedMem2 = rwmem2("0x" .. options[1], 70000)
io.open(gg.EXT_STORAGE .. "/x9.txt", "w"):write(hexdecode2(readedMem2))
gg.toast("File Found ✓")
  print("✓ I got you Lionel Richie!\n\nThe file is at: /sdcard/x9.txt")
reconnect()
x9B()
prima()
end

function EXIT()

gg.clearResults()
t = gg.getListItems()
gg.removeListItems(t)
gg.toast("are you feeling the energy?⚡")
os.exit()
end

function x9P()
gg.toast("👻 Calm down, bitch 🦋")
end

function reconnect()
x9B()
end

function prima()
end

if x9A == 1 then x9B() end
end
end
if x9ok == 1 then x9on() end