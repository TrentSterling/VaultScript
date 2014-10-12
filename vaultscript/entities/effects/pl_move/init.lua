EFFECT.Pl = nil
EFFECT.SpawnedTime = 0
EFFECT.lastEmd = 0

EFFECT.Color = 1

EFFECT.Colors = {{255,0,0,255},{0,255,0,255},{0,0,255,255},{255,255,0,255},{255,255,255,255}}
EFFECT.ColorVars = {{0,40,20},{0,60,20},{90,0,20},{20,40,60},{20,100,0},{40,20,30}}

local glo = Material("sprites/sparkle")


function EFFECT:Init(data)
	p = data:GetEntity()
	
	if p && p:IsValid() && p:IsPlayer() then
		self.Pl = p
		
		self.Color = 1
		if( data:GetMagnitude() > 1 )then
			self.Color = 2
		end
		if( data:GetMagnitude() > 2 )then
			self.Color = 3
		end
		if( data:GetMagnitude() > 3 )then
			self.Color = 4
		end
		if( data:GetMagnitude() > 4 )then
			self.Color = 5
		end
		
		self.SpawnedTime = CurTime()
	end
	self.Ready = true
	print(self.Color)
end

function EFFECT:Think()
	if(self.Pl == LocalPlayer())then
		local ePos = self:GetPos() + Vector(0,0,16)
		local emtr = ParticleEmitter(ePos,false)
		local part = emtr:Add("sprites/sparkle",ePos+VectorRand() * 4)
		if part then
			part:SetVelocity(Vector(0,0,0))
			part:SetLifeTime(0)
			part:SetDieTime(1.2)
			part:SetStartSize(30) --+ math.random() * 2)
			part:SetEndSize(0.5)
			part:SetStartAlpha(255)
			part:SetEndAlpha(0)
			--part:SetRoll(math.random() * 360)
			--part:SetRollDelta((math.random() * .5 + .5) * (math.random() * 2 - 1) * 90)
			part:SetAirResistance(220)
			part:SetGravity(Vector(0,0,0))
			part:SetCollide(true)
			part:SetBounce(0.6)
			
			part:SetColor(self.Colors[self.Color][1],self.Colors[self.Color][2],self.Colors[self.Color][3],self.Colors[self.Color][4])
		end
	end
end

function EFFECT:Render()

	

end






