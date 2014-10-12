EFFECT.hEnt = nil
EFFECT.setup = false

local Life = 0.5

EFFECT.SpawnedTime = 0

EFFECT.irSzCo = 0.8

local refRing = Material("particle/particle_ring_refract_01")
local smGlo = Material("sprites/bh-smoothglow")

function EFFECT:Init(data)
	self.hEnt = data:GetEntity()
	self.Entity:SetPos(self.hEnt:GetPos())
	refRing:SetMaterialFloat("$refractamount",-0.05)
	self.SpawnedTime = CurTime()
	self.irSzCo = 0.7 + math.random() * 0.2
	self.setup = true
end

function EFFECT:Think()
	if self.setup && (!(self.hEnt && self.hEnt:IsValid()) || CurTime() > self.SpawnedTime + Life) then return false end
	self.Entity:SetPos(self.hEnt:GetPos())
	return true
end

function EFFECT:Render()
	if !self.setup then return end
	render.UpdateRefractTexture()
	local tFrac = (CurTime() - self.SpawnedTime) / Life
	local rSz = 60 + tFrac * 100
	refRing:SetMaterialFloat("$refractamount",-0.15 + 0.15 * tFrac)
	render.SetMaterial(refRing)
	render.DrawSprite(self.hEnt:GetPos(),rSz*self.irSzCo,rSz*self.irSzCo,Color(255,255,255,255))
	
	refRing:SetMaterialFloat("$refractamount",-0.3 + 0.3*tFrac)
	render.SetMaterial(refRing)
	render.DrawSprite(self.hEnt:GetPos(),rSz,rSz,Color(255,255,255,255))
	
	render.SetMaterial(smGlo)
	local gSz = 120 - tFrac * 80
	render.DrawSprite(self.hEnt:GetPos(),gSz,gSz,Color(0,0,0,255))
end
