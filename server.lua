RegisterServerEvent('buy:cav')
AddEventHandler('buy:cav', function(price,horse)
    TriggerEvent('redemrp:getPlayerFromId', source, function(user,data)
    local currentMoney = user.getMoney()
    if currentMoney >= price then
        TriggerEvent('redemrp:getPlayerFromId', source, function(user,data)
          user.removeMoney(price)
        end)
        TriggerClientEvent('loadcav', source, horse)
    else
        TriggerClientEvent('cancel', source)
    end
    end)
end)