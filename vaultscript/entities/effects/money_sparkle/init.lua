EFFECT.Pl = nil
EFFECT.SpawnedTime = 0
EFFECT.lastEmd = 0

EFFECT.Color = 1

EFFECT.Colors = {{255,60,20},{255,140,20},{100,255,20},{20,215,160},{20,120,255},{100,20,225}}
EFFECT.ColorVars = {{0,40,20},{0,60,20},{90,0,20},{20,40,60},{20,100,0},{40,20,30}}

local glo = Material("sprites/sparkle")

function EFFECT:Init(data)
		self.Color = math.floor(data:GetMagnitude() + 0.5)
		self.SpawnedTime = CurTime()
	self.Ready = true
end

function EFFECT:Think()
		local ePos = self:GetPos()
		local emtr = ParticleEmitter(ePos,false)
			local part = emtr:Add("sprites/sparkle",ePos)
			if part then
				part:SetVelocity(Vector(math.random(-5,5),math.random(-5,5),0))
				part:SetLifeTime(0)
				part:SetDieTime(2.2)
				part:SetStartSize(3 + math.random() * 2)
				part:SetEndSize(0.5)
				part:SetStartAlpha(255)
				part:SetEndAlpha(0)
				part:SetRoll(math.random() * 360)
				part:SetRollDelta((math.random() * .5 + .5) * (math.random() * 2 - 1) * 90)
				part:SetAirResistance(1)
				part:SetGravity(Vector(0,0,30))
				part:SetCollide(true)
				part:SetBounce(0.6)
				
				part:SetColor(0,255,0,255)
			end
end

function EFFECT:Render()

end
