
function GetEntityByIndex(index)
	if(index != nil) then
		for k, v in pairs(ents.GetAll()) do
			if(string.find(v:EntIndex(), index) != nil) then
				return v
			end
		end
	end
	return nil
end

ChosenNPC = nil
ChosenNPCName = nil
ChosenNPCSaid = nil

Answer1 = nil
Answer2 = nil
Answer3 = nil
Answer4 = nil


AnswerID1 = nil
AnswerID2 = nil
AnswerID3 = nil
AnswerID4 = nil


Answer1EndChat = "0"
Answer2EndChat = "0"
Answer3EndChat = "0"
Answer4EndChat = "0"



function AddChatLine( data )

local NPCID = data:ReadString( )
local EntityID = data:ReadString( )
local NPCName = data:ReadString( )
local NPCSaid = data:ReadString( )
local NPCEntity = GetEntityByIndex(EntityID)
ChosenNPC = NPCEntity
ChosenNPCName = NPCName
ChosenNPCSaid = NPCSaid

Answer1 = data:ReadString( )
AnswerID1 = data:ReadString( )
Answer1EndChat = data:ReadString( )

Answer2 = data:ReadString( )
AnswerID2 = data:ReadString( )
Answer2EndChat = data:ReadString( )

Answer3 = data:ReadString( )
AnswerID3 = data:ReadString( )
Answer3EndChat = data:ReadString( )

Answer4 = data:ReadString( )
AnswerID4 = data:ReadString( )
Answer4EndChat = data:ReadString( )







print("ADD ANSWER " .. Answer1)
print("ADD ANSWER " .. Answer2)
print("ADD ANSWER " .. Answer3)
print("ADD ANSWER " .. Answer4)


print("ADD ANSWERID " .. AnswerID1)
print("ADD ANSWERID " .. AnswerID2)
print("ADD ANSWERID " .. AnswerID3)
print("ADD ANSWERID " .. AnswerID4)

print("AddChatLine " .. ChosenNPCSaid)

CreateNPCChatWindow()
end
usermessage.Hook( "startnpcchat", AddChatLine );


function CreateNPCChatWindow()

	if(NPCChatWindow)then
	NPCChatWindow:Remove()
	NPCChatWindow = nil
	return
	end
	NPCChatWindow = vgui.Create( "DFrame" )
	NPCChatWindow:SetTitle(ChosenNPCName);
	
	
	local mdlPanel = vgui.Create( "DModelPanel", NPCChatWindow )
	mdlPanel:SetSize( 250, 250 )
	mdlPanel:SetPos( 260, 20 )
	
	mdlPanel:SetModel( ChosenNPC:GetModel() )

	
	mdlPanel:SetAnimSpeed( 0.1 )
	mdlPanel:SetAnimated( true )
	mdlPanel:SetAmbientLight( Color( 50, 50, 50 ) )
	mdlPanel:SetDirectionalLight( BOX_TOP, Color( 255, 255, 255 ) )
	mdlPanel:SetDirectionalLight( BOX_FRONT, Color( 255, 255, 255 ) )
	mdlPanel:SetCamPos( Vector( 20, 0, 65) );
	mdlPanel:SetLookAt( Vector( 0, 0, 65) );
	mdlPanel:SetFOV( 70 );
	
	function mdlPanel:LayoutEntity(Entity)
		--self:RunAnimation();
		--Entity:SetAngles( Angle( 0, Entity:GetAngles().y+0.5, 0) )
	end

print("CreateNPCChatWindow " .. ChosenNPCSaid)

	local NPCSaidText = vgui.Create("DLabel", NPCChatWindow);
	NPCSaidText:SetPos(20,50);
	NPCSaidText:SetText(ChosenNPCSaid);
	NPCSaidText:SizeToContents()

	
	
	
	
	
	
	
	
	
	
	
	

	
	
	
	if(Answer1 != "BLANK ANSWER")then
	
	local Button1 = vgui.Create( "DButton", NPCChatWindow )
	Button1:SetText(">");
	Button1.DoClick = function()
		surface.PlaySound( "vaultscript/click.wav" )
		if(Answer1EndChat == "1")then
			NPCChatWindow:Remove()
			NPCChatWindow = nil
		end
	end
	Button1:SetPos( 20, 280);
	
	local Answer = vgui.Create("DLabel", NPCChatWindow);
	Answer:SetPos(130,280);
	Answer:SetText(Answer1);
	Answer:SizeToContents()
	
	end
	
	if(Answer2 != "BLANK ANSWER")then
	
	
	local Button2 = vgui.Create( "DButton", NPCChatWindow )
	Button2:SetText(">");
	Button2.DoClick = function()
		surface.PlaySound( "vaultscript/click.wav" )
		if(Answer2EndChat == "1")then
			NPCChatWindow:Remove()
			NPCChatWindow = nil
		end
	end
	Button2:SetPos( 20, 330);
	
	
	
	
	
	
	
	
	
	local Answer = vgui.Create("DLabel", NPCChatWindow);
	Answer:SetPos(130,330);
	Answer:SetText(Answer2);
	Answer:SizeToContents()
	
	
	
	end
	
	
	if(Answer3 != "BLANK ANSWER")then
	
	local Button3 = vgui.Create( "DButton", NPCChatWindow )
	Button3:SetText(">");
	Button3.DoClick = function()
		surface.PlaySound( "vaultscript/click.wav" )
		if(Answer3EndChat == "1")then
			NPCChatWindow:Remove()
			NPCChatWindow = nil
		end
	end
	Button3:SetPos( 20, 380);
	
	
	
	
	
	
	
	end
	
	
	
	
	
	if(Answer4 != "BLANK ANSWER")then
	
	local Answer = vgui.Create("DLabel", NPCChatWindow);
	Answer:SetPos(130,380);
	Answer:SetText(Answer3);
	Answer:SizeToContents()
	
	local Button4 = vgui.Create( "DButton", NPCChatWindow )
	Button4:SetText(">");
	Button4.DoClick = function()
		surface.PlaySound( "vaultscript/click.wav" )
		if(Answer4EndChat == "1")then
			NPCChatWindow:Remove()
			NPCChatWindow = nil
		end
	end
	Button4:SetPos( 20, 430);
	
	
	local Answer = vgui.Create("DLabel", NPCChatWindow);
	Answer:SetPos(130,430);
	Answer:SetText(Answer4);
	Answer:SizeToContents()
	
	
	end
	
	
	
	
	
	
	
	
	
	
	NPCChatWindow:SetSize( 520, 500 )
	NPCChatWindow:Center()	
	--NPCChatWindow:MakePopup()
	--NPCChatWindow:SetKeyboardInputEnabled( false )
	--NPCChatWindow:SetBackgroundBlur( true )
	NPCChatWindow:SetDraggable( false )
	NPCChatWindow:ShowCloseButton( false )
	NPCChatWindow:SetKeyboardInputEnabled( true )

end











