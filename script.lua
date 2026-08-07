-- Tạo giao diện Nút Bật/Tắt (ON/OFF)
local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50) -- Màu đỏ (OFF)
ToggleButton.Position = UDim2.new(0.1, 0, 0.2, 0)
ToggleButton.Size = UDim2.new(0, 100, 0, 40)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Text = "AUTO: OFF"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 16.00
ToggleButton.Active = true
ToggleButton.Draggable = true -- Cho phép kéo thả nút trên màn hình

UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = ToggleButton

-- Biến trạng thái
local isRunning = false

-- Hàm đổi trạng thái Bật/Tắt khi bấm nút
ToggleButton.MouseButton1Click:Connect(function()
    isRunning = not isRunning
    if isRunning then
        ToggleButton.Text = "AUTO: ON"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50) -- Màu xanh (ON)
    else
        ToggleButton.Text = "AUTO: OFF"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50) -- Màu đỏ (OFF)
    end
end)

-- Script tự động click theo tọa độ trên Delta
local VIM = game:GetService("VirtualInputManager")

local function clickScreen(x, y)
    VIM:SendMouseButtonEvent(x, y, 0, true, game, 1)
    task.wait(0.05)
    VIM:SendMouseButtonEvent(x, y, 0, false, game, 1)
end

-- Vòng lặp chạy ngầm
task.spawn(function()
    while true do
        if isRunning then
            -- BƯỚC 1: Click vào mục "Vũ khí" (Ví dụ tọa độ X: 150, Y: 300)
            print("Bước 1: Chọn Vũ khí")
            clickScreen(150, 300) 
            task.wait(0.5)

            -- BƯỚC 2: Click vào Ô Vũ khí để rút ra (Ví dụ tọa độ X: 450, Y: 400)
            print("Bước 2: Rút vũ khí")
            clickScreen(450, 400)
            task.wait(0.5)

            -- BƯỚC 3: Click chuyển sang mục "Skin" (Ví dụ tọa độ X: 150, Y: 350)
            print("Bước 3: Chọn danh mục Skin")
            clickScreen(150, 350)
            task.wait(0.5)

            -- BƯỚC 4: Click chọn Skin muốn bỏ vào trade
            print("Bước 4: Thêm Skin")
            clickScreen(450, 400)
            
            task.wait(0.5)
        else
            task.wait(0.2) -- Đợi người dùng bật nút ON
        end
    end
end)
