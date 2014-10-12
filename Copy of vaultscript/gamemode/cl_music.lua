
timer.Simple( 0, function() fadeoutsong() end )

function fadeoutsong()
		if(mysound)then
			mysound:FadeOut(5)
		end
	timer.Simple( 8, function() startsong() end )
end

songtoplay = "vaultscript/music/worldmap.mp3"
function startsong()
	if(mysound)then
		mysound:Stop()
	end
	mysound = CreateSound(ply, Sound( songtoplay ) )
	mysound:Play()
	timer.Simple( 180, function() fadeoutsong() end )--Timer time is song length
end
