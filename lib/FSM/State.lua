Object = Object or require "lib/object"
local State = Object:extend()

function State:new(params)
	assert(params.name ~= nil, "You cannot have a State with a nil name.")

	self.name = params.name
	self.from = params.from
	self.enter = params.enter
	self.exit = params.exit
	self.parent = params.parent
end

function State:setParent(parent)
	self.parent = parent
	self.parent:addChildState(self)
end
	
function State:getRoot()
	local parentState = self.parent
	if parentState then
		while parentState.parent do
			parentState = parentState.parent
		end
	end
	return parentState
end
	
function State:getParents()
	local parents = {}
	local parentState = self.parent
	--print("State::getParents, name: ", self.name, ", parent: ", self.parent)
	if parentState ~= nil then
		table.insert(parents, parentState)
		while parentState.parent do
			parentState = parentState.parent
			table.insert(parents, parentState)
		end
	end
	return parents
end
	
function State:inFrom(stateName)
	--print("State::inFrom, my name: ", self.name, ", stateName: ", stateName, ", my from: ", self.from)
	--if self.from == nil then
	if self.parent ~= nil then
		--print("parent: ", self.parent.name, ", stateName: ", stateName)
		if self.parent.name == stateName then return true end
	end
	--end

	local from = self.from
	if type(from) == "string" then
		if from == stateName then
			return true
		else
			return false
		end
	elseif type(from) == "table" then
		local i = 1
		while from[i] do
			local name = from[i]
			if name == stateName then return true end
			i = i + 1
		end
		return false
	end
	return false
end

function State:isParentState(stateName)
	local parents = self:getParents()
	--print("$parents: ", #parents)
	if #parents > 0 then
		local p = 1
		while parents[p] do
			--print("\tname: ", parents[p].name)
			if parents[p].name == stateName then
				--print("\tfound: ", stateName, ", to match: ", parents[p].name)
				return true
			end
			p = p + 1
		end
	end
	return false
end

return State