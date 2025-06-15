--------------------- app.lua ---------------------
if LUA_FOLDER == nil then
    LUA_FOLDER = "lua/"
end
--------------------- config.lua ---------------------
WINDOW_WIDTH    = 393   
WINDOW_HEIGHT   = 852
SCREEN_WIDTH    = WINDOW_WIDTH
SCREEN_HEIGHT   = WINDOW_HEIGHT
WINDOW_X        = 32
WINDOW_Y        = 32
TITLE           = "Prime Time"
--------------------- sound.lua ---------------------
if SFX_DIR == nil then
    SFX_DIR = "sfx/"
end
BASE_DIR = SFX_DIR
MAX_VOLUME  = 50
MUTE        = true


local plus = {
    i = 0, offset=0,
    data = {
        BASE_DIR.."1.wav",
        BASE_DIR.."2.wav",
        BASE_DIR.."3.wav",
        BASE_DIR.."4.wav",
        BASE_DIR.."5.wav",
        BASE_DIR.."6.wav",
        BASE_DIR.."7.wav",
        BASE_DIR.."8.wav",
        BASE_DIR.."9.wav",
        BASE_DIR.."10.wav",
        BASE_DIR.."11.wav",
        BASE_DIR.."12.wav",
        BASE_DIR.."13.wav",
        BASE_DIR.."14.wav",
        BASE_DIR.."15.wav",
        BASE_DIR.."16.wav",
        BASE_DIR.."17.wav",
        BASE_DIR.."18.wav",
        BASE_DIR.."19.wav",
        BASE_DIR.."20.wav",
        BASE_DIR.."21.wav",
        BASE_DIR.."22.wav"
    }
}

local move = {
    i = 0, offset=0,
    data = {
        BASE_DIR.."move1.wav",
        BASE_DIR.."move2.wav",
        BASE_DIR.."move3.wav",
        BASE_DIR.."move4.wav",
        BASE_DIR.."move6.wav",
        BASE_DIR.."move7.wav",
        BASE_DIR.."move8.wav",
        BASE_DIR.."move9.wav",
        BASE_DIR.."move10.wav",
        BASE_DIR.."move11.wav",
        BASE_DIR.."move12.wav",
        BASE_DIR.."move13.wav",
        BASE_DIR.."move14.wav"
    }
}

local swap = {
    i = 0, offset=0,
    data = {
        BASE_DIR.."swap1.wav",
        BASE_DIR.."swap2.wav",
        BASE_DIR.."swap3.wav",
        BASE_DIR.."swap4.wav",
        BASE_DIR.."swap6.wav",
        BASE_DIR.."swap7.wav",
        BASE_DIR.."swap8.wav",
        BASE_DIR.."swap9.wav",
        BASE_DIR.."swap10.wav"        
    }
}

local minus = {
    i = 0, offset=0,
    data = {
        BASE_DIR.."error2_1.wav",    
        BASE_DIR.."error2_2.wav",      
        BASE_DIR.."error2_3.wav",      
        BASE_DIR.."error2_4.wav"      
    }
}

local hint = {
    i = 0, offset=0,
    data = {
        BASE_DIR.."hint1.wav"      
    }
}

local level_up = {
    i = 0, offset=0,
    data = {
        BASE_DIR.."chord1_1.wav",      
        BASE_DIR.."chord2_1.wav",     
        BASE_DIR.."chord1_2.wav",      
        BASE_DIR.."chord2_2.wav"      
    }
}

local wrong_swap = {
    i = 0, offset=0,
    data = {
        BASE_DIR.."error1_1.wav",      
        BASE_DIR.."error1_2.wav",      
        BASE_DIR.."error1_3.wav",      
        BASE_DIR.."error1_4.wav",      
        BASE_DIR.."error1_5.wav",      
        BASE_DIR.."error1_6.wav",      
        BASE_DIR.."error1_7.wav",      
        BASE_DIR.."error1_8.wav"      
    }
}

function Sound_load()
    local i = 0
    plus.offset = i
    for k, p in pairs(plus.data) do
        sound_load_sample(i, p)
        i = i + 1
    end

    wrong_swap.offset = i
    for k, p in pairs(wrong_swap.data) do
        sound_load_sample(i, p)
        i = i + 1
    end

    move.offset = i
    for k, p in pairs(move.data) do
        sound_load_sample(i, p)
        i = i + 1
    end

    hint.offset = i
    for k, p in pairs(hint.data) do
        sound_load_sample(i, p)
        i = i + 1
    end

    level_up.offset = i
    for k, p in pairs(level_up.data) do
        sound_load_sample(i, p)
        i = i + 1
    end

    minus.offset = i
    for k, p in pairs(minus.data) do
        sound_load_sample(i, p)
        i = i + 1
    end

    swap.offset = i
    for k, p in pairs(swap.data) do
        sound_load_sample(i, p)
        i = i + 1
    end

    sound_sample_volume(MAX_VOLUME)
end

local function play_sound(s)
    if MUTE == false then
        sound_play_sample(s.offset + s.i)
        s.i = s.i + 1
        if s.i >= #(s.data) then s.i = 0 end
    end
end

function Sound_toggle()
    if MUTE == true then
        Sound_signal()
        MUTE = false
    else
        MUTE = true
    end
end

function Sound_plus(reset)
    if not (reset == nil) then
        plus.i = 0
    else
        play_sound(plus)
        if plus.i == 0 then
            plus.i = #(plus.data)-1
        end
    end
end

function Sound_move(reset)
    if not (reset == nil) then
        move.i = 0
    else
        play_sound(move)
        if move.i == 0 then
            move.i = #(move.data)-1
        end
    end
end

function Sound_minus()    
    play_sound(minus)       
end


function Sound_level_up()    
    play_sound(level_up)       
end

function Sound_hint()    
    play_sound(hint)       
end

function Sound_wrong_swap()    
    play_sound(wrong_swap)       
end

function Sound_swap()    
    play_sound(swap)       
end
--------------------- subscription.lua ---------------------
Subscription = { 
     
    type = {
        NO_MORE_MOVES = 1,
        --MORE_MOVES = 2,
        SELECT = 3,
        SCORE = 4,
        LEVEL_UP = 5,
        LEVEL_BROKEN = 11,
        SWAP = 6,
        GAME_OVER = 7,
        WRONG_SWAP = 8,
        DONE_LOADING = 9,
        LOADING_CONTINUES = 10,
        NUMBER_DAMAGED = 12,
    },

    is_subscribed = function(self, s)
       local result = false
       for k,v in pairs(self.subscribers) do
            if v == s then
                result = true
                break
            end
        end 
        return result
    end, 
    
    remove = function(self, s) 
       local i = 0     
       for k,v in pairs(self.subscribers) do
            i = i +1
            if v == s then
                table.remove(self.subscribers, i)
                break
            end
        end 
    end, 

    add = function(self, s)
        if (self:is_subscribed(s) == false) and not(s == self) then
            table.insert(self.subscribers, s)
        end
    end,

    notify = function(self, type, e, debug_text)
        if type == nil then
            print("Subscription error: no type")
            do return end
        end
        print("Subscription info: Got notification ")
        if not(debug_text == nil) then
            print(debug_text)
        end
        if type ==  self.type.NO_MORE_MOVES then
            print("\t\"NO MORE MOVES\"")
        elseif type ==  self.type.NUMBER_DAMAGED then
            print("\t\"NUMBER DAMAGED\"")
        elseif type ==  self.type.SCORE then
            print("\t\"SCORE\"")
         elseif type ==  self.type.SELECT then
            print("\t\"SELECT\"")
         elseif type ==  self.type.LEVEL_UP then
            print("\t\"LEVEL UP\"")
         elseif type ==  self.type.LEVEL_BROKEN then
            print("\t\"LEVEL BROKEN\"")
         elseif type ==  self.type.SWAP then
            print("\t\"SWAP\"")
         elseif type ==  self.type.GAME_OVER then
            print("\t\"GAME OVER\"")
         elseif type ==  self.type.WRONG_SWAP then
            print("\t\"WRONG SWAP\"")
         elseif type ==  self.type.DONE_LOADING then
            print("\t\"DONE LOADING\"")
         elseif type ==  self.type.LOADING_CONTINUES then
            print("\t\"LOADING CONTINUES\"")
        end
      
        for k, v in pairs(self.subscribers) do
            if not(v.notify == nil) then
                local t = "unknown"
                if not (v.type == nil) then
                    t = v.type
                end
                print("\t" .. t .. " ("..tostring(v) .. ") notified")
                if not (e == nil) then
                    print("\t\te = " .. tostring(e))
                end
                v:notify(type, e)
            end
        end
    end,
    
    init = function(self)          
        self.subscribers = {}  
        --print(self.type.SCORE)     
    end,

    new = function(self, o)
        local o = o or {}
        setmetatable(o, self)
        self.__index = self
        self:init()
        return o
    end
}
--------------------- game.lua ---------------------
if LUA_FOLDER == nil then
    LUA_FOLDER = "lua/"
