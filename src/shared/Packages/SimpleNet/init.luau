local RunService = game:GetService("RunService")

local Client = script.Client
local Server = script.Server
local Bindable = script.Bindable

local SimpleNet = {}

function SimpleNet:remoteEvent(name: string)
	local RunContext = RunService:IsServer() and Server or Client
	name = "RE/" .. name
	if RunService:IsServer() then
		local remoteEvent = script:FindFirstChild(name)
		if not remoteEvent then
			remoteEvent = Instance.new("RemoteEvent")
			remoteEvent.Name = name
			remoteEvent.Parent = script
		end
		return require(RunContext.RemoteEvent).new(remoteEvent)
	else
		local remoteEvent = script:WaitForChild(name, 10)
		if not remoteEvent then
			error("Failed to find RemoteEvent: " .. name, 2)
		end
		return require(RunContext.RemoteEvent).new(remoteEvent)
	end
end

function SimpleNet:remoteFunction(name: string)
	local RunContext = RunService:IsServer() and Server or Client
	name = "RF/" .. name
	if RunService:IsServer() then
		local remoteFunction = script:FindFirstChild(name)
		if not remoteFunction then
			remoteFunction = Instance.new("RemoteEvent")
			remoteFunction.Name = name
			remoteFunction.Parent = script
		end
		return require(RunContext.RemoteFunction).new(remoteFunction)
	else
		local remoteFunction = script:WaitForChild(name, 10)
		if not remoteFunction then
			error("Failed to find RemoteFunction: " .. name, 2)
		end
		return require(RunContext.RemoteFunction).new(remoteFunction)
	end
end

function SimpleNet:bindableEvent(name: string)
	name = "BE/" .. name
	local bindableEvent = script:FindFirstChild(name)
	if not bindableEvent then
		bindableEvent = Instance.new("BindableEvent")
		bindableEvent.Name = name
		bindableEvent.Parent = script
	end
	return require(Bindable.BindableEvent).new(bindableEvent)
end

function SimpleNet:bindableFunction(name: string)
	name = "BF/" .. name
	local bindableFunction = script:FindFirstChild(name)
	if not bindableFunction then
		bindableFunction = Instance.new("BindableFunction")
		bindableFunction.Name = name
		bindableFunction.Parent = script
	end
	return require(Bindable.BindableFunction).new(bindableFunction)
end

return SimpleNet
