
local StateMachine = StateMachine or require "lib/FSM/StateMachine"


function love.load()
  w,h = love.graphics.getDimensions()
  scene = StateMachine()
  scene:addState("playing", {enter = function ()
                            exit =  function ()
                                    end,
                            from = {"paused", "menu"}})
  scene:addState("menu", {enter = function ()
                                  end
                          exit = function ()
                                  end, 
                          from = {"playing", "splash"}})
  scene:addState("splash", {enter = function ()
                                      end,
                            exit = function ()
                                    end, 
                            from = "*"})
  scene:setInitialState("splash")
end



function love.update(dt)
  for _, v in ipairs(actorList) do
    v:update(dt)
  end
end

function love.draw()
  for _, v in ipairs(actorList) do
    v:draw()
  end
end