end
--------------------- camera.lua ---------------------
Camera = {
    get_x       = function(self, x)        
        return self.zoom * (x + self.x) + self.pan_x
    end,

    get_y       = function(self, y)
        return self.zoom * (y + self.y) + self.pan_y
    end,

    reverse_x   = function(self, x)        
        return ((x  - self.pan_x) / self.zoom) - self.x
    end,

    reverse_y       = function(self, y)
        return  ((y - self.pan_y) / self.zoom) - self.y
    end,

    get_width   = function(self, w)
        return self.zoom * w
    end,

    get_height  = function(self, h)
        return self.zoom * h
    end,

    set_focus       = function(self, object)
        self.focus = object
        self.center_x = ((self.width / 2) + self.scene.x) / self.zoom
        self.center_y = ((self.height / 2) + self.scene.y)/ self.zoom        
    end,

    set_zoom        = function(self, z)        
        self.x = self.x + (self.target_zoom - z)
        self.y = self.y + (self.target_zoom - z)
        self.target_zoom = z 
        self.center_x = ((self.width / 2) + self.scene.x) / self.zoom
        self.center_y = ((self.height / 2) + self.scene.y) / self.zoom         
    end,

    set_scene        = function(self, scene)        
        self.scene = scene   
    end,

    run       = function(self)    
        if self.scene.width < self.width then 
            self.target_x = (self.width - self.scene.width)/2
            self.x = self.target_x
        else
            -- local z = (self.zoom - self.target_zoom) / 32      
            -- self.zoom = self.zoom - z

            -- self.center_x = ((self.width / 2) + self.scene.x) / self.zoom
            -- self.center_y = ((self.height / 2) + self.scene.y) / self.zoom  

            self.target_x = self.center_x - self.focus.x
            --print(self.target_x)
    
            --stop scrolling x at border
            if self.target_x <  - (self.scene.width * self.zoom - self.width) then
                self.target_x =   -(self.scene.width * self.zoom - self.width)
            elseif self.target_x > self.scene.x then
                self.target_x = self.scene.x
            end     
            
            local pan_x = self.x - self.target_x
            local x = pan_x / 4
            if (x > - 0.125) and (x < 0.125) then
                x = 0
            end
            self.x = self.x - x 
        end
            
        if self.scene.height < self.height then            
            self.target_y = (self.height - self.scene.height)/2
            self.y = self.target_y       
        else
            
            self.target_y = self.center_y - self.focus.y
    
            --stop scrolling y at border
            if self.target_y <  - (self.scene.height * self.zoom - self.height) then
                self.target_y =   -(self.scene.height * self.zoom - self.height)
            elseif self.target_y > self.scene.y then
                self.target_y = self.scene.y
            end
    
            local pan_y = self.y - self.target_y
            local y = pan_y / 4
            if (y > - 0.125) and (y < 0.125) then
                y = 0
            end
            self.y = self.y - y     
        end
        
        -- LuaDrawing_draw_rect(
        --     self.scene.x,  
        --     self.scene.y, 
        --     self.scene.width,
        --     self.scene.height          
        -- )     
    end,

    pan         = function(self, x, y)
        self.pan_x = x
        self.pan_y = y
    end,

    jump = function(self, x, y)
        self.x = self.x + x
        self.y = self.y + y
    end,

    cut = function(self)
        self:run()
        self.x = self.target_x
        self.y = self.target_y
        self.zoom = self.target_zoom
    end,

    --~ is_on       = function(self, object)
        --~ return  (object.x - object.r >= 0)
        --~ and     (object.x + object.r <= self.width)
        --~ and     (object.y - object.r >= 0)
        --~ and     (object.y + object.r <= self.height)
    --~ end,

    init        = function (self, width, height, scene)
        self.x           = 0
        self.y           = 0 

        self.width       = width 
        self.height      = height
        if width == nil then
            self.width = 1
        end
        if height == nil then
            self.height = 1
        end
        -- Wichtiger Unterschied zwischen self.width und self.scene.w: self.width ist der Bildausschnitt und scene.w die gesamte Szenenfläche

        self.zoom        = 1
        self.target_zoom = self.zoom

        self.target_x    = self.x
        self.target_y    = self.y

        self.pan_x       = 0
        self.pan_y       = 0

        self.scene = scene
        if scene == nil then
            self.scene       = {
                x=0,
                y=0,
                width=0,
                height=0
            }       
        end
        self.center_x = ((self.width / 2) + self.scene.x) / self.zoom
        self.center_y = ((self.height / 2) + self.scene.y) / self.zoom  

        self.type = "camera"
        self.name = "Camera"

        self.focus = {x = 100, y = 100}

        self.center_x = 0 / 2
        self.center_y = 0 / 2
    end
}
--------------------- time_events.lua ---------------------
Time_Events = {   

    run = function(self)   
        local copy = nil
        for i = 1, #self.timers do            
            self.timers[i].timeout = self.timers[i].timeout -1
            if self.timers[i].timeout <= 0 then  
                copy = {
                    callback = self.timers[i].callback,
                    this = self.timers[i].this
                } 
                if self.debug == true then
                    local name = ""
                    if not(self.timers[i].name == nil) then
                        name = self.timers[i].name
                    end
                    print("time_events info: Timer ".. name .. " (" .. tostring(self.timers[i].callback).. ") stopped after")
                    print(string.format("\t%.2f seconds.", (os.clock() - self.timers[i].time_start)))
                end                        
                table.remove(self.timers, i)       
                break
            end
        end       
        if not (copy == nil) then
            if copy.callback == nil then
                print("Time events: error callback was nil.")
            else               
                copy.callback(copy.this)  
            end
        end
    end,
   
    init = function(self)
        self.type    = "time_events"
        self.timers = {} 
        self.debug = false

        return true
    end,

    reset = function(self, time_out, call_back, that, name)
        if call_back == nil then
            print("Time events error: no callback given!")
            do return end
        end
        local timer = nil
        for k, t in pairs(self.timers) do
            if t.callback == call_back then
                timer = t
                break
            end
        end

        if timer == nil then
            timer = {               
                callback = call_back
            }  
            --print("time_events: creating new timer")
            table.insert(self.timers, timer)
        end
        --print("time_events: re-set timer")
        if time_out < 0 then
            time_out = 0
        end
        timer.timeout = time_out
        timer.this = that
        timer.time_start = os.clock()
        timer.name = name   
        if self.debug == true then           
            if name == nil then
                name = ""
            end
            print("time_events info: Timer " .. name .. " (" .. tostring(call_back).. ") started.")  
        end 
    end,

    delete = function (self, call_back)
        for k, t in pairs(self.timers) do
            if(t.callback == call_back) then
                table.remove(self.timers, k)
                if self.debug == true then 
                    print("time_events info: Deleted timer " .. t.name .. " #".. k .." (" .. tostring(t.callback).. ").")  
                end 
                break
            end
        end
    end,


    new = function(self)
        local object = {}
        setmetatable(object, self)
        self.__index = self
        object:init()
        return object
    end
}
--------------------- input.lua ---------------------
--[[ Ideen:    
    - Animationen beschleunigen -> Validieren!!!   
    - Event Timer Bugs beim Start und während abgeräumt wird ??? Nein?!
    - Neue Numbers am Rand des Spielfelds spawn in zeitlichen Abständen und müssen eliminiert werden
]]--
Input = {  
    parent = nil,  
    numbers = {},

    run = function(self)  
        LuaDrawing_set_color(255, 255, 255, 200)
        
        for k, s in pairs(self.slots) do 
            s:run()         
            if not  ( self.parent.mode == self.parent.modes.CASUAL) 
                and (s.number:is_hidden() == false)
                and (
                        (s.column_number == 1)
                    or  (s.column_number == self.max_columns) 
                    or  (s.row_number == 1) 
                    or  (s.row_number == self.max_rows)
                )
            then--draw white layer, TODO: add sprite for this
                LuaDrawing_fill_rect(
                    math.floor(s.number.camera:get_x(s.number.x)), 
                    math.floor(s.number.camera:get_y(s.number.y)), 
                    math.floor(s.number.camera:get_width(s.number.w)), 
                    math.floor(s.number.camera:get_height(s.number.h))
                )
            end   
        end   
        
        LuaDrawing_set_color(0, 0, 0, 255)

        if not (self.cursor == nil) then           
            LuaDrawing_draw_rect(
                math.floor(self.parent.camera:get_x(self.cursor.x)), 
                math.floor(self.parent.camera:get_y(self.cursor.y)), 
                math.floor(self.parent.camera:get_width(self.cursor.w)), 
                math.floor(self.parent.camera:get_height(self.cursor.h))
            )
        end

        -- if not (self.hint == nil) then           
        --     LuaDrawing_fill_rect(
        --         math.floor(self.parent.camera:get_x(self.hint.x)), 
        --         math.floor(self.parent.camera:get_y(self.hint.y)), 
        --         math.floor(self.parent.camera:get_width(self.hint.w)), 
        --         math.floor(self.parent.camera:get_height(self.hint.h))
        --     )
        -- end

        -- for k, e in pairs(self.slots) do            
        --     -- LuaDrawing_set_color(125, 125, 125, 255) 
        --     -- LuaDrawing_draw_rect(
        --     --     math.floor(e.x - 0), 
        --     --     math.floor(e.y - 0), 
        --     --     math.floor(e.w + 0), 
        --     --     math.floor(e.h + 0)
        --     -- )
        --     if self.cursor == e then
        --         for c, n in pairs(e.neighbours) do 
        --             LuaDrawing_set_color(11, 153, 90, 255) --GREEN
        --             LuaDrawing_draw_rect(
        --                 math.floor(n.x + 1), 
        --                 math.floor(n.y + 1), 
        --                 math.floor(n.w - 2), 
        --                 math.floor(n.h - 2)
        --             )
        --         end
        --     end
        -- end
        
        
        -- LuaDrawing_set_color(255, 255, 255, 255)          
        -- LuaDrawing_draw_rect(
        --     self.parent.camera:get_x(self.x), 
        --     self.parent.camera:get_x(self.y), 
        --     self.parent.camera:get_width(self.w), 
        --     self.parent.camera:get_height(self.h) 
        -- )
        
        

        -- if (self.hint_active == true) and not(self.hint == nil) then
        --    --[[--
        --     self.particles:set_color(255, 255, 255, 75)
        --     self.particles:reset(
        --         math.random(self.hint.x, self.hint.x + self.hint.w),
        --         math.random(self.hint.y, self.hint.y + self.hint.h),                           
        --         1,--math.random(1, 3), 
        --         true,   
        --         3,
        --         self.hint.h
        --     ) --print("h!")
        --     self.particles:set_color()
        --     --]]--
        --     self.hint.number.x = self.hint.number.target_x + math.random(-8, 8)  -- vibrate
        --     self.hint.number.y = self.hint.number.target_y + math.random(-8, 8)  
        -- end  
        
        if not(self.particles == nil) then
            self.particles:run()
        end
        self.events:run()

        -- CHECK --------------------------------------------------------------------------------------------------------------
        
        if self.status == self.states.CHECK then            
            --self.events:reset(self.countdown_minus_one, self.minus_one, self, "minus one")

            if self:check_pairs(true) == true then--check_pairs returns true if it's done                
                             
            --print("Input: reset countdown")                            
                if not (self.second_cursor == nil) then--penalty for wrong swap  
                    --if not (self.control == nil) then 
                        -- self.control:update_score(0 - self.cursor.number.value)
                        
                        -- if  self.control:get_score() <= 0 then
                            
                        -- end
                        -- self.bugs[1]:hurt(0 - self.cursor.number.value)
                    --end     
                   
                    self.cursor:swap_with(self.second_cursor, self.countdown_speedup)-- swap back

                    self.events:reset(self.countdown_swap, self.animate_swap_back, self, "swap back"); self.status = self.states.DELAY

                    --//////////////////////////////////////////////////--   
                    
                    if Subscription.type.WRONG_SWAP == nil then
                        print("Input warning: WRONG_SWAP is nil")
                    else
                        self.subscribers:notify(Subscription.type.WRONG_SWAP)
                    end
                   
                    --//////////////////////////////////////////////////--

                   
                else
                    self.events:reset(self.countdown_swap, self.animate_load, self, "animate load"); self.status = self.states.DELAY
                end 
            end 
            
            --if not (self.cursor == nil) and not (self.second_cursor == nil) then  
                self.cursor = nil
                self.second_cursor = nil                                   
            --end 
        
        elseif self.status == self.states.WAIT then    


        -- LOADING ----------------------------------------------------------------------------------------------------------    
        
        elseif self.status == self.states.LOADING then             
            --self.events:reset(self.countdown_minus_one, self.minus_one, self, "minus one")

            -- load more numbers
            if self:load_more(true) == true then--done loading
                  --//////////////////////////////////////////////////-- 
                    
                  if Subscription.type.DONE_LOADING == nil then
                    print("Input warning: DONE_LOADING is nil")
                else
                    self.subscribers:notify(Subscription.type.DONE_LOADING, self.slots)
                end
            --//////////////////////////////////////////////////--    
                if self:check_more_moves() == false then--game over                  
                        self.status = self.states.OVER
                    --//////////////////////////////////////////////////--
                        if Subscription.type.GAME_OVER == nil then
                            print("Input warning: GAME_OVER is nil")
                        else
                            self.subscribers:notify(Subscription.type.GAME_OVER, nil, "(input line 162)")
                            if not(self.particles == nil) then
                                for k, s in pairs(self.slots) do
                                    self.particles:reset(
                                        s.number.x + s.number.w/2,
                                        s.number.y + s.number.h/2, 
                                        math.random(8, 32)
                                    )
                                end
                            end
                        end
                        
                    --//////////////////////////////////////////////////--
                           
                        --end
                    
                else--more moves, go to swap back
                    if self:check_pairs(true) == false then
                        self.events:reset(self.countdown_check - self.countdown_speedup, self.animate_check, self, "animate check") 
                        self.status = self.states.DELAY                        
                    else
                        self.events:reset(self.countdown_swap - self.countdown_speedup, self.animate_swap_back, self, "swap back")--DONE
                        self.status = self.states.DELAY
                        
                    end
                    --math.floor(self.y + self.h - self.score * (self.h / self.next_score))
                end
            else--repeat "loading"
                --self.events:reset(self.countdown_show_hint, self.show_hint, self, "show hint")
                self.status = self.states.DELAY
                
                self.countdown_speedup = self.countdown_speedup + 1
                                
                self.events:reset(self.countdown_loading - self.countdown_speedup, self.animate_load, self, "animate load")  
                print("Input: loading_speed up is: ".. self.countdown_speedup)
                --//////////////////////////////////////////////////--                    
                    if Subscription.type.LOADING_CONTINUES == nil then
                        print("Input warning: LOADING_CONTINUES is nil")
                    else
                        self.subscribers:notify(Subscription.type.LOADING_CONTINUES)
                    end
                --//////////////////////////////////////////////////--
                   
            end  
        end

    end,


    check_pairs = function(self, keep_score) 
        if keep_score == nil then
            keep_score = false        
        end

        local done = true        
        for k, s in pairs(self.slots) do
            if (s.number:is_active() == true) and (s.number:is_border() == false)
            then for c, n in pairs(s.neighbours) do                        
                    if not(n.number == nil) 
                    and not(s.number == nil) 
                    and (n.number:is_active() == true) 
                    and (n.number:is_border() == false)
                    and (s.number:divide_by(n.number) == true) then
                        if keep_score == true then
                            local new_score = s.number.last_value + n.number.last_value
                            -- if self.hint_active == false then
                            --    --new_score = new_score * self.bonus -- TODO: BONUS re-implementieren
                            --     --self.bonus = 1
                            -- end
                            --//////////////////////////////////////////////////--
                            if Subscription.type.SCORE == nil then
                                print("Input warning: SCORE is nil")
                            else
                                self.subscribers:notify(Subscription.type.SCORE, new_score)
                            end
                           --//////////////////////////////////////////////////--

                            --if not (self.control == nil) then --kill bugs 
                                
                                -- table.remove(self.bugs)
                                -- if #self.bugs < 1 then
                                --     
                                -- end 
                                --self.control:update_score(new_score) 

                                -- if self.control:update_score(new_score) == true then--LEVEL UP
                                --     self:level_up()
                                -- -- else
                                -- --     print("Score: " .. self.control:get_score())
                                -- --     print("Next : " .. self.control:get_next_score())
                                -- end
                            --end 
                            --
                            if not(self.particles == nil) then
                                if s.number:is_active() == false then    
                                --function(self, x, y, a, alternate, max_speed, max_size)
                                    self.particles:reset(
                                        s.number.x + s.number.w/2,
                                        s.number.y + s.number.h/2, 
                                        math.random(8, 32)
                                    )
                                end
                                if n.number:is_active() == false then    
                                    self.particles:reset(
                                        n.number.x + n.number.w/2,
                                        n.number.y + n.number.h/2, 
                                        math.random(8, 32)
                                    )
                                end
                            end
                            --particle_reset(0, math.floor(n.x + n.w/2), math.floor(n.y + n.h/2) )   

                            --print("Input: +" .. new_score .. "; Score is " .. self.score .. "/" .. self.next_score) 
                        end
                        done = false    
                        break                    
                    end                    
                end 
            end
            if done == false then break end
        end
        return done 
    end,
    
    
    load_more = function(self, keep_score)--returns true if it is done
        if keep_score == nil then
            keep_score = false        
        end  
        local done = true  

        local Slots  = {} 
        if (self.direction_load ==  self.direction.north)  
        or (self.direction_load ==  self.direction.east) then           
            for i = 1, #self.slots do
                table.insert(Slots, self.slots[i])
            end
        else--reverse search direction, because this is necessary
            for i = #self.slots, 1, -1 do
                table.insert(Slots, self.slots[i])
            end
        end 

        for k, s in pairs(Slots) do            
            if s.number:is_active() == false then 
                local neighbour = s:get_neighbour(self.direction_load) 
                
                if (neighbour == nil) --or (neighbour.number:is_active() == false) 
                then --assume we are at border and create new number
                    s:reset_number(self.number_minimum, self.number_maximum, keep_score) 
                else
                    -- if keep_score == true then
                    --     print(tostring(s) .. " is empty at x:" .. s.x .. "; y:" .. s.y)  
                    --     print("found a neighbour (" .. tostring(neighbour) .. ") at x:" .. neighbour.x .. "; y:" .. neighbour.y)
                    --     print("number state =  " .. neighbour.number.state)
                    -- end
                    s:swap_with(neighbour)
                    if keep_score == false then
                        s.number:warp(); neighbour.number:warp()
                    end
                end
                done = false 
                break--!
            end
        end                     
        return done
    end,


    check_more_moves = function(self)
        local no_more_moves = true
        for k, s in pairs(self.slots) do
            for c, n in pairs(s.neighbours) do
                s:swap_with(n)
                for z, m in pairs(n.neighbours) do
                    local div = n.number:check_division(m.number)--print("\t" .. div)
                    if  not (div == nil) and (div < 1) then
                        --self.hint = m
                        no_more_moves = false        
                        break
                    end
                end
                s:swap_with(n)
                if no_more_moves == false then
                    break
                end
            end
            if no_more_moves == false then
                break
            end
        end
        return not no_more_moves
    end,

    touched = function(self, x, y)    
        local result = false 
        if self.status == self.states.READY then               
            for k, e in pairs(self.slots) do            
                if      (x > e.x) and (x < e.x + e.w) and (y > e.y) and (y < e.y + e.h) 
            and (e.number:is_border() == false)
            and (e.number:is_active() == true)
                then
                    --if self.cursor == nil then  
                        self.cursor = e 
                        self.second_cursor = nil  
                        result = true
                        --print("Input: you clicked on number " .. self.cursor.number.value)
                        --//////////////////////////////////////////////////--                            
                            if Subscription.type.SELECT == nil then
                                print("Input warning: select is nil")
                            else
                                self.subscribers:notify(Subscription.type.SELECT, e)
                            end
                        --//////////////////////////////////////////////////--
                -- end

                    -- for j, b in pairs(self.bugs) do--scare bugs
                    --     if b:is_on_slot(e) == true then
                    --         b:scare()
                    --     end
                    -- end
                    break    
                end
            end 
        end
        if result == false then--reset cursor
            self.cursor = nil
            self.second_cursor = nil  
        end

        return result
    end,
        
    clicked = function(self, x, y)  
        --self.direction_load = self.direction.south
        local result = false 
        if self.status == self.states.READY then               
            for k, e in pairs(self.slots) do            
                if      (x > e.x) and (x < e.x + e.w) and (y > e.y) and (y < e.y + e.h) 
               and (e.number:is_border() == false)
               and (e.number:is_active() == true)
                then
                    --e:print(); break
                    if not (self.cursor == nil) and (
                            (self.cursor:is_neighbour_of(e) == true) 
                        or ((self.cursor.number.value == e.number.value) and (e.number:is_prime()== true) and not (e == self.cursor)) 
                    )
                        then
                            -- check double primes
                            if (self.cursor.number.value == e.number.value) and (e.number:is_prime()== true) then 
                                -- self:minus_one(e.number)
                                -- self:minus_one(self.cursor.number)
                                -- self.cursor = nil
                                -- self.second_cursor = nil
                            -- normal move 
                            else
                                self.second_cursor = e
                                self.cursor:swap_with(e)  
                                 -- change load direction
                                self.direction_load = self.direction.north
                                if self.second_cursor.x < self.cursor.x then
                                    self.direction_load = self.direction.west
                                elseif self.second_cursor.x > self.cursor.x then
                                    self.direction_load = self.direction.east
                                elseif self.second_cursor.y < self.cursor.y then
                                    self.direction_load = self.direction.south                                
                                end                                
                                -- if self.direction_load >= self.direction.east then
                                --     self.direction_load = self.direction.north 
                                -- else
                                --     self.direction_load = self.direction_load + 1
                                -- end
                            end 
                            
                            --//////////////////////////////////////////////////--
                            if Subscription.type.SWAP == nil then
                                print("Input warning: SWAP is nil")
                            else
                                self.subscribers:notify(Subscription.type.SWAP, e)
                                self.subscribers:notify(Subscription.type.SWAP, self.cursor)
                            end
                            --//////////////////////////////////////////////////--

                            self.countdown_speedup = 0
                            self.status = self.states.DELAY; self.events:reset(self.countdown_swap, self.animate_check, self, "animate check")
                                        
                            --self.bonus = self.bonus_multiplier--reset bonus  
                            --self:update_score(-self.score_penalty_wrong_swap)                          
                            result = true 
                    end

                    -- for j, b in pairs(self.bugs) do--scare bugs
                    --     if b:is_on_slot(e) == true then
                    --         b:scare()
                    --     end
                    -- end
                    break    
                end
            end 
        end 

        --self:hide_hint(true)
       
        if result == false then--reset cursor
            self.cursor = nil
            self.second_cursor = nil  
        else
            --self.events:delete(self.show_hint)
        end

        return result
    end,
                   

    init = function(self, parent)      
        self.particles = nil--Particles:new()  
        --self.subscribers = nil   
       
        self.states = {
            READY   = 1,
            SWAP    = 5,
            LOADING = 3,
            DELAY   = 4,
            EMPTY   = 2,
            CHECK   = 6,
            WAIT    = 7,--for notification
            OVER    = 8,
            PAUSE   = 9
        }; 
        
        self.column_width = 1
        self.column_height = 1

        --self.max_try_generate_level = 1000000

        self.countdown_show_hint = 250
        self.countdown_hide_hint = 36
        self.countdown_minus_one = 2000
        
        self.countdown_swap = 8--16 
        self.countdown_check = 16--32 
        self.countdown_loading = self.countdown_check + 4 -- 8 -- should be higher than countdown_check

        self.countdown_speedup = 0        

        self.number_minimum = 2
        self.number_maximum = nil
        self.number_more = 5--add to random range for numbers
        self.number_start = 10
        -- self.number_bugs = 1
        -- self.number_bugs_more = 0
       
        self.direction = {
            north = Slot.direction.north,
            east = Slot.direction.east,
            south = Slot.direction.south,            
            west = Slot.direction.west
        }
        self.direction_load = self.direction.south

        self.score_penalty_hint = nil       

        --self.bonus = 1
        --self.bonus_multiplier = 2--(multiplier)

        self.type    = "input"
        
        self.parent = parent
        self.w = 0
        self.h = 0
        self.x = 0
        self.y = 0

        if self.parent == nil then             
            print("Input error: no parent")
            do return false end  
        else
            if self.parent.camera == nil then 
                print("Input error: no camera")
            else
                self.parent.camera:set_scene({x = self.x, y = self.y, width = self.w, height = self.h})
                if not(self.particles == nil) then
                    self.particles:set_camera(self.parent.camera)
                end
            end               
            
        end
        
        self.events = Time_Events:new()  
        --self:level_up() 
        
         --//////////////////////////////////////////////////--
        --  if Subscription.type.LEVEL_UP == nil then
        --     print("Input warning: LEVEL_UP is nil")
        -- else
        --     self.subscribers:notify(Subscription.type.LEVEL_UP, e)
        -- end
        -- self.subscribers:notify(Subscription.type.LEVEL_UP)
         --//////////////////////////////////////////////////--

        
        self.slots = {}
        self.penalties = {}

        self.status = self.states.WAIT 
        return true
    end,

    
    tabula_rasa = function(self)        
        --local tries = 0           
        -- while (self:check_pairs() == false) and (self:load_more() == false) do            
        --    tries = tries + 1  --print(tries)            
        --    if tries > self.max_try_generate_level then                
        --        break
        --    end
        --end 
        --print("Input: needed " .. tries .. "/"..self.max_try_generate_level.." rounds to create level.")
        local p = 2
        for k, s in pairs(self.slots) do--set prime numbers first
            s.number:update_value(p)
            p = s.number:get_next_prime()
            s.number:update_value(p)            
            p = p + math.random(-2, 2)
            s.paired_with = nil
            if p == 1 then
             p = 2
            end
            print(s.number.value)
        end   
        
        for k, s in pairs(self.slots) do  -- shuffle
            s:swap_with(self.slots[math.random(1, #self.slots)])
        end  
        
        for i=1,4 do
            for k, s in pairs(self.slots) do--create pairs           
                local d =i--= math.random(1, 4)--directions
                local const multiple = 4
                if (d > 0) and (s.paired_with == nil) then
                    local n = s:get_neighbour(d)
                    if not(n == nil) then
                        local m = n:get_neighbour(d)
                        if not(m == nil) and (m.paired_with == nil) then                        
                            local new_number = {value = s.number:get_next_prime () * math.random(2, multiple)}
                            if not(n.number:check_division(new_number) == 0) then
                                s.paired_with = m
                                m.paired_with = s
                                print("input info: paired ".. s.id .. " with " .. m.id)
                                print("\ts="..s.number.value)
                                print("\tm="..m.number.value .. " -> m=" .. new_number.value)                        
                                s.number:update_value(new_number.value)
                            end
                        end
                    end
                end
            end
        end
        
        if not(self.parent.mode == self.parent.modes.CASUAL) then
            for k, s in pairs(self.slots) do--!
                if (s.column_number == 1)
                or (s.column_number == self.columns) 
                or (s.row_number == 1) 
                or (s.row_number == self.rows) then
                    s.number.border = true
                    s.number.hidden = true
                end
            end
        end
        
    end,
    
    reset = function(self, e) 
        local const level = e
        
        if not (self.parent == nil) and not (self.parent.camera == nil) then            
            self.width = self.parent.width
            self.height = self.parent.height
            self.w = self.width
            self.h = self.height
            self.parent.camera:set_scene({x = self.x, y = self.y, width = self.w, height = self.h})
        else
            print("Input error: no parent (game) given.")
        end
        
        self.columns = level
        
        self.number_maximum = self.number_start + self.number_more * (level - 1)--magic number

        self.slots = {}
                
        self.cursor = nil
        self.second_cursor = nil
        
        self.column_width = math.floor(self.width / self.columns)
        self.gap_x = self.width % self.column_width--print("Gap x:" .. self.gap_x)
        
        self.column_height = math.floor(self.column_width * 1.625)

        self.rows = math.floor(self.height / self.column_height)

        self.parent.camera:set_scene({
            x = self.x, y = self.y, 
            width  = self.columns * self.column_width,
            height = self.rows * self.column_height
        })

        --self.gap_x = self.height
        --self.gap_y = math.floor((self.height % self.column_height) / (self.rows + 1))  
       
       --print("Gap y:" .. self.gap_y)
        -- self.events:reset(self.countdown_minus_one, self.minus_one, self) 
        --self.events:reset(self.countdown_show_hint, self.show_hint, self, "show hint")

        local id_column = 0       
        for j=0, self.rows-1 do
            for i=0, self.columns-1 do 
                id_column = id_column + 1

                --slot
                local slot = Slot:new()                
                -- slot.x = self.x + self.gap_x + i * (self.column_width + self.gap_x)
                -- slot.y = self.y + self.gap_y + j * (self.column_height + self.gap_y) 
                slot.x = self.x + i * self.column_width
                slot.y = self.y + j * self.column_height
                slot.w = self.column_width
                slot.h = self.column_height
                slot.column_number = i+1
                slot.row_number = j+1
                slot.max_columns = self.columns
                slot.max_rows = self.rows
                

                --number
                local number = Number:new()                 
                if not((self.parent == nil) or (self.parent.camera == nil)) then                 
                    number:set_camera(self.parent.camera)
                end

                --table.insert(self.numbers, number)
                slot.number = number 
                slot:reset_number(self.number_minimum, self.number_maximum)
                               
                -- if ((id_column % 2) == 0) 
                -- or ((id_column % 3) == 0)                     
                -- or ((id_column % 5) == 0) then                    
                --     number:update_value(math.random(self.number_minimum, 10))                
                -- end
                
                slot.id = id_column
                slot.neighbours = {}  
                
                ------TEST ------------------------
                -- if (j == self.columns-1) and ( i == self.columns-1) then
                --     slot.number:update_value(1)
                -- end

                -- 
                number:move_to(slot.x, slot.y)
                number:warp()

                table.insert(self.slots, slot)
            end
        end

        for k, e in pairs(self.slots) do--add neighbours            
            for c, d in pairs(self.slots) do
                if not (e == d) then
                    if (
                        (d.x - d.w/2 >= e.x)
                    and(d.x - d.w/2 <= e.x + e.w)
                    and(d.y + d.h/2 >= e.y)
                    and(d.y + d.h/2 <= e.y + e.h) 
                    ) or (
                        (d.x + d.w + d.w/2 >= e.x)
                    and(d.x + d.w + d.w/2 <= e.x + e.w)
                    and(d.y + d.h/2 >= e.y)
                    and(d.y + d.h/2 <= e.y + e.h) 
                    ) or (
                        (d.x + d.w/2 >= e.x)
                    and(d.x +  d.w/2 <= e.x + e.w)
                    and(d.y - d.h/2 >= e.y)
                    and(d.y - d.h/2 <= e.y + e.h)
                    ) or (
                        (d.x + d.w/2 >= e.x)
                    and(d.x +  d.w/2 <= e.x + e.w)
                    and(d.y + d.h + d.h/2 >= e.y)
                    and(d.y + d.h + d.h/2 <= e.y + e.h)
                    )   then
                        d:add_neighbour(e)
                        e:add_neighbour(de)
                    end
                end
            end
        end 
              
        self.status = self.states.CHECK
        
        self:tabula_rasa()
        self.events:reset(500, self.animate_penalty, self) 
        
        return (self:check_more_moves() == true)   

        --self.subscribers:notify(Subscription.type.DONE_LOADING, self.slots)
    end,

    new = function(self, o)
        local o = o or {}
        setmetatable(o, self)
        self.__index = self
        --self:init()
        return o
    end,

-- Callbacks ---------------------------------------------------------------
    animate_penalty = function(self)
        for k, s in pairs(self.slots) do
            if ((s.column_number == 1)
            or (s.column_number == self.columns) 
            or (s.row_number == 1) 
            or (s.row_number == self.rows))
            and (s.number:is_hidden() == true) then
                s.number:show()
                break
            end
        end
    end,

    animate_swap_back = function(self)               
        self.status = self.states.READY 
    end,

    animate_check = function(self)               
        self.status = self.states.CHECK      
    end,

    animate_load = function(self)               
        self.status = self.states.LOADING      
    end,
--[[--
    -- show_hint = function(self)   
    --     print("Input: show_hint callback called!")     
    --     self.hint_active = true
    --     self.events:reset(self.countdown_hide_hint, self.hide_hint, self, "hide hint")   
    --     --Sound_hint()       
    -- end,

    -- hide_hint = function(self, no_minus)
    --     --print("Input: hide_hint callback called!")

    --     --self.hint = nil; 
        
    --     self.hint_active = false    
    --     if no_minus == nil then
    --         -- if not(self.control == nil) then 
    --         --     self.control:update_score(0 - math.floor(self.number_maximum/2))              
    --         --     if  self.control:get_score() <= 0 then
    --         --         self.parent:over(self.control:get_score(), self.control:get_highscore())
    --         --     end
    --         -- end  
    --     end
    -- end,

    minus_one = function(self, number)
        --print("Input: Minus one callback called------------------------------------------")        
        if self.status == self.states.READY then
            -- if number == nil then
            --     local i = math.random(1, #self.numbers)
            --     number = self.numbers[i]
            --     if nummber == nil then
            --         print("Input error: this number does not exist!")
            --         do return end
            --     end
            --     self.events:reset(self.countdown_minus_one, self.minus_one, self, "minus one")        
            -- end
            -- local r = math.random(-10, 10)
            -- if r < 0 then
            --     r = -1
            --     if number.value > self.number_minimum then
            --         number:update_value(number.value - 1)
            --     end
            -- else
            --     r = 1
            --     if number.value < self.number_maximum then
            --         number:update_value(number.value + 1)
            --     end
            -- end
            -- number.y = number.target_y + (r * 8)
            number:update_value(number.value - 1)
            self.status = self.states.CHECK
            --self.subscribers:notify(Subscription.type.NUMBER_DAMAGED)
            --
            return true
        else
            return false
        end
    end,

    to_prime = function(self, number) 
        if self.status == self.states.READY then
            if number == nil then
                local i = math.random(1, #self.slots)
                number = self.slots[i].number
                if nummber == nil then
                    print("Input error: this number does not exist!")
                    do return false end
                end                 
            end       
            number.y = number.target_y + (math.random(-10, 10) * 8)
            number.x = number.target_x + (math.random(-10, 10) * 8)
            number:update_value(self:get_new_prime())
            self.status = self.states.CHECK
            --self.subscribers:notify(Subscription.type.NUMBER_DAMAGED)
            return true
        else
            return false
        end
    end,

    get_new_prime = function(self)
        local h = 1
        for k, n in pairs(self.slots) do
            if n.number.value > self.slots[h].number.value then
                h = k
            end
        end

        local high_count = 0
        local found = false
        local number = self.slots[h].number.value
        local highest = number
        while found == false do
            high_count = high_count + 1
            highest = number + high_count
            found = true            
            for i=2, (highest-1) do
                if highest % i == 0 then
                    found = false
                    break
                end
            end
        end
        return highest
    end,
--]]--
    notify = function(self, type, e)

        if type == nil then
            print("Input ERROR: no type")
        elseif type == Subscription.type.NUMBER_DAMAGED then 
            if (e == nil) or not (e.type == "slot") then
                print("Input: notify, e is nil or not a slot!")            
            else           
                self:to_prime(e.number)
            end        
        elseif type == Subscription.type.LEVEL_UP then 
            if e == nil then
                print("Input: notify, e is nil (needed for level number).")            
            else           
                self:reset(e)
            end
        end
    end
}
--------------------- particles.lua ---------------------
Particles = {   
    
    run = function(self) 
       for i=1,#self.particles do 
            self.particles[i].r = self.particles[i].r - self.shrink
            self.particles[i].x = self.particles[i].x + self.particles[i].speed_x
            self.particles[i].y = self.particles[i].y + self.particles[i].speed_y

            if self.particles[i].alternate == true then
                local m = math.random(-1, 1)
                if m > 0 then
                    self.particles[i].speed_x = self.particles[i].speed_x * -1  
                end 
                m = math.random(-1, 1)
                if m > 0 then
                    self.particles[i].speed_y = self.particles[i].speed_y * -1  
                end 
            end 

            if self.particles[i].r < 1 then
                table.insert(self.to_delete, i)
            else            

                LuaDrawing_set_color(
                    self.particles[i].color.r,
                    self.particles[i].color.g,
                    self.particles[i].color.b,
                    self.particles[i].color.a
                )

                LuaDrawing_fill_rect(
                    math.floor(self.camera:get_x(self.particles[i].x)), 
                    math.floor(self.camera:get_y(self.particles[i].y)), 
                    math.floor(self.camera:get_width(self.particles[i].r)), 
                    math.floor(self.camera:get_height(self.particles[i].r))
                )
            end            
        end 
        
        -- delete dead particles
        local p = table.remove(self.to_delete)
        while not (p == nil) do
            table.remove(self.particles, p)
            p = table.remove(self.to_delete)
        end
    end,

    set_color = function(self, r, g, b, a)
        if r == nil then
            self.color = nil
        else
            self.color = {
                r = r, 
                g = g, 
                b = b, 
                a = a
            }
        end
    end,
    
    set_camera = function(self, camera)
        self.camera = camera
        if (camera == nil) then
            print("Particle error: no camera")
        end
    end,

    reset = function(self, x, y, a, alternate, max_speed, max_size)
        if alternate == nil then
            alternate = false
        end

        if max_speed == nil then
            max_speed = self.max_speed
        end
        
        if max_size == nil then
            max_size = self.max_size
        end
        for i=0, a do
            local color = {
                r = math.random(0, 255),
                g = math.random(0, 255),
                b = math.random(0, 255),
                a = math.random(50,255)
            }
            if not (self.color == nil) then
                color = self.color
            end
                
            table.insert(self.particles, {
                x=x, 
                y=y, 
                r=math.random(2, max_size),
                speed_x=math.random(-max_speed, max_speed)/max_speed,
                speed_y=math.random(-max_speed, max_speed)/max_speed,
                color = color,
                alternate = alternate
            })
        end
    end,
       
    
    init = function(self)       
        self.type    = "particles"
        self.x       = 0--math.random(0, 200)
        self.y       = 0--math.random(0, 200) 

        self.max_speed = 10
        self.shrink = 0.25
        self.max_size = 64

        self.particles = {} 
        self.to_delete = {}

        self.color = nil
        

        return true
    end,

    new = function(self)
        local object = {}
        setmetatable(object, self)
        self.__index = self
        object:init()
        return object
    end
}
--------------------- number.lua ---------------------
Number = {
    hidden = false,
    active = false,
    border = false,

    update_value = function(self, v) 
        if v == nil then
            v = self.value
        end 
        --if v == 1 then
        --    v = 2
        --end
        self.last_value = self.value 
        self.value = v
        local t = self.value
        local sum = 0
        local remainder = 0
        self.digits = {}--clear

        -- check if is prime_number
        self.prime = true
        for i=2,(self.value-1) do
            if self.value % i == 0 then
                self.prime = false
                break
            end
        end
        self.next_prime = nil--self:get_next_prime()

        self.active = true
        if self.value <= 1 then
            self.active = false
        end

        local digit_sum = 0

        while t > 0 do        
            remainder = t % 10
            table.insert(self.digits, 1, remainder)
            digit_sum = digit_sum + remainder
            t = math.floor(t / 10)
        end
        --print("Value: " .. self.value)
        --print("Digits: " .. #self.digits)

        -- self.w = self.fontsize * (1 + #self.digits)
        -- self.h = self.w
        -- self.r = self.w    
        if #self.digits >= 3 then
            self.fontsize= 7
        else
            self.fontsize= 12
        end  

    -- calculate sprite clip
        local i = 0
        for y=0, self.tiles_per_column-1 do
            for x=0, self.tiles_per_row-1 do
                i = i + 1
                if i >= self.value then
                    self.clip_x = x * self.clip_w
                    self.clip_y = y * self.clip_h
                    break
                end
            end
            if i >= self.value then break end
        end
        return digit_sum
    end,

    is_active = function(self)        
        return self.active
    end,
    
    is_hidden = function(self)
        return self.hidden
    end,

    is_border = function(self)
        return self.border
    end,
    
    hide = function(self)
        self.hidden = true
    end,    
    
    show = function(self)
        self.hidden = false
    end,
    
    is_prime = function(self)
        return self.prime
    end,

    get_next_prime = function(self, next)
        --if number == nil then
        number = self.value
        --end
        if not(self.next_prime == nil) then 
            do return self.next_prime end
        end
                
        local low_count = 0
        local found = self.prime
        local lowest = number
        while found == false do
            low_count = low_count + 1
            lowest = number - low_count
            found = true            
            for i=2, (lowest-1) do
                if lowest % i == 0 then
                    found = false
                    break
                end
            end
        end
        
        local high_count = 0
        found = self.prime
        local highest = number
        while found == false do
            high_count = high_count + 1
            highest = number + high_count
            found = true            
            for i=2, (highest-1) do
                if highest % i == 0 then
                    found = false
                    break
                end
            end
        end

        if low_count < high_count then
            self.next_prime = lowest
        else
            self.next_prime = highest
        end
        if not(next == nil) then
            self.next_prime = highest
        end
        --print("Number = " .. self.value .. " NEXT = " .. self.next_prime)
        if(self.next_prime <= 1) then
            self.next_prime = 2
        end
        return self.next_prime
    end,

    run = function(self) -- move and render
        if self.active == false then 
            do return end
        end
        
        if self.target_x > self.x then            
            if self.target_x - self.x  < self.threshold_movement then
                self.x = self.target_x
            else                
                self.x = self.x + (self.target_x - self.x) / self.target_easing 
                --print("Number " .. self.value .. "x: " .. self.x .. "/" .. self.target_x )
            end
           
        else
            if self.x - self.target_x  < self.threshold_movement then
                self.x = self.target_x
            else                
                self.x = self.x + (self.target_x - self.x)  / self.target_easing 
                --print("Number " .. self.value .. "x: " .. self.x .. "/" .. self.target_x )
            end
           
        end
        
        if self.target_y > self.y then
            if self.target_y - self.y  < self.threshold_movement then
                self.y = self.target_y
            else
                self.y = self.y + (self.target_y - self.y)  / self.target_easing 
                --print("Number " .. self.value .. "y: " .. self.y .. "/" .. self.target_y )
            end
        else
            if self.y - self.target_y  < self.threshold_movement then
                self.y = self.target_y
            else
                self.y = self.y + (self.target_y - self.y)  / self.target_easing 
                --print("Number " .. self.value .. "y: " .. self.y .. "/" .. self.target_y )
            end
        end

       
        --LuaDrawing_set_color(COLORS[self.value].r, COLORS[self.value].g, COLORS[self.value].b, 255)        
        -- LuaDrawing_set_color(30, 30, 30, 255)        
        
        -- LuaDrawing_fill_rect(
        --     math.floor(self.camera:get_x(self.x+1)), 
        --     math.floor(self.camera:get_y(self.y+1)), 
        --     math.floor(self.camera:get_width(self.w-2)), 
        --     math.floor(self.camera:get_height(self.h-2))
        -- )
        
        -- local x = 0
        -- local y = 0
        -- --print(self.value)
        -- if not (self.digits == nil) then
        --     for k, d in pairs(self.digits) do--TODO: caching                     
        --         LuaDrawing_render_label(
        --             tostring(d),
        --             math.floor(self.camera:get_x(self.x + 6 + x)),               
        --             math.floor(self.camera:get_y(self.y + 6 + y)),
        --             --
        --             -- TODO: size scale 
        --             --
        --             --
        --             0--background ON
        --         )  
        --         --break                
        --         x = x + self.fontsize
        --         -- if x > self.w then
        --         --     x = 0
        --         --     y = y +  self.fontsize
        --         -- end
        --     end 
        -- end 
        
        if self.hidden == true then
            do return end
        end       
       
      
        LuaDrawing_clip(self.clip_x, self.clip_y, self.clip_w, self.clip_h)
        LuaDrawing_clop_render(
            0,
            math.floor(self.camera:get_x(self.x)), 
            math.floor(self.camera:get_y(self.y)), 
            math.floor(self.camera:get_width(self.w)), 
            math.floor(self.camera:get_height(self.h)), 
            false
        )
    end,

    check_division = function(self, e)        
        if (self.value > 1) and (e.value > 1) then          
            if self.value > e.value then
                return self.value % e.value 
            else
                return e.value % self.value 
            end
        else
            return nil
        end
    end,

    set_camera = function(self, camera)
        self.camera = camera
        if (camera == nil) then
            print("Number error: no camera")
        end
    end,
    
    divide_by = function (self, e)           
        local result = false  
        local remainder = self:check_division(e)
        if not (remainder == nil) then
            if(remainder < 1) then
                local new_value = math.floor((self.value - remainder) / e.value)
                if e.value > self.value then
                    new_value = math.floor((e.value - remainder) / self.value)
                end
                self:update_value(new_value)  
                e:update_value(remainder) 
                
                --e.parent:remove(e)                                          
                result = true
            end
            --print(self.value)
            --print(e.value)
            --print("------------------------")
        end
        return result
    end,

    move_to = function(self, x, y)
        self.target_x = x
        self.target_y = y
    end,

    warp = function(self)
        self.x = self.target_x
        self.y = self.target_y
    end,
    
    init = function(self)--, max_value, container)
        -- if max_value == nil then
        --     max_value = 10
        -- end                
      
        self.type    = "number"
        self.x       = 0--math.random(0, 200)
        self.y       = 0--math.random(0, 200) 
        self.target_x= self.x
        self.target_y= self.y
        self.target_easing= 1
        
        --sprite lib
        self.tiles_per_row = 20
        self.tiles_per_column = 10
        self.clip_x  = 0
        self.clip_y  = 0
        self.clip_w  = 128
        self.clip_h  = 208
        
        self.r       = 1
        self.w       = self.r
        self.h       = self.r
        self.id      = 0

        self.threshold_movement = 2.0
        self.max_easing = 4

       
        self.speed_y = 0
        
        self.value   = 0
        self.last_value = self.value

        return true
    end,

    new = function(self)
        object = {}
        setmetatable(object, self)
        self.__index = self
        --object:init()
        return object
    end
}
--------------------- slot.lua ---------------------
Slot = {
    states = {
        READY = 1,
        EMPTY = 2,
    }, 

    direction = {
        north = 1,
        east = 2,
        south = 3,            
        west = 4
    },
    column_number = 0,
    row_number = 0,

    run = function(self)   
        self.number:run()
    
        -- LuaDrawing_set_color(255, 0, 0, 125)        
        -- LuaDrawing_draw_rect(
        --     math.floor(self.x), 
        --     math.floor(self.y), 
        --     math.floor(self.w), 
        --     math.floor(self.h)
        -- ) 
    end,

   
    init = function(self)
        self.type    = "slot"
        self.x       = 0--math.random(0, 200)
        self.y       = 0--math.random(0, 200)         
        self.w       = 1
        self.h       = 1 
        self.neighbours = {}

        self.id = 0

        self.number  = nil      

        self.state   = self.states.READY       

        return true
    end,

    
    add_neighbour = function (self, neighbour)        
        if self:is_neighbour_of(neighbour) == false then
            table.insert(self.neighbours, neighbour)
            return true            
        else
            return false
        end
    end, 
    
    get_neighbour = function (self, dir) 
        local result = nil         
        for c, n in pairs(self.neighbours) do
            if ((dir == self.direction.north) and (n.y < self.y))
            or ((dir == self.direction.south) and (n.y > self.y)) 
            or ((dir == self.direction.west)  and (n.x > self.x)) 
            or ((dir == self.direction.east)  and (n.x < self.x)) then
                result = n
                break
            end
        end
        return result
    end,

    is_neighbour_of = function (self, neighbour)
        local result = false
        if not (neighbour == self) then                 
            for b, n in pairs(self.neighbours) do
                if neighbour == n then
                    result = true
                    break
                end
            end            
        end  
        return result
    end,


    swap_with = function(self, neighbour, easing)
        if self == neighbour then
            do return end
        end
        if (easing == nil) or (easing < 0) then
            easing = 0
        end
        if easing <= self.number.max_easing then
            self.number.target_easing = self.number.max_easing - easing
        else
            self.number.target_easing = self.number.max_easing
        end
        if easing <= neighbour.number.max_easing then
            neighbour.number.target_easing = neighbour.number.max_easing - easing
        else
            neighbour.number.target_easing = neighbour.number.max_easing
        end
        
        self.number, neighbour.number = neighbour.number, self.number        
        self.number.target_x, neighbour.number.target_x = neighbour.number.target_x, self.number.target_x
        self.number.target_y, neighbour.number.target_y = neighbour.number.target_y, self.number.target_y        
    end,


    reset_number = function(self, min, max, easy)
        self.number:init()
        local digit_sum = self.number:update_value(math.random(min, max))    

        local const number_easy = min*3
        
        if not (easy == nil) then
            if self.number:is_prime() == true then
                local dicide = math.random(1, 6)
                if dicide > 3 then
                    self.number:update_value(math.random(min, number_easy))
                end
            end

            -- if digit_sum == 5 then
            --     self.number:update_value(math.random(min, number_easy))
            --     --print("Slot: 5")
            -- end  
            -- if digit_sum == 7 then
            --     self.number:update_value(math.random(min, number_easy))
            --     --print("Slot: 7")
            -- end 
            -- if digit_sum == 11 then
            --     self.number:update_value(math.random(min, number_easy))
            --     --print("Slot: 11")
            -- end  
            -- if digit_sum == 6 then
            --     self.number:update_value(math.random(min, number_easy))
            --     --print("Slot: 6")
            -- end
            -- if digit_sum == 15 then
            --     self.number:update_value(math.random(min, number_easy))
            --     --print("Slot: 15")
            -- end
            -- if digit_sum == 16 then
            --     self.number:update_value(math.random(min, number_easy))
            --     --print("Slot: 16")
            -- end
        end

        self.number.w = self.w
        self.number.h = self.h
        self.number:move_to(self.x, self.y)                    
        self.number:warp()
    end,
    
    print = function(self)
        print("Slot #" .. tostring(self))
        print("\t x:" .. self.x .. "; y:" .. self.y) 
        print("\tNeighbours:")
        --local dir = self.direction.west

        for c, n in pairs(self.neighbours) do           
            print("\t\t ".. c .." (" .. tostring(n) ..") x:" .. n.x .. "; y:" .. n.y)              
            -- if ((dir == self.direction.north) and (n.y < self.y))
            -- or ((dir == self.direction.south) and (n.y > self.y)) 
            -- or ((dir == self.direction.west)  and (n.x > self.x)) 
            -- or ((dir == self.direction.east)  and (n.x < self.x)) then
            --     print("\t\t\t WEST")
                
            -- end
        end
    end,
            

    new = function(self)
        object = {}
        setmetatable(object, self)
        self.__index = self
        object:init()
        return object
    end
}

Game = {
    type = "game",

    modes = {
        CASUAL = 0,
        COMPETITIVE = 1,                
    },
       
    points = 0, 
    
    scene = nil,
    camera = nil,

    notify = function(self, type, e)
        if type == Subscription.type.GAME_OVER then
            --self:over(self.control:get_score(), self.control:get_highscore())
            if self.mode == self.modes.CASUAL then
                self.input:tabula_rasa()
            end
        elseif type == Subscription.type.LEVEL_BROKEN then
            --self:over(self.control:get_score(), self.control:get_highscore())
        
        elseif type == Subscription.type.WRONG_SWAP then
            Sound_wrong_swap()--print("Input: penalty for wrong swap!")
        elseif type == Subscription.type.SWAP then
            Sound_plus(true)--reset sound counter !!!     
        elseif type == Subscription.type.SELECT then
            Sound_swap()--click sound          
        elseif type == Subscription.type.SCORE then
            Sound_plus() 
        elseif type == Subscription.type.NUMBER_DAMAGED then
            Sound_minus()        
        elseif type == Subscription.type.LOADING_CONTINUES then    
            Sound_move()--print("Input swapping " .. n.id .. " with " .. s.id)
        
        elseif type == Subscription.type.LEVEL_UP then
           -- self.control:level_up()
            --self.bug:reset(self.control:get_level())
           -- if self.control:get_level() > 1 then
            --   print("Input level is now " .. self.control:get_level())                
           --     Sound_level_up()
          --  end

           -- if self.input:reset(self.control:get_level()) == false then
                --//////////////////////////////////////////////////--
            --  if Subscription.type.GAME_OVER == nil then
            --      print("Input warning: GAME_OVER is nil")
             -- else
            --      self.subscribers:notify(Subscription.type.GAME_OVER, nil, "(game line 64)")
            --  end               
              --//////////////////////////////////////////////////--
          --end
            
        --     self.particles:reset( self.x + self.w, self.y, math.random(10, 100))
        --     self.particles:reset( self.x, self.y, math.random(10, 100))
        --     self.particles:reset( self.x + self.w, self.y+self.h, math.random(10, 100))
        --     self.particles:reset( self.x, self.y+self.h, math.random(10, 100))           
        -- end 
        elseif type == Subscription.type.DONE_LOADING then
            Sound_move(true)--reset sound counter   
        end
    end,

    init = function(self)
        self.mode = self.modes.CASUAL

        self.width = SCREEN_WIDTH
        self.height= SCREEN_HEIGHT
        
        --  self.state = self.states.starts 
        --self.cursor = Cursor:new()

        self.tick_start = ticks() 

        self.camera = Camera
        
        -- self.input_width  = self.width
        -- self.input_height = self.height - math.floor(self.height * 0.2)

        Camera:init(self.width, self.height, nil)  
        --Camera:set_focus(self.cursor)      
        
        self.name = "Game"        
     
        self.w = self.width
        self.h = self.height
        self.x = 0
        self.y = 0
        

        self.subscribers = Subscription:new()
        self.subscribers:init()

        --self.control = Control:new()
        --self.control:init()    
                
        self.input = Input:new()  
        self.input.subscribers = self.subscribers
        self.input:init(self) 
        
        --self.bug = Bug:new()
        --self.bug.subscribers = self.subscribers
        --self.bug:init(self.input)   

        self.subscribers:add(self.input)
        self.subscribers:add(self)
        self.subscribers:add(self.control)
        --self.subscribers:add(self.bug)
      

        self.subscribers:notify(
            Subscription.type.LEVEL_UP, 5
        )
                 
        return true
    end,

    touch = function(self, x, y) 
        if self.state == self.states.run then   
            self.input:touched(
                self.camera:reverse_x(x), 
                self.camera:reverse_y(y)
            )
        elseif self.state == self.states.starts then
            self.state = self.states.run
        end
    end,
    --     for k, e in pairs(self.life) do
    --         if (not (e.touch == nil)) and (e:touch(x, y) == true) then
    --             break
    --         end
    --     end            
    -- end,
    
    clicked = function(self, x, y)
           
            --if (not (self.control.clicked == nil) and (self.control:clicked(x, y) == false) ) then 
                self.input:clicked(
                    self.camera:reverse_x(x), 
                    self.camera:reverse_y(y)
                )
            --end 
        
    end, 

    --move = function(self, x, y)--MOUSE    
    --    self.cursor:move_to(x, y)
    --end,

    run = function(self) 
       
            LuaDrawing_set_color(0, 0, 0, 255)        
            LuaDrawing_fill_rect(0, 0, self.w, self.h) -- clear background     
            
            self.input:run()
            --self.control:run()--(render)    
           -- self.bug:run()         
            --self.cursor:run()
            self.camera:run()   
    
       
    end,

    close = function(self)
       
    end,

    print = function(self)
        print(self.name .. " (" .. self.type .. " » " .. tostring(self) .. ")")
        for k, e in pairs(self.life) do
                print("\t" .. e.type .. " (" .. tostring(e) .. ")")
                if not (e.print == nil) then
                e:print("\t\t")
                end
        end
    end,

}
--------------------- menu.lua ---------------------
Menu = {
    type = "Menu",   
    labels = {},

    notify = function(self, type, e)
        if type == Subscription.type.Menu_OVER then          
        elseif type == Subscription.type.LEVEL_BROKEN then      
        end
    end,

    add_label = function(self, text)
        LuaDrawing_add_label(text, 0, 0)
        LuaDrawing_render_label(text, 0, 0, 0) -- x, y, background OFF
        local id = LuaDrawing_get_ID(text)
        local box = {LuaDrawing_get_label_dimensions(id)}
        if (box == nil) or (#box < 4) then
            print("Menu error: could not add label")
            return 0
        else
            local x = math.floor(self.x + (self.w - box[3]) / 2 ) -- center
            local y = math.floor(self.y + (self.h - box[4]) / 2 )
            table.insert(self.labels, {
                id = id, 
                text = text,
                x =  x, 
                y =  y, 
                w = box[3], 
                h = box[4]
            })
            LuaDrawing_render_label(text, x, y, 0)--save position
            return id
        end
    end,

    init = function(self)
        self.width = SCREEN_WIDTH
        self.height= SCREEN_HEIGHT

        self.name = "Menu"        
     
        self.w = self.width
        self.h = self.height
        self.x = 0
        self.y = 0

        LuaDrawing_set_color(255, 255, 255, 255) --white
        self:add_label("TÄST")
                 
        return true
    end,

    touch = function(self, x, y) 
    end,
    
    clicked = function(self, x, y)
        if self.state == self.states.run then 
        end
    end, 

    run = function(self) 
        LuaDrawing_set_color(255, 0, 0, 255)        
        LuaDrawing_fill_rect(0, 0, self.w, self.h) -- clear background     
    
        for k, l in pairs(self.labels) do
            LuaDrawing_re_render_label(l.id)
        end            

        --[[
        elseif self.state == self.states.over then
            LuaDrawing_render_label(
                "Menu OVER",               -- TODO: Caching
                math.floor(self.x +50),               
                math.floor(self.y + 50),
                0--background ON
            )  
            LuaDrawing_render_label(
                "Score",               -- TODO: Caching
                math.floor(self.x + 75),               
                math.floor(self.y + 75),
                0--background ON
            )  
            local x = 200
            local y = 75
            if not (self.score_digits == nil) then
                for k, d in pairs(self.score_digits) do--TODO: caching                     
                    LuaDrawing_render_label(
                        tostring(d),
                        math.floor(self.x + 6 + x),               
                        math.floor(self.y + 6 + y),
                        0--background ON
                    )                                  
                    x = x + 12
                end 
            end     
        end --]]--
    end,

    pause = function(self)      
    end,

    close = function(self, score, highscore)
        if self.state == self.states.over then 
            do return end 
        end
               
        self.state = self.states.over 
        
        self.score_digits = nil
        if not (score == nil) then
            local t = score       
            local remainder = 0
            self.score_digits = {}--clear       
            local digit_sum = 0
            while t > 0 do        
                remainder = t % 10
                table.insert(self.score_digits, 1, remainder)
                digit_sum = digit_sum + remainder
                t = math.floor(t / 10)
            end
        end

        print("Menu: over")
        if not (score == nil) then
            print("\t Score    :\t".. score)
        end
        if not (highscore == nil) then
            print("\t Highscore:\t".. highscore)        
        end
       
        print("...........................................................")
        local t = ticks() - self.tick_start
        print("\t Time played:\t"..math.floor(t/(1000*60)) .." minutes "..math.floor((t/1000)%60).." seconds.")
        print("...........................................................")
    end,

    print = function(self)
        print(self.name .. " (" .. self.type .. " » " .. tostring(self) .. ")")
        for k, e in pairs(self.life) do
                print("\t" .. e.type .. " (" .. tostring(e) .. ")")
                if not (e.print == nil) then
                e:print("\t\t")
                end
        end
    end,

}

COLORS = {}
Ticks = 0
Screen = nil

function APP_INIT()
    math.randomseed(os.time()) 

    Ticks = ticks()

    for i=0,255 do
        local color = {}
        color.r = math.floor(math.random(0, 255))
        color.g = math.floor(math.random(0, 255))
        color.b = math.floor(math.random(0, 255))
        --color.b = math.floor(math.random() *125 + math.random() *125)
        table.insert(COLORS, color)
    end
    
    if LuaDrawing_setup_ttf("monoflow-regular.otf", 24) == false then
        print("Lua-Error: Could NOT setup TTF!")
    end
    
    if SPRITE_LIBRARY == nil then
        SPRITE_LIBRARY = "gfx/"
    end
    if LuaDrawing_load_image(SPRITE_LIBRARY .. "library01.gif") == false then
        print("App error: could NOT load graphic-library")
    end

    Sound_load()
    --Game:init()
    Menu:init()

    Screen = Menu
  
    --[[for i=0, 9 do
        local id = LuaDrawing_add_label(tostring(i), 0, 0)
       if id == 0 then
            print("App error: Could NOT add label '"..i.."'!")            
        end          
   end--]]--

    -- int LuaDrawing_clip(lua_State *L) {
    --     if (not L) return 0;
    --     Spritesheet.clip(
    --       (int)lua_tointeger(L, 1),
    --       (int)lua_tointeger(L, 2),
    --       (int)lua_tointeger(L, 3),
    --       (int)lua_tointeger(L, 4));
    --     return 0;
    --   }
      
    --   int LuaDrawing_clop(lua_State *L) {
    --     if (not L) return 0;
    --     Spritesheet.clop(
    --       (int)lua_tointeger(L, 1),
    --       (int)lua_tointeger(L, 2),
    --       (int)lua_tointeger(L, 3),
    --       (int)lua_tointeger(L, 4));
    --     return 0;
    --   }
      
    --   int LuaDrawing_load_image(lua_State *L) {
    --     if (not L) return 0;
      
    --     Spritesheet.set_renderer(Renderer);
      
    --     const std::string file{lua_tostring(L, 1)};
    --     lua_pushboolean(L, Spritesheet.load(file));
    --     return 1;
    --   }
   
end

function APP_RUN()
    Screen:run()
end

function APP_MOUSE_TOUCHED(x, y)    
    Screen:touch(x, y)    
end

function APP_MOUSE_CLICKED(x, y)
    Screen:clicked(x, y)    
end

function APP_PAUSE()
end


function APP_END()
end
