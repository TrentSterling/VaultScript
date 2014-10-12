
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )     
include( "conditions.lua" )

function ENT:Initialize()
	self:SetSolid( SOLID_BBOX )
	self:SetMoveType( MOVETYPE_STEP ) 
	
	self:SetNPCState( NPC_STATE_IDLE )
	
	self:SetMaxYawSpeed( 5000 ) 
	
	self:SetDefaultHealth( 100 )
end

function ENT:SetDefaultHealth( NewValue )
	self:SetNWInt( "MaxHealth", NewValue )
	self:SetMaxHealth( self, NewValue )
	self:SetHealth( NewValue )
end

function ENT:SetArmor( NewValue )
	self:SetNWInt( "Armor", NewValue )
end

function ENT:SetMaxArmor( NewValue )
	self:SetNWInt( "MaxArmor", NewValue )
end

function ENT:Alive()
	return self:GetNPCState() != NPC_STATE_DEAD
end

function ENT:Kill()
	self:SetNPCState( NPC_STATE_DEAD )
	self:SetSchedule( SCHED_DIE_RAGDOLL )
end

function ENT:OnTakeDamage( DamageInfo )
    local NewHealth = self:Health() - DamageInfo:GetDamage() 
  
    if NewHealth <= 0 then 
        self:Kill()
    end 
    
    self:SetHealth( NewHealth )
end

function ENT:DoFace( Position )
	self:SetLastPosition( Position )
	local Schedule = ai_schedule.New( "Face" )
	Schedule:EngTask( "TASK_STOP_MOVING" )
	Schedule:EngTask( "TASK_FACE_LASTPOSITION" )
	self:StartSchedule( Schedule )
end

function ENT:DoUse( Target )
	self:SetTarget( Target )
	local Schedule = ai_schedule.New( "UseSomething" )
	Schedule:EngTask( "TASK_SCRIPT_RUN_TO_TARGET" )
	Schedule:EngTask( "TASK_FACE_TARGET" )
	Schedule:AddTask( "Use" )
	self:StartSchedule( Schedule )
end

function ENT:DoOpenDoor( Target )
	self:SetTarget( Target )
	local Schedule = ai_schedule.New( "OpenDoor" )
	Schedule:EngTask( "TASK_SCRIPT_RUN_TO_TARGET" )
	Schedule:EngTask( "TASK_FACE_TARGET" )
	Schedule:AddTask( "OpenDoor" )
	self:StartSchedule( Schedule )
end

function ENT:DoMove( Target )
	self:SetTarget( Target )
	local Schedule = ai_schedule.New( "RunTo" )
	//Schedule:EngTask( "TASK_GET_PATH_TO_TARGET" )
	//Schedule:EngTask( "TASK_RUN_PATH" )
	Schedule:EngTask( "TASK_SET_ROUTE_SEARCH_TIME", 4 )
	Schedule:EngTask( "TASK_SCRIPT_RUN_TO_TARGET" )
	Schedule:EngTask( "TASK_WAIT_FOR_MOVEMENT" )
	self:StartSchedule( Schedule )
end

function ENT:DoMeleeAttack( Target )
	self:DoAttackSchedule( Target, "TASK_MELEE_ATTACK1" )
end

function ENT:DoRangeAttack( Target )
	self:DoAttackSchedule( Target, "TASK_RANGE_ATTACK1" )
end

function ENT:GoToSleep(  )
	self:DoAttackSchedule( Target, "TASK_RANGE_ATTACK1" )
end

function ENT:DoAttackSchedule( Target, Task )
	local Schedule = ai_schedule.New( "Attack" )

	self:SetEnemy( Target, true )

	self:UpdateEnemyMemory(Target, Target:GetPos())
	Schedule:EngTask( Task, 0 )
	self:StartSchedule( Schedule )
end

function ENT:TaskStart_OpenDoor( Data ) end
function ENT:Task_OpenDoor( Data )
	local Target = self:GetTarget()
	if ValidEntity( Target ) and Target.Fire then
		Target:Fire( "open" )
	end
	self:TaskComplete()
end

function ENT:TaskStart_Use( Data ) end
function ENT:Task_Use( Data )
	local Target = self:GetTarget()
	if ValidEntity( Target ) and Target.Fire then
		Target:Fire( "use" )
	end
	self:TaskComplete()
end

function ENT:SelectSchedule() 
	// This is entirely manual
end
--self.LastPosition = Vector(0,0,10000)
local LastHealthUpdate
function ENT:Think()
	if not LastHealthUpdate or ( LastHealthUpdate + 0.25 < CurTime() ) then
		LastHealthUpdate = CurTime()

		if not self.LastHealth or ( self.LastHealth != self:Health() ) then
			self:SetNWInt( "NPCHealth", self:Health() )
			self.LastHealth = self:Health()
		end

		if not self.LastMaxHealth or ( self.LastMaxHealth != self:GetMaxHealth() ) then
			self:SetNWInt( "NPCMaxHealth", self:GetMaxHealth() )
			self.LastMaxHealth = self:GetMaxHealth()
		end
	end
		
	--ADD A FOLLOWER CODE HERE
	if(math.random(0,4) > 1)then
		if ( self.LastTargetedPlayer ) then
			if( self:GetPos():Distance(self.LastTargetedPlayer:GetPos()) > 200 && self:GetPos():Distance(self.LastTargetedPlayer:GetPos()) < 512 )then
				
					--if( self.LastPosition():Distance(self.LastTargetedPlayer:GetPos()+self.LastTargetedPlayer:GetForward()*-60) > 200 )then
						self:SetLastPosition( self.LastTargetedPlayer:GetPos()+self.LastTargetedPlayer:GetForward()*-60 + Vector(math.random(-30,30), math.random(-30,30), math.random(30, 30)) )
						self.LastPosition = self.LastTargetedPlayer:GetPos()+self.LastTargetedPlayer:GetForward()*-60 + Vector(math.random(-30,30), math.random(-30,30), math.random(30, 30))
						self:SetSchedule( SCHED_FORCED_GO_RUN )
						print("********** DISTANCE " .. self:GetPos():Distance(self.LastTargetedPlayer:GetPos()) .. "\n")
					--end
				
			end
		end
	end
		
	self:NextThink( CurTime() + 0.05 )

end

function ENT:OnCondition( Condition )
	//if Condition == COND_IN_PVS then return end
	//ErrorNoHalt( "Condition ", self:ConditionName( Condition), "(", Condition, ")\n" )
	
	if Condition == COND_NO_PRIMARY_AMMO then
		--self:SetSchedule( SCHED_RELOAD )
	end

	
end



function ENT:TaskStart_OpenDoor2( data ) 

	self:SetNPCState( NPC_STATE_SCRIPT )
	self:SetSequence( data.Name )
	SequenceID = self:SetPlaybackRate( data.Speed )


end
function ENT:Task_OpenDoor2( Data )
	--self:SetNPCState( NPC_STATE_SCRIPT )
	--self:SetSequence( "Sit_Ground" )
	--self:TaskComplete()
end
