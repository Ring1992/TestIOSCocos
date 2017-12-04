--[[local moduleName = ...

local M = {}    -- 局部的变量
_G[moduleName] = M     -- 将这个局部变量最终赋值给模块名

package.loaded[moduleName] = M

setmetatable(M, {__index = _G})
--setfenv(1, M)]]
module("tools")
--string转table
function stringToTable(str)  
   local ret = loadstring("return "..str)
   return ret  
end 

--打印table
function printTable( ... )
    local tv = "\n"
    local xn = 0
    local function tvlinet(xn)
        -- body
        for i=1,xn do
            tv = tv.."\t"
        end
    end

    local function printTab(i,v)
        -- body
        if type(v) == "table" then
            tvlinet(xn)
            xn = xn + 1
            tv = tv..""..i..":{\n"
            table.foreach(v,printTab)
            tvlinet(xn)
            tv = tv.."}\n"
            xn = xn - 1
        elseif type(v) == nil then
            tvlinet(xn)
            tv = tv..i..":nil\n"
        else
            tvlinet(xn)
            tv = tv..i..":"..tostring(v).."\n" 
        end
    end

    local function dumpParam(tab)
        for i=1, #tab do  
            if tab[i] == nil then 
                tv = tv.."nil\t"
            elseif type(tab[i]) == "table" then 
                xn = xn + 1
                tv = tv.."\ntable{\n"
                table.foreach(tab[i],printTab)
                tv = tv.."\t}\n"
            else
                tv = tv..tostring(tab[i]).."\t"
            end
        end
    end

    local x = ...
    if type(x) == "table" then
        table.foreach(x,printTab)
    else
        dumpParam({...})
        -- table.foreach({...},printTab)
    end
    print(tv)
end

--table元素乱序
function shuffleTable(tab)
    local len = #tab
    for i=1,len do
        local k1 = math.ceil(math.random(1,len))
        local k2 = math.ceil(math.random(1,len))
        local temp = tab[k1]
        local tv1 = tab[k1]
        local tv2 = tab[k2]
        tab[k1] = tv2
        tab[k2] = temp
    end
    return tab
end

--table拷贝
function tableCopy(ori_tab)
    if (type(ori_tab) ~= "table") then
        return nil;
    end
    local new_tab = {};
    for i,v in pairs(ori_tab) do
        local vtyp = type(v);
        if (vtyp == "table") then
            new_tab[i] = th_table_dup(v);
        elseif (vtyp == "thread") then
            -- TODO: dup or just point to?
            new_tab[i] = v;
        elseif (vtyp == "userdata") then
            -- TODO: dup or just point to?
            new_tab[i] = v;
        else
            new_tab[i] = v;
        end
    end
    return new_tab;
end

--table深拷贝
function tableDeepCopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

--获取未来几天或过去几天的系统时间(future_days是未来几天或过去几天的天数)
function getTimeOfFutureDays(future_days)  

    local cur_timestamp = os.time()
    local one_hour_timestamp = 24*60*60
    local temp_time = cur_timestamp + one_hour_timestamp * future_days
    local temp_date = os.date("*t", temp_time)
    local future_time = os.time({year=temp_date.year, month=temp_date.month, day=temp_date.day, hour=temp_date.hour, min=temp_date.sec, sec=temp_date.sec})

    return os.date("%Y-%m-%d %H:%M:%S", future_time) 
end


function isEmptyTable(t_data)         --判断表是否为空，空为false,不空为true
         local isEmpty = true

         if(type(t_data)~="table")then        --不是table表
                isEmpty= false
         else
                local length = 0
                for k,v  in pairs(t_data) do
                        length = length + 1
                        break
                end                

                if (length==0) then           --table为空
                    isEmpty = false
                end
         end
         
         return isEmpty       
end

function showLoad(self)
    local self = self or Scene.getCurScene()
    if self.loading then return end
    self.loading = LoadingDialog.create(self.sceneLayer)
end

function closeLoad(self)
    local self = self or Scene.getCurScene()
    if self.loading then self.loading:remove() self.loading=nil end
end



