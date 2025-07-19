addon.name = 'letmepaste'
addon.version = '0.1'
addon.author = 'looney'
addon.desc = 'let me /paste'
addon.link = 'https://github.com/loonsies/letmepaste'

local chat = require('chat')
local ctrlDown = false

ashita.events.register('key_data', 'key_data_cb', function (e)
    -- Ctrl keys
    if e.key == 0x1D or e.key == 0x9D then
        ctrlDown = e.down
    end

    -- V key
    if e.down and e.key == 0x2F and ctrlDown then
        local mgr = AshitaCore:GetInputManager()
        if mgr == nil then
            print(chat.header('letmepaste'):append(chat.error('GetInputManager returned an unexpected value.')))
            return
        end

        -- Validate the manager sub-objects..
        local k = mgr:GetKeyboard()
        if k == nil then
            print(chat.header('letmepaste'):append(chat.error('GetKeyboard returned an unexpected value.')))
            return
        end

        k:SetBlockBindsDuringInput(false)
        if k:GetBlockBindsDuringInput() ~= false then
            print(chat.header('letmepaste'):append(chat.error('GetBlockBindsDuringInput returned an unexpected value.')))
            return
        end
        AshitaCore:GetChatManager():QueueCommand(-1, '/paste')
        k:SetBlockBindsDuringInput(true)
        if k:GetBlockBindsDuringInput() ~= true then
            print(chat.header('letmepaste'):append(chat.error('GetBlockBindsDuringInput returned an unexpected value.')))
            return
        end
    end
end)
