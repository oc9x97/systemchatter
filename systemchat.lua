local replicatedStorage = game:GetService("ReplicatedStorage")
local marketplaceService = game:GetService("MarketplaceService")
local userInterfaceService = game:GetService("UserInputService")

-- Get the game title
local gameTitle = marketplaceService:GetProductInfo(game.PlaceId).Name

-- Create a screen GUI
local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false -- This prevents the GUI from resetting when a new character spawns
gui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

-- Create a frame for the GUI
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.3, 0, 0.3, 0)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.new(1, 1, 1)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.new(0, 0, 0)
frame.Parent = gui

-- Create a text label at the top middle
local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 0.1, 0)
textLabel.Position = UDim2.new(0, 0, 0, 0)
textLabel.Text = "System Chatter by oc9x97" -- Your label text
textLabel.TextSize = 20 -- Adjust the font size as needed
textLabel.Parent = frame

-- Create a text input box for the custom message
local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0.8, 0, 0.4, 0)
textBox.Position = UDim2.new(0.1, 0, 0.2, 0)
textBox.PlaceholderText = "Enter your custom message here"
textBox.Parent = frame

-- Create a send button
local sendButton = Instance.new("TextButton")
sendButton.Size = UDim2.new(0.3, 0, 0.2, 0)
sendButton.Position = UDim2.new(0.35, 0, 0.6, 0)
sendButton.Text = "Send"
sendButton.Parent = frame

-- Create a close button
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0.1, 0, 0.1, 0)
closeButton.Position = UDim2.new(0.9, 0, 0, 0)
closeButton.Text = "X"
closeButton.BackgroundColor3 = Color3.new(1, 0, 0) -- Set the background color (the "X" button) to red
closeButton.Parent = frame

-- Function to send the message
local function sendMessage()
    local customMessage = textBox.Text
    local message = "Oh, Hello there everybody, how was y'all day today? Hope the best silly! {" .. gameTitle .. "} " .. customMessage
    local remoteEvent = replicatedStorage:WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest")
    local args = {
        [1] = message,
        [2] = "All"
    }
    remoteEvent:FireServer(unpack(args))
    textBox.Text = ""  -- Clear the input box
end

-- Function to close the UI
local function closeUI()
    gui:Destroy()
end

-- Connect the send button to the sendMessage function
sendButton.MouseButton1Click:Connect(sendMessage)

-- Connect the close button to the closeUI function
closeButton.MouseButton1Click:Connect(closeUI)

-- Draggable GUI
local isDragging = false
local offset = nil

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = true
        offset = frame.Position - UDim2.new(0, input.Position.X, 0, input.Position.Y)
    end
end)

userInterfaceService.InputChanged:Connect(function(input)
    if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        frame.Position = UDim2.new(0, input.Position.X, 0, input.Position.Y) + offset
    end
end)

userInterfaceService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = false
    end
end)
