-- Filter out unwanted extensions
mp.observe_property("playlist-count", "number", function()
    local playlist = mp.get_property_native("playlist")
    for i = #playlist, 1, -1 do
        local file = playlist[i].filename:lower()
        if file:match("%.jpg$") or file:match("%.jpeg$") or file:match("%.png$") then
            mp.commandv("playlist-remove", i - 1)
        end
    end
end)
