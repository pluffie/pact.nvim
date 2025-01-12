local _local_2_
do
  local _1_
  local function _3_(...)
    local full_mod_path_2_auto = ...
    local _4_ = full_mod_path_2_auto
    local function _5_(...)
      local path_3_auto = _4_
      return ("string" == type(path_3_auto))
    end
    if ((nil ~= _4_) and _5_(...)) then
      local path_3_auto = _4_
      if string.find(full_mod_path_2_auto, "math") then
        local _6_ = string.match(full_mod_path_2_auto, ("(.+%.)" .. "math"))
        if (_6_ == nil) then
          return ""
        elseif (nil ~= _6_) then
          local root_4_auto = _6_
          return root_4_auto
        else
          return nil
        end
      else
        return error(string.format("relative-root: no match in &from %q for %q", full_mod_path_2_auto, "math"))
      end
    elseif (_4_ == nil) then
      return ""
    else
      return nil
    end
  end
  _1_ = require(((_3_(...) or "") .. "type"))
  _local_2_ = _1_
end
local _local_10_ = _local_2_
local number_3f = _local_10_["number?"]
do local _ = {nil, nil} end
local __fn_2a_add_dispatch = {bodies = {}, help = {}}
local add
local function _16_(...)
  if (0 == #(__fn_2a_add_dispatch).bodies) then
    error(("multi-arity function " .. "add" .. " has no bodies"))
  else
  end
  local _18_
  do
    local f_74_auto = nil
    for __75_auto, match_3f_76_auto in ipairs((__fn_2a_add_dispatch).bodies) do
      if f_74_auto then break end
      f_74_auto = match_3f_76_auto(...)
    end
    _18_ = f_74_auto
  end
  if (nil ~= _18_) then
    local f_74_auto = _18_
    return f_74_auto(...)
  elseif (_18_ == nil) then
    local view_77_auto
    do
      local _19_, _20_ = pcall(require, "fennel")
      if ((_19_ == true) and ((_G.type(_20_) == "table") and (nil ~= (_20_).view))) then
        local view_77_auto0 = (_20_).view
        view_77_auto = view_77_auto0
      elseif ((_19_ == false) and true) then
        local __75_auto = _20_
        view_77_auto = (_G.vim.inspect or print)
      else
        view_77_auto = nil
      end
    end
    local msg_78_auto = string.format(("Multi-arity function %s had no matching head " .. "or default defined.\nCalled with: %s\nHeads:\n%s"), "add", view_77_auto({...}), table.concat((__fn_2a_add_dispatch).help, "\n"))
    return error(msg_78_auto)
  else
    return nil
  end
end
add = _16_
local function _23_()
  local _24_
  do
    table.insert((__fn_2a_add_dispatch).help, "(where [a b] (and (number? a) (number? b)))")
    local function _25_(...)
      if (2 == select("#", ...)) then
        local _26_ = {...}
        local function _27_(...)
          local a_11_ = (_26_)[1]
          local b_12_ = (_26_)[2]
          return (number_3f(a_11_) and number_3f(b_12_))
        end
        if (((_G.type(_26_) == "table") and (nil ~= (_26_)[1]) and (nil ~= (_26_)[2])) and _27_(...)) then
          local a_11_ = (_26_)[1]
          local b_12_ = (_26_)[2]
          local function _28_(a, b)
            return (a + b)
          end
          return _28_
        else
          return nil
        end
      else
        return nil
      end
    end
    table.insert((__fn_2a_add_dispatch).bodies, _25_)
    _24_ = add
  end
  local function _31_()
    table.insert((__fn_2a_add_dispatch).help, "(where [a b c ...] (and (number? a) (number? b) (number? c)))")
    local function _32_(...)
      if (3 <= select("#", ...)) then
        local _33_ = {...}
        local function _34_(...)
          local a_13_ = (_33_)[1]
          local b_14_ = (_33_)[2]
          local c_15_ = (_33_)[3]
          return (number_3f(a_13_) and number_3f(b_14_) and number_3f(c_15_))
        end
        if (((_G.type(_33_) == "table") and (nil ~= (_33_)[1]) and (nil ~= (_33_)[2]) and (nil ~= (_33_)[3])) and _34_(...)) then
          local a_13_ = (_33_)[1]
          local b_14_ = (_33_)[2]
          local c_15_ = (_33_)[3]
          local function _35_(a, b, c, ...)
            return add(add(a, b), c, ...)
          end
          return _35_
        else
          return nil
        end
      else
        return nil
      end
    end
    table.insert((__fn_2a_add_dispatch).bodies, _32_)
    return add
  end
  do local _ = {_24_, _31_()} end
  return add
end
setmetatable({nil, nil}, {__call = _23_})()
local __fn_2a_sub_dispatch = {bodies = {}, help = {}}
local sub
local function _43_(...)
  if (0 == #(__fn_2a_sub_dispatch).bodies) then
    error(("multi-arity function " .. "sub" .. " has no bodies"))
  else
  end
  local _45_
  do
    local f_74_auto = nil
    for __75_auto, match_3f_76_auto in ipairs((__fn_2a_sub_dispatch).bodies) do
      if f_74_auto then break end
      f_74_auto = match_3f_76_auto(...)
    end
    _45_ = f_74_auto
  end
  if (nil ~= _45_) then
    local f_74_auto = _45_
    return f_74_auto(...)
  elseif (_45_ == nil) then
    local view_77_auto
    do
      local _46_, _47_ = pcall(require, "fennel")
      if ((_46_ == true) and ((_G.type(_47_) == "table") and (nil ~= (_47_).view))) then
        local view_77_auto0 = (_47_).view
        view_77_auto = view_77_auto0
      elseif ((_46_ == false) and true) then
        local __75_auto = _47_
        view_77_auto = (_G.vim.inspect or print)
      else
        view_77_auto = nil
      end
    end
    local msg_78_auto = string.format(("Multi-arity function %s had no matching head " .. "or default defined.\nCalled with: %s\nHeads:\n%s"), "sub", view_77_auto({...}), table.concat((__fn_2a_sub_dispatch).help, "\n"))
    return error(msg_78_auto)
  else
    return nil
  end
end
sub = _43_
local function _50_()
  local _51_
  do
    table.insert((__fn_2a_sub_dispatch).help, "(where [a b] (and (number? a) (number? b)))")
    local function _52_(...)
      if (2 == select("#", ...)) then
        local _53_ = {...}
        local function _54_(...)
          local a_38_ = (_53_)[1]
          local b_39_ = (_53_)[2]
          return (number_3f(a_38_) and number_3f(b_39_))
        end
        if (((_G.type(_53_) == "table") and (nil ~= (_53_)[1]) and (nil ~= (_53_)[2])) and _54_(...)) then
          local a_38_ = (_53_)[1]
          local b_39_ = (_53_)[2]
          local function _55_(a, b)
            return (a - b)
          end
          return _55_
        else
          return nil
        end
      else
        return nil
      end
    end
    table.insert((__fn_2a_sub_dispatch).bodies, _52_)
    _51_ = sub
  end
  local function _58_()
    table.insert((__fn_2a_sub_dispatch).help, "(where [a b c ...] (and (number? a) (number? b) (number? c)))")
    local function _59_(...)
      if (3 <= select("#", ...)) then
        local _60_ = {...}
        local function _61_(...)
          local a_40_ = (_60_)[1]
          local b_41_ = (_60_)[2]
          local c_42_ = (_60_)[3]
          return (number_3f(a_40_) and number_3f(b_41_) and number_3f(c_42_))
        end
        if (((_G.type(_60_) == "table") and (nil ~= (_60_)[1]) and (nil ~= (_60_)[2]) and (nil ~= (_60_)[3])) and _61_(...)) then
          local a_40_ = (_60_)[1]
          local b_41_ = (_60_)[2]
          local c_42_ = (_60_)[3]
          local function _62_(a, b, c, ...)
            return sub(sub(a, b), c, ...)
          end
          return _62_
        else
          return nil
        end
      else
        return nil
      end
    end
    table.insert((__fn_2a_sub_dispatch).bodies, _59_)
    return sub
  end
  do local _ = {_51_, _58_()} end
  return sub
end
setmetatable({nil, nil}, {__call = _50_})()
local __fn_2a_mul_dispatch = {bodies = {}, help = {}}
local mul
local function _70_(...)
  if (0 == #(__fn_2a_mul_dispatch).bodies) then
    error(("multi-arity function " .. "mul" .. " has no bodies"))
  else
  end
  local _72_
  do
    local f_74_auto = nil
    for __75_auto, match_3f_76_auto in ipairs((__fn_2a_mul_dispatch).bodies) do
      if f_74_auto then break end
      f_74_auto = match_3f_76_auto(...)
    end
    _72_ = f_74_auto
  end
  if (nil ~= _72_) then
    local f_74_auto = _72_
    return f_74_auto(...)
  elseif (_72_ == nil) then
    local view_77_auto
    do
      local _73_, _74_ = pcall(require, "fennel")
      if ((_73_ == true) and ((_G.type(_74_) == "table") and (nil ~= (_74_).view))) then
        local view_77_auto0 = (_74_).view
        view_77_auto = view_77_auto0
      elseif ((_73_ == false) and true) then
        local __75_auto = _74_
        view_77_auto = (_G.vim.inspect or print)
      else
        view_77_auto = nil
      end
    end
    local msg_78_auto = string.format(("Multi-arity function %s had no matching head " .. "or default defined.\nCalled with: %s\nHeads:\n%s"), "mul", view_77_auto({...}), table.concat((__fn_2a_mul_dispatch).help, "\n"))
    return error(msg_78_auto)
  else
    return nil
  end
end
mul = _70_
local function _77_()
  local _78_
  do
    table.insert((__fn_2a_mul_dispatch).help, "(where [a b] (and (number? a) (number? b)))")
    local function _79_(...)
      if (2 == select("#", ...)) then
        local _80_ = {...}
        local function _81_(...)
          local a_65_ = (_80_)[1]
          local b_66_ = (_80_)[2]
          return (number_3f(a_65_) and number_3f(b_66_))
        end
        if (((_G.type(_80_) == "table") and (nil ~= (_80_)[1]) and (nil ~= (_80_)[2])) and _81_(...)) then
          local a_65_ = (_80_)[1]
          local b_66_ = (_80_)[2]
          local function _82_(a, b)
            return (a * b)
          end
          return _82_
        else
          return nil
        end
      else
        return nil
      end
    end
    table.insert((__fn_2a_mul_dispatch).bodies, _79_)
    _78_ = mul
  end
  local function _85_()
    table.insert((__fn_2a_mul_dispatch).help, "(where [a b c ...] (and (number? a) (number? b) (number? c)))")
    local function _86_(...)
      if (3 <= select("#", ...)) then
        local _87_ = {...}
        local function _88_(...)
          local a_67_ = (_87_)[1]
          local b_68_ = (_87_)[2]
          local c_69_ = (_87_)[3]
          return (number_3f(a_67_) and number_3f(b_68_) and number_3f(c_69_))
        end
        if (((_G.type(_87_) == "table") and (nil ~= (_87_)[1]) and (nil ~= (_87_)[2]) and (nil ~= (_87_)[3])) and _88_(...)) then
          local a_67_ = (_87_)[1]
          local b_68_ = (_87_)[2]
          local c_69_ = (_87_)[3]
          local function _89_(a, b, c, ...)
            return mul(mul(a, b), c, ...)
          end
          return _89_
        else
          return nil
        end
      else
        return nil
      end
    end
    table.insert((__fn_2a_mul_dispatch).bodies, _86_)
    return mul
  end
  do local _ = {_78_, _85_()} end
  return mul
end
setmetatable({nil, nil}, {__call = _77_})()
local __fn_2a_div_dispatch = {bodies = {}, help = {}}
local div
local function _97_(...)
  if (0 == #(__fn_2a_div_dispatch).bodies) then
    error(("multi-arity function " .. "div" .. " has no bodies"))
  else
  end
  local _99_
  do
    local f_74_auto = nil
    for __75_auto, match_3f_76_auto in ipairs((__fn_2a_div_dispatch).bodies) do
      if f_74_auto then break end
      f_74_auto = match_3f_76_auto(...)
    end
    _99_ = f_74_auto
  end
  if (nil ~= _99_) then
    local f_74_auto = _99_
    return f_74_auto(...)
  elseif (_99_ == nil) then
    local view_77_auto
    do
      local _100_, _101_ = pcall(require, "fennel")
      if ((_100_ == true) and ((_G.type(_101_) == "table") and (nil ~= (_101_).view))) then
        local view_77_auto0 = (_101_).view
        view_77_auto = view_77_auto0
      elseif ((_100_ == false) and true) then
        local __75_auto = _101_
        view_77_auto = (_G.vim.inspect or print)
      else
        view_77_auto = nil
      end
    end
    local msg_78_auto = string.format(("Multi-arity function %s had no matching head " .. "or default defined.\nCalled with: %s\nHeads:\n%s"), "div", view_77_auto({...}), table.concat((__fn_2a_div_dispatch).help, "\n"))
    return error(msg_78_auto)
  else
    return nil
  end
end
div = _97_
local function _104_()
  local _105_
  do
    table.insert((__fn_2a_div_dispatch).help, "(where [a b] (and (number? a) (number? b)))")
    local function _106_(...)
      if (2 == select("#", ...)) then
        local _107_ = {...}
        local function _108_(...)
          local a_92_ = (_107_)[1]
          local b_93_ = (_107_)[2]
          return (number_3f(a_92_) and number_3f(b_93_))
        end
        if (((_G.type(_107_) == "table") and (nil ~= (_107_)[1]) and (nil ~= (_107_)[2])) and _108_(...)) then
          local a_92_ = (_107_)[1]
          local b_93_ = (_107_)[2]
          local function _109_(a, b)
            return (a / b)
          end
          return _109_
        else
          return nil
        end
      else
        return nil
      end
    end
    table.insert((__fn_2a_div_dispatch).bodies, _106_)
    _105_ = div
  end
  local function _112_()
    table.insert((__fn_2a_div_dispatch).help, "(where [a b c ...] (and (number? a) (number? b) (number? c)))")
    local function _113_(...)
      if (3 <= select("#", ...)) then
        local _114_ = {...}
        local function _115_(...)
          local a_94_ = (_114_)[1]
          local b_95_ = (_114_)[2]
          local c_96_ = (_114_)[3]
          return (number_3f(a_94_) and number_3f(b_95_) and number_3f(c_96_))
        end
        if (((_G.type(_114_) == "table") and (nil ~= (_114_)[1]) and (nil ~= (_114_)[2]) and (nil ~= (_114_)[3])) and _115_(...)) then
          local a_94_ = (_114_)[1]
          local b_95_ = (_114_)[2]
          local c_96_ = (_114_)[3]
          local function _116_(a, b, c, ...)
            return div(div(a, b), c, ...)
          end
          return _116_
        else
          return nil
        end
      else
        return nil
      end
    end
    table.insert((__fn_2a_div_dispatch).bodies, _113_)
    return div
  end
  do local _ = {_105_, _112_()} end
  return div
end
setmetatable({nil, nil}, {__call = _104_})()
local function inc(x)
  return (x + 1)
end
local function dec(x)
  return (x - 1)
end
local __fn_2a_rem_dispatch = {bodies = {}, help = {}}
local rem
local function _122_(...)
  if (0 == #(__fn_2a_rem_dispatch).bodies) then
    error(("multi-arity function " .. "rem" .. " has no bodies"))
  else
  end
  local _124_
  do
    local f_74_auto = nil
    for __75_auto, match_3f_76_auto in ipairs((__fn_2a_rem_dispatch).bodies) do
      if f_74_auto then break end
      f_74_auto = match_3f_76_auto(...)
    end
    _124_ = f_74_auto
  end
  if (nil ~= _124_) then
    local f_74_auto = _124_
    return f_74_auto(...)
  elseif (_124_ == nil) then
    local view_77_auto
    do
      local _125_, _126_ = pcall(require, "fennel")
      if ((_125_ == true) and ((_G.type(_126_) == "table") and (nil ~= (_126_).view))) then
        local view_77_auto0 = (_126_).view
        view_77_auto = view_77_auto0
      elseif ((_125_ == false) and true) then
        local __75_auto = _126_
        view_77_auto = (_G.vim.inspect or print)
      else
        view_77_auto = nil
      end
    end
    local msg_78_auto = string.format(("Multi-arity function %s had no matching head " .. "or default defined.\nCalled with: %s\nHeads:\n%s"), "rem", view_77_auto({...}), table.concat((__fn_2a_rem_dispatch).help, "\n"))
    return error(msg_78_auto)
  else
    return nil
  end
end
rem = _122_
local function _129_()
  local _130_
  do
    table.insert((__fn_2a_rem_dispatch).help, "(where [x 0])")
    local function _131_(...)
      if (2 == select("#", ...)) then
        local _132_ = {...}
        local function _133_(...)
          local x_119_ = (_132_)[1]
          return true
        end
        if (((_G.type(_132_) == "table") and (nil ~= (_132_)[1]) and ((_132_)[2] == 0)) and _133_(...)) then
          local x_119_ = (_132_)[1]
          local function _134_(x, _)
            return x
          end
          return _134_
        else
          return nil
        end
      else
        return nil
      end
    end
    table.insert((__fn_2a_rem_dispatch).bodies, _131_)
    _130_ = rem
  end
  local function _137_()
    table.insert((__fn_2a_rem_dispatch).help, "(where [x n])")
    local function _138_(...)
      if (2 == select("#", ...)) then
        local _139_ = {...}
        local function _140_(...)
          local x_120_ = (_139_)[1]
          local n_121_ = (_139_)[2]
          return true
        end
        if (((_G.type(_139_) == "table") and (nil ~= (_139_)[1]) and (nil ~= (_139_)[2])) and _140_(...)) then
          local x_120_ = (_139_)[1]
          local n_121_ = (_139_)[2]
          local function _141_(x, n)
            return (x % n)
          end
          return _141_
        else
          return nil
        end
      else
        return nil
      end
    end
    table.insert((__fn_2a_rem_dispatch).bodies, _138_)
    return rem
  end
  do local _ = {_130_, _137_()} end
  return rem
end
setmetatable({nil, nil}, {__call = _129_})()
local function even_3f(x)
  return (0 == rem(x, 2))
end
local function odd_3f(x)
  return (1 == rem(x, 2))
end
local function divides_into_3f(x, n)
  return (0 == (x % n))
end
return {inc = inc, dec = dec, add = add, sub = sub, mul = mul, div = div, rem = rem, ["odd?"] = odd_3f, ["even?"] = even_3f, ["divides-into?"] = divides_into_3f}