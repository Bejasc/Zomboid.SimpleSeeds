function BejascSeeds_ReturnSeeds_Tomato(items, result, player)
    local item = "farming.TomatoSeed"
    local minSeeds = 2;
    local maxSeeds = 4;

    addSeeds(player, item, minSeeds, maxSeeds)
end


-----------------------------------------------------

--As a matter of balance, maxSeeds should not exceed the total number of seeds to plant a single plot. 
function addSeeds(player, item, minSeeds,maxSeeds)
    local numSeeds = minSeeds;

    local extraSeeds = getExtraSeeds(player, maxSeeds);

    numSeeds = numSeeds + extraSeeds;
    numSeeds = math.Clamp(numSeeds, minSeeds, 4);

    print(numSeeds .. " total Tomato seeds to be added.")

    for i=numSeeds, 1, -1 do
        player:getInventory():AddItem("farming.TomatoSeed");        					
    end
end

function getExtraSeeds(player, maxSeeds)
    local farmingLevel = player:getPerkLevel(Perks.Farming);
    print("The players farming level is " .. farmingLevel);

    local farmingLevelModifier = 0.03; --Chance of extra seed per farming level. TODO Make this a sandbox setting

    local modifier = (farmingLevel * farmingLevelModifier) * 100
    modifier = math.Clamp(modifier,farmingLevelModifier*100,80);

    local extraSeeds = 0

    for i=maxSeeds-1, 1,-1 do
        local rand = ZombRand(1,100)
        --print(rand .. " " .. modifier)
        if rand <= modifier then
            extraSeeds = extraSeeds+1;
        end
    end

    print (extraSeeds.." extra seeds given. Farming Level:"..farmingLevel..".  Chance for Extra Seeds:"..modifier.."% per seed (Up to "..(maxSeeds-1).." extra)")

    return extraSeeds;
end

function math.Clamp(val, min, max)
    return math.min(math.max(val, min), max)
end
