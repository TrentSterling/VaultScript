charloaded = false
saves = {};

function AddSave( data )
local save = {}

local name = data:ReadString( )
local model = data:ReadString( )
if(name == "RECREATETABLE" && model == "RECREATETABLE")then
saves = {};--erase the save table!
return
end
	table.insert( save, name )--name
	table.insert( save, model )--model
	
	table.insert( saves, save )
	print("SAVE ADDED!")
end
usermessage.Hook( "save", AddSave );


function RemoveSave( data )

	local savetoremove = data:ReadString( )

	for k, v in pairs( saves ) do
		if ( v[1] == savetoremove ) then
			table.remove( saves, k )
			print("SAVE REMOVED!")
			SaveWindow:Remove();
			SaveWindow = nil;
			CreateSaveWindow()
			return--only 1
		end
	end
	print("SAVE CANT BE REMOVED BECAUSE IT WAS NOT FOUND!")
end
usermessage.Hook( "removesave", RemoveSave );











function ERightClick(mousecode, aimvec ) 
	if(charloaded == false)then
		if mousecode==107 then
			ply:ConCommand("cleartable" ) 
			CreateSaveWindow()
		end
	end
end
hook.Add("GUIMousePressed", "ERightClick", ERightClick)

models = {};

function AddModel( data )
	table.insert( models, data:ReadString( ) )
end
usermessage.Hook( "addmodel", AddModel );



function CreateSaveWindow()

	if(!ChosenModel)then
SetChosenModel( models[1] )
end
	if(SaveWindow) then
	return
	end
if not(#saves > 0)then

			CreateCharacterWindow()
			return
end

	surface.PlaySound( "vaultscript/menuclick.wav" )
	SaveWindow = vgui.Create( "DFrame" )
	SaveWindow:SetTitle("Select your character");
	
	
	if(#saves < 4)then
	
		local OkButton = vgui.Create("DButton", SaveWindow);
		OkButton:SetText("New");
		OkButton.DoClick = function()
		
			SaveWindow:Remove();
			SaveWindow = nil;
			CreateCharacterWindow()
			surface.PlaySound( "vaultscript/buttonclick.wav" )
		end
		OkButton:SetPos(230, 490);
	end
	
	
	lineheight = 20
	modelwidth = 0
	
	
	for k, v in pairs( saves ) do
if k == 3 then
	lineheight = 20
	modelwidth = 270
end
		local mdlPanel = vgui.Create( "DModelPanel", SaveWindow )
		mdlPanel:SetSize( 250, 250 )
		mdlPanel:SetPos( modelwidth, lineheight )
		
		mdlPanel:SetModel( v[2] )
		mdlPanel:SetAnimSpeed( 1.0 )
		mdlPanel:SetAnimated( true )
		mdlPanel:SetAmbientLight( Color( 50, 50, 50 ) )
		mdlPanel:SetDirectionalLight( BOX_TOP, Color( 255, 255, 255 ) )
		mdlPanel:SetDirectionalLight( BOX_FRONT, Color( 255, 255, 255 ) )
		mdlPanel:SetCamPos( Vector( 100, 0, 30) );
		mdlPanel:SetLookAt( Vector( 0, 0, 30) );
		mdlPanel:SetFOV( 70 );
	
		local OkButton = vgui.Create("DButton", SaveWindow);
		OkButton:SetText(v[1]);
		OkButton:SetSize( 150, 20 ); 
		OkButton.DoClick = function()
			--Create the menu
			local MainMenu = DermaMenu() -- create a derma menu
			MainMenu:SetPos(gui.MousePos()) --put it wherever the cursor is at the time
			MainMenu:AddOption("Load", function() ply:PrintMessage( HUD_PRINTTALK, "LOAD!" ) ply:ConCommand("rp_loadchar " .. v[1] ) end )
			MainMenu:AddSpacer()
			MainMenu:AddOption("Delete", function() ply:PrintMessage( HUD_PRINTTALK, "DELETE!" ) ply:ConCommand("rp_deletechar " .. v[1] ) end )
			MainMenu:AddSpacer()
			MainMenu:AddOption("Cancel" )
			MainMenu:Open()
			surface.PlaySound( "vaultscript/buttonclick.wav" )
		end
		OkButton:SetPos(modelwidth+125-75, lineheight+210);
	
		lineheight = lineheight + 235
	end
	
	SaveWindow:SetSize( 520, 530 )
	SaveWindow:Center()	
	SaveWindow:MakePopup()
	SaveWindow:SetKeyboardInputEnabled( false )
	SaveWindow:SetBackgroundBlur( true )
	SaveWindow:SetDraggable( false )
	SaveWindow:ShowCloseButton( false )
end


function CreateModelWindow()

	if(ModelWindow) then
	return
	end

	surface.PlaySound( "vaultscript/menuclick.wav" )
	ModelWindow = vgui.Create( "DFrame" )
	ModelWindow:SetTitle("Select your look");

	local mdlPanel = vgui.Create( "DModelPanel", ModelWindow )
	mdlPanel:SetSize( 400, 400 )
	mdlPanel:SetPos( 60, 20 )
	
	mdlPanel:SetModel( models[1] )
	
	local i = 1;--FOR THE MODEL INDEX COUNTER
	
	if(ChosenModel)then
		for k, v in pairs( models ) do
			if(v == ChosenModel)then
				mdlPanel:SetModel( models[k] )
				i = k
			end
		end
	end
	
	mdlPanel:SetAnimSpeed( 0.0 )
	mdlPanel:SetAnimated( false )
	mdlPanel:SetAmbientLight( Color( 50, 50, 50 ) )
	mdlPanel:SetDirectionalLight( BOX_TOP, Color( 255, 255, 255 ) )
	mdlPanel:SetDirectionalLight( BOX_FRONT, Color( 255, 255, 255 ) )
	mdlPanel:SetCamPos( Vector( 50, 0, 50 ) )
	mdlPanel:SetLookAt( Vector( 0, 0, 50 ) )
	mdlPanel:SetFOV( 70 )
	
	mdlPanel:SetCamPos( Vector( 100, 0, 30) );
	mdlPanel:SetLookAt( Vector( 0, 0, 30) );
	mdlPanel:SetFOV( 70 );
	
	local ZoomSlider = vgui.Create("DNumSlider", ModelWindow);
	ZoomSlider:SetMax(50);
	ZoomSlider:SetMin(0);
	ZoomSlider:SetText("Zoom");
	ZoomSlider:SetDecimals( 0 );
	ZoomSlider:SetWidth(500);
	ZoomSlider:SetPos(10, 400);

	local RotateSlider = vgui.Create("DNumSlider", ModelWindow);
	RotateSlider:SetMax(360);
	RotateSlider:SetMin(0);
	RotateSlider:SetText("Rotate");
	RotateSlider:SetDecimals( 0 );
	RotateSlider:SetWidth(500);
	RotateSlider:SetPos(10, 440);

	local OkButton = vgui.Create("DButton", ModelWindow);
	OkButton:SetText("OK");
	OkButton.DoClick = function()
		if(mdlPanel.Entity:GetModel()!= "")then
			SetChosenModel(mdlPanel.Entity:GetModel());

			ModelWindow:Remove();
			ModelWindow = nil;
		surface.PlaySound( "vaultscript/buttonclick.wav" )
		CreateCharacterWindow()
		--timer.Simple( 1, function() CreateCharacterWindow() end )
		end
	end
	OkButton:SetPos(230, 490);
	
	function mdlPanel:LayoutEntity(Entity)
		self:RunAnimation();
		Entity:SetAngles( Angle( 0, 30+RotateSlider:GetValue(), 0) )
		
		self:SetFOV(  70-ZoomSlider:GetValue() );
		
		self:SetCamPos( Vector( 100, 0, 30+ZoomSlider:GetValue()/1.7) );
		self:SetLookAt( Vector( 0, 0, 30+ZoomSlider:GetValue()/1.7) );
	end

	local LastMdl = vgui.Create( "DButton", ModelWindow )
	LastMdl:SetText("<");
	LastMdl.DoClick = function()
		i = i - 1;
		
		if(i == 0) then
			i = #models;
		end
		
		mdlPanel:SetModel(models[i]);
		surface.PlaySound( "vaultscript/click.wav" )
	end

	LastMdl:SetPos(10, 200);

	local NextMdl = vgui.Create( "DButton", ModelWindow )
	NextMdl:SetText(">");
	NextMdl.DoClick = function()
		i = i + 1;

		if(i > #models) then
			i = 1;
		end
		
		mdlPanel:SetModel(models[i]);
		surface.PlaySound( "vaultscript/click.wav" )
	end
	NextMdl:SetPos( 445, 200);
	
	ModelWindow:SetSize( 520, 530 )
	ModelWindow:Center()	
	ModelWindow:MakePopup()
	ModelWindow:SetKeyboardInputEnabled( false )
	ModelWindow:SetBackgroundBlur( true )
	ModelWindow:SetDraggable( false )
	ModelWindow:ShowCloseButton( false )
	ModelWindow:SetKeyboardInputEnabled( true )
end




ChosenAge = 21

stat = {}
stat["Strength"] = 5
stat["Perception"] = 5
stat["Endurance"] = 5
stat["Charisma"] = 5
stat["Intelligence"] = 5
stat["Agility"] = 5
stat["Luck"] = 5

statpoints = 10

function CreateCharacterWindow()

	if(CharacterWindow) then
		return
	end

	if(!ChosenModel)then
		return
	end
	
	CharacterWindow = vgui.Create( "DFrame" )
	CharacterWindow:SetTitle("Character Creation");
	
	
	local mdlPanel = vgui.Create( "DModelPanel", CharacterWindow )
	mdlPanel:SetSize( 250, 250 )
	mdlPanel:SetPos( 260, 20 )
	
	if(ChosenModel)then
		mdlPanel:SetModel( ChosenModel )
	end
	
	mdlPanel:SetAnimSpeed( 1.0 )
	mdlPanel:SetAnimated( true )
	mdlPanel:SetAmbientLight( Color( 50, 50, 50 ) )
	mdlPanel:SetDirectionalLight( BOX_TOP, Color( 255, 255, 255 ) )
	mdlPanel:SetDirectionalLight( BOX_FRONT, Color( 255, 255, 255 ) )
	mdlPanel:SetCamPos( Vector( 100, 0, 30) );
	mdlPanel:SetLookAt( Vector( 0, 0, 30) );
	mdlPanel:SetFOV( 70 );
	
	function mdlPanel:LayoutEntity(Entity)
		self:RunAnimation();
		Entity:SetAngles( Angle( 0, Entity:GetAngles().y+2, 0) )
	end

	y1 = 40
	local NameLabel = vgui.Create("DLabel", CharacterWindow);
	NameLabel:SetPos(20, y1);
	NameLabel:SetText("Name: ");
	
	local NameDermaText = vgui.Create( "DTextEntry", CharacterWindow )
	NameDermaText:SetPos( 70,y1 )
	NameDermaText:SetTall( 20 )
	NameDermaText:SetWide( 200 )
	NameDermaText:SetEnterAllowed( true )	
	NameDermaText.OnGetFocus = function()
		surface.PlaySound( "vaultscript/click.wav" )
	end
	if(ChosenName)then
		NameDermaText:SetText(ChosenName) 
	end
	y1 = y1+40
		
	local AgeLabel = vgui.Create("DLabel", CharacterWindow);
	AgeLabel:SetPos(20, y1);
	AgeLabel:SetText("Age: ");
		
	local AgeIndicator = vgui.Create("DLabel", CharacterWindow);
	AgeIndicator:SetPos(100, y1);
	AgeIndicator:SetText(ChosenAge);

	
	local PreviousButton = vgui.Create( "DButton", CharacterWindow )
	PreviousButton:SetSize( 20, 20 )
	PreviousButton:SetText("-");
	PreviousButton.DoClick = function()
	SetChosenAge(ChosenAge - 1)
	AgeIndicator:SetText(ChosenAge);
		surface.PlaySound( "vaultscript/click.wav" )
	end

	PreviousButton:SetPos(70, y1);

	local NextButton = vgui.Create( "DButton", CharacterWindow )
	NextButton:SetSize( 20, 20 )
	NextButton:SetText("+");
	NextButton.DoClick = function()
	SetChosenAge(ChosenAge + 1)
	AgeIndicator:SetText(ChosenAge);
		surface.PlaySound( "vaultscript/click.wav" )
	end
	NextButton:SetPos( 120, y1);
	
	
	if(ChosenAge)then
		AgeIndicator:SetText(ChosenAge) 
	end
	
	
	
	
	
	
	y1 = y1+40
	
	x2=60
	x3=165
	x4=180
	x5=135
	
	--STATPOINT INDICATOR
	
	local CharPointsLabel = vgui.Create("DLabel", CharacterWindow);
	CharPointsLabel:SetPos(x2, y1);
	CharPointsLabel:SetText("Char Points: ");
		
	local CharPointsIndicator = vgui.Create("DLabel", CharacterWindow);
	CharPointsIndicator:SetPos(x3, y1);
	CharPointsIndicator:SetText(statpoints);

	y1 = y1+20
	
	--Strength stat
	local StrengthStatLabel = vgui.Create("DLabel", CharacterWindow);
	StrengthStatLabel:SetPos(x2, y1);
	StrengthStatLabel:SetText("Strength: ");
		
	local StrengthStatIndicator = vgui.Create("DLabel", CharacterWindow);
	StrengthStatIndicator:SetPos(x3, y1);
	StrengthStatIndicator:SetText(stat["Strength"]);
	
	local PreviousButton = vgui.Create( "DButton", CharacterWindow )
	PreviousButton:SetSize( 20, 20 )
	PreviousButton:SetText("-");
	PreviousButton.DoClick = function()
		SetStat( "Strength", -1 )
		StrengthStatIndicator:SetText(stat["Strength"]);
		CharPointsIndicator:SetText(statpoints);
		surface.PlaySound( "vaultscript/click.wav" )
	end
	PreviousButton:SetPos(x5, y1);
	
	local NextButton = vgui.Create( "DButton", CharacterWindow )
	NextButton:SetSize( 20, 20 )
	NextButton:SetText("+");
	NextButton.DoClick = function()
		SetStat( "Strength", 1 )
		StrengthStatIndicator:SetText(stat["Strength"]);
		CharPointsIndicator:SetText(statpoints);
		surface.PlaySound( "vaultscript/click.wav" )
	end
	NextButton:SetPos(x4, y1);
	

	y1 = y1+20
	
	--Perception stat
	local PerceptionStatLabel = vgui.Create("DLabel", CharacterWindow);
	PerceptionStatLabel:SetPos(x2, y1);
	PerceptionStatLabel:SetText("Perception: ");
		
	local PerceptionStatIndicator = vgui.Create("DLabel", CharacterWindow);
	PerceptionStatIndicator:SetPos(x3, y1);
	PerceptionStatIndicator:SetText(stat["Perception"]);
	
	local PreviousButton = vgui.Create( "DButton", CharacterWindow )
	PreviousButton:SetSize( 20, 20 )
	PreviousButton:SetText("-");
	PreviousButton.DoClick = function()
		SetStat( "Perception", -1 )
		PerceptionStatIndicator:SetText(stat["Perception"]);
		CharPointsIndicator:SetText(statpoints);
		surface.PlaySound( "vaultscript/click.wav" )
	end
	PreviousButton:SetPos(x5, y1);
	
	local NextButton = vgui.Create( "DButton", CharacterWindow )
	NextButton:SetSize( 20, 20 )
	NextButton:SetText("+");
	NextButton.DoClick = function()
		SetStat( "Perception", 1 )
		PerceptionStatIndicator:SetText(stat["Perception"]);
		CharPointsIndicator:SetText(statpoints);
		surface.PlaySound( "vaultscript/click.wav" )
	end
	NextButton:SetPos(x4, y1);
	
	y1 = y1+20

	--Endurance stat
	local EnduranceStatLabel = vgui.Create("DLabel", CharacterWindow);
	EnduranceStatLabel:SetPos(x2, y1);
	EnduranceStatLabel:SetText("Endurance: ");
		
	local EnduranceStatIndicator = vgui.Create("DLabel", CharacterWindow);
	EnduranceStatIndicator:SetPos(x3, y1);
	EnduranceStatIndicator:SetText(stat["Endurance"]);
	
	local PreviousButton = vgui.Create( "DButton", CharacterWindow )
	PreviousButton:SetSize( 20, 20 )
	PreviousButton:SetText("-");
	PreviousButton.DoClick = function()
		SetStat( "Endurance", -1 )
		EnduranceStatIndicator:SetText(stat["Endurance"]);
		CharPointsIndicator:SetText(statpoints);
		surface.PlaySound( "vaultscript/click.wav" )
	end
	PreviousButton:SetPos(x5, y1);
	
	local NextButton = vgui.Create( "DButton", CharacterWindow )
	NextButton:SetSize( 20, 20 )
	NextButton:SetText("+");
	NextButton.DoClick = function()
		SetStat( "Endurance", 1 )
		EnduranceStatIndicator:SetText(stat["Endurance"]);
		CharPointsIndicator:SetText(statpoints);
		surface.PlaySound( "vaultscript/click.wav" )
	end
	NextButton:SetPos(x4, y1);
	

	
	y1 = y1+20
	
	--Charisma stat
	local CharismaStatLabel = vgui.Create("DLabel", CharacterWindow);
	CharismaStatLabel:SetPos(x2, y1);
	CharismaStatLabel:SetText("Charisma: ");
		
	local CharismaStatIndicator = vgui.Create("DLabel", CharacterWindow);
	CharismaStatIndicator:SetPos(x3, y1);
	CharismaStatIndicator:SetText(stat["Charisma"]);
	
	local PreviousButton = vgui.Create( "DButton", CharacterWindow )
	PreviousButton:SetSize( 20, 20 )
	PreviousButton:SetText("-");
	PreviousButton.DoClick = function()
		SetStat( "Charisma", -1 )
		CharismaStatIndicator:SetText(stat["Charisma"]);
		CharPointsIndicator:SetText(statpoints);
		surface.PlaySound( "vaultscript/click.wav" )
	end
	PreviousButton:SetPos(x5, y1);
	
	local NextButton = vgui.Create( "DButton", CharacterWindow )
	NextButton:SetSize( 20, 20 )
	NextButton:SetText("+");
	NextButton.DoClick = function()
		SetStat( "Charisma", 1 )
		CharismaStatIndicator:SetText(stat["Charisma"]);
		CharPointsIndicator:SetText(statpoints);
		surface.PlaySound( "vaultscript/click.wav" )
	end
	NextButton:SetPos(x4, y1);
	

	
	y1 = y1+20
	--Intelligence stat
	local IntelligenceStatLabel = vgui.Create("DLabel", CharacterWindow);
	IntelligenceStatLabel:SetPos(x2, y1);
	IntelligenceStatLabel:SetText("Intelligence: ");
		
	local IntelligenceStatIndicator = vgui.Create("DLabel", CharacterWindow);
	IntelligenceStatIndicator:SetPos(x3, y1);
	IntelligenceStatIndicator:SetText(stat["Intelligence"]);
	
	local PreviousButton = vgui.Create( "DButton", CharacterWindow )
	PreviousButton:SetSize( 20, 20 )
	PreviousButton:SetText("-");
	PreviousButton.DoClick = function()
		SetStat( "Intelligence", -1 )
		IntelligenceStatIndicator:SetText(stat["Intelligence"]);
		CharPointsIndicator:SetText(statpoints);
		surface.PlaySound( "vaultscript/click.wav" )
	end
	PreviousButton:SetPos(x5, y1);
	
	local NextButton = vgui.Create( "DButton", CharacterWindow )
	NextButton:SetSize( 20, 20 )
	NextButton:SetText("+");
	NextButton.DoClick = function()
		SetStat( "Intelligence", 1 )
		IntelligenceStatIndicator:SetText(stat["Intelligence"]);
		CharPointsIndicator:SetText(statpoints);
		surface.PlaySound( "vaultscript/click.wav" )
	end
	NextButton:SetPos(x4, y1);
	

	y1 = y1+20
	
	--Agility stat
	local AgilityStatLabel = vgui.Create("DLabel", CharacterWindow);
	AgilityStatLabel:SetPos(x2, y1);
	AgilityStatLabel:SetText("Agility: ");
		
	local AgilityStatIndicator = vgui.Create("DLabel", CharacterWindow);
	AgilityStatIndicator:SetPos(x3, y1);
	AgilityStatIndicator:SetText(stat["Agility"]);
	
	local PreviousButton = vgui.Create( "DButton", CharacterWindow )
	PreviousButton:SetSize( 20, 20 )
	PreviousButton:SetText("-");
	PreviousButton.DoClick = function()
		SetStat( "Agility", -1 )
		AgilityStatIndicator:SetText(stat["Agility"]);
		CharPointsIndicator:SetText(statpoints);
		surface.PlaySound( "vaultscript/click.wav" )
	end
	PreviousButton:SetPos(x5, y1);
	
	local NextButton = vgui.Create( "DButton", CharacterWindow )
	NextButton:SetSize( 20, 20 )
	NextButton:SetText("+");
	NextButton.DoClick = function()
		SetStat( "Agility", 1 )
		AgilityStatIndicator:SetText(stat["Agility"]);
		CharPointsIndicator:SetText(statpoints);
		surface.PlaySound( "vaultscript/click.wav" )
	end
	NextButton:SetPos(x4,y1);
	

	y1 = y1+20
	
	--Luck stat
	local LuckStatLabel = vgui.Create("DLabel", CharacterWindow);
	LuckStatLabel:SetPos(x2, y1);
	LuckStatLabel:SetText("Luck: ");
		
	local LuckStatIndicator = vgui.Create("DLabel", CharacterWindow);
	LuckStatIndicator:SetPos(x3, y1);
	LuckStatIndicator:SetText(stat["Luck"]);
	
	local PreviousButton = vgui.Create( "DButton", CharacterWindow )
	PreviousButton:SetSize( 20, 20 )
	PreviousButton:SetText("-");
	PreviousButton.DoClick = function()
		SetStat( "Luck", -1 )
		LuckStatIndicator:SetText(stat["Luck"]);
		CharPointsIndicator:SetText(statpoints);
		surface.PlaySound( "vaultscript/click.wav" )
	end
	PreviousButton:SetPos(x5, y1);
	
	local NextButton = vgui.Create( "DButton", CharacterWindow )
	NextButton:SetSize( 20, 20 )
	NextButton:SetText("+");
	NextButton.DoClick = function()
		SetStat( "Luck", 1 )
		LuckStatIndicator:SetText(stat["Luck"]);
		CharPointsIndicator:SetText(statpoints);
		surface.PlaySound( "vaultscript/click.wav" )
	end
	NextButton:SetPos(x4, y1);
	

	
	
	
	
	--CHANGE MODEL AND OK SHIT
	
	local ChangeModelButton = vgui.Create("DButton", CharacterWindow);
	ChangeModelButton:SetText("Change");
	ChangeModelButton.DoClick = function()
			SetChosenName(NameDermaText:GetValue());
			CharacterWindow:Remove();
			CharacterWindow = nil;
			surface.PlaySound( "vaultscript/buttonclick.wav" )
			CreateModelWindow()
	end
	ChangeModelButton:SetPos(355, 240);
	
	
	
	
	
	
	
	
	
	
	
	
	
--PERKS
	
	
x1 = 150
	y1 = y1+40
	
BloodyMess = vgui.Create( "DCheckBoxLabel", CharacterWindow )
BloodyMess:SetPos( x1,y1 )
BloodyMess:SetText( "Bloody Mess" )
BloodyMess:SizeToContents()
BloodyMess.OnChange = function()
	surface.PlaySound( "vaultscript/buttonclick.wav" )
end
	
	
	
y1 = y1+20
Bruiser = vgui.Create( "DCheckBoxLabel", CharacterWindow )
Bruiser:SetPos( x1,y1 )
Bruiser:SetText( "Bruiser" )
Bruiser:SizeToContents()
Bruiser.OnChange = function()
	surface.PlaySound( "vaultscript/buttonclick.wav" )
end
	
y1 = y1+20
ChemReliant = vgui.Create( "DCheckBoxLabel", CharacterWindow )
ChemReliant:SetPos( x1,y1 )
ChemReliant:SetText( "Chem Reliant" )
ChemReliant:SizeToContents()
ChemReliant.OnChange = function()
	surface.PlaySound( "vaultscript/buttonclick.wav" )
end
	
y1 = y1+20
ChemResistant = vgui.Create( "DCheckBoxLabel", CharacterWindow )
ChemResistant:SetPos( x1,y1 )
ChemResistant:SetText( "Chem Resistant" )
ChemResistant:SizeToContents()
ChemResistant.OnChange = function()
	surface.PlaySound( "vaultscript/buttonclick.wav" )
end
	
y1 = y1+20
FastMetabolism = vgui.Create( "DCheckBoxLabel", CharacterWindow )
FastMetabolism:SetPos( x1,y1 )
FastMetabolism:SetText( "Fast Metabolism" )
FastMetabolism:SizeToContents()
FastMetabolism.OnChange = function()
	surface.PlaySound( "vaultscript/buttonclick.wav" )
end
	
y1 = y1+20
FastShot = vgui.Create( "DCheckBoxLabel", CharacterWindow )
FastShot:SetPos( x1,y1 )
FastShot:SetText( "Fast Shot" )
FastShot:SizeToContents()
FastShot.OnChange = function()
	surface.PlaySound( "vaultscript/buttonclick.wav" )
end
	
y1 = y1+20
Finesse = vgui.Create( "DCheckBoxLabel", CharacterWindow )
Finesse:SetPos( x1,y1 )
Finesse:SetText( "Finesse" )
Finesse:SizeToContents()
Finesse.OnChange = function()
	surface.PlaySound( "vaultscript/buttonclick.wav" )
end
	
y1 = y1+20
Gifted = vgui.Create( "DCheckBoxLabel", CharacterWindow )
Gifted:SetPos( x1,y1 )
Gifted:SetText( "Gifted" )
Gifted:SizeToContents()
Gifted.OnChange = function()
	surface.PlaySound( "vaultscript/buttonclick.wav" )
end
	
y1 = y1+20
GoodNatured = vgui.Create( "DCheckBoxLabel", CharacterWindow )
GoodNatured:SetPos( x1,y1 )
GoodNatured:SetText( "Good Natured" )
GoodNatured:SizeToContents()
GoodNatured.OnChange = function()
	surface.PlaySound( "vaultscript/buttonclick.wav" )
end
	
	
	
	
	
	
	
	
	
	
	------------------------------------------
	
	
	
	
	
x1 = x1 + 130
	
	
y1 = 300
HeavyHanded = vgui.Create( "DCheckBoxLabel", CharacterWindow )
HeavyHanded:SetPos( x1,y1 )
HeavyHanded:SetText( "Heavy Handed" )
HeavyHanded:SizeToContents()
HeavyHanded.OnChange = function()
	surface.PlaySound( "vaultscript/buttonclick.wav" )
end
	
y1 = y1+20
Jinxed = vgui.Create( "DCheckBoxLabel", CharacterWindow )
Jinxed:SetPos( x1,y1 )
Jinxed:SetText( "Jinxed" )
Jinxed:SizeToContents()
Jinxed.OnChange = function()
	surface.PlaySound( "vaultscript/buttonclick.wav" )
end
	
y1 = y1+20
Kamikaze = vgui.Create( "DCheckBoxLabel", CharacterWindow )
Kamikaze:SetPos( x1,y1 )
Kamikaze:SetText( "Kamikaze" )
Kamikaze:SizeToContents()
Kamikaze.OnChange = function()
	surface.PlaySound( "vaultscript/buttonclick.wav" )
end
	
y1 = y1+20
OneHander = vgui.Create( "DCheckBoxLabel", CharacterWindow )
OneHander:SetPos( x1,y1 )
OneHander:SetText( "One Hander" )
OneHander:SizeToContents()
OneHander.OnChange = function()
	surface.PlaySound( "vaultscript/buttonclick.wav" )
end
	
y1 = y1+20
SexAppeal = vgui.Create( "DCheckBoxLabel", CharacterWindow )
SexAppeal:SetPos( x1,y1 )
SexAppeal:SetText( "Sex Appeal" )
SexAppeal:SizeToContents()
SexAppeal.OnChange = function()
	surface.PlaySound( "vaultscript/buttonclick.wav" )
end
	
y1 = y1+20
Skilled = vgui.Create( "DCheckBoxLabel", CharacterWindow )
Skilled:SetPos( x1,y1 )
Skilled:SetText( "Skilled" )
Skilled:SizeToContents()
Skilled.OnChange = function()
	surface.PlaySound( "vaultscript/buttonclick.wav" )
end
	
y1 = y1+20
SmallFrame = vgui.Create( "DCheckBoxLabel", CharacterWindow )
SmallFrame:SetPos( x1,y1 )
SmallFrame:SetText( "Small Frame" )
SmallFrame:SizeToContents()
SmallFrame.OnChange = function()
	surface.PlaySound( "vaultscript/buttonclick.wav" )
end
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
/*--

y1 = y1+20
Bruiser = vgui.Create( "DCheckBoxLabel", CharacterWindow )
Bruiser:SetPos( 20,y1 )
Bruiser:SetText( "Bruiser" )
Bruiser:SizeToContents()
Bruiser.OnChange = function()
	surface.PlaySound( "vaultscript/buttonclick.wav" )
end
	
y1 = y1+20
Bruiser = vgui.Create( "DCheckBoxLabel", CharacterWindow )
Bruiser:SetPos( 20,y1 )
Bruiser:SetText( "Bruiser" )
Bruiser:SizeToContents()
Bruiser.OnChange = function()
	surface.PlaySound( "vaultscript/buttonclick.wav" )
end
	
y1 = y1+20
Bruiser = vgui.Create( "DCheckBoxLabel", CharacterWindow )
Bruiser:SetPos( 20,y1 )
Bruiser:SetText( "Bruiser" )
Bruiser:SizeToContents()
Bruiser.OnChange = function()
	surface.PlaySound( "vaultscript/buttonclick.wav" )
end
	
y1 = y1+20
Bruiser = vgui.Create( "DCheckBoxLabel", CharacterWindow )
Bruiser:SetPos( 20,y1 )
Bruiser:SetText( "Bruiser" )
Bruiser:SizeToContents()
Bruiser.OnChange = function()
	surface.PlaySound( "vaultscript/buttonclick.wav" )
end

	

	
	
Bloody Mess
Bruiser
Chem Reliant
Chem Resistant
Fast Metabolism
Fast Shot
Fear the Reaper
Finesse
Gifted
Glowing One
Good Natured
Ham Fisted
Heavy Handed
Jinxed
Kamikaze
Night Person
One Hander
Sex Appeal
Skilled
Small Frame
Tech Wizard
Vat Skin--
*/
	
	
	
	
	
	
	
	
	
	
	
	
		
	if(#saves > 0)then
	
	local OkButton = vgui.Create("DButton", CharacterWindow);
	OkButton:SetText("Back");
	OkButton.DoClick = function()
		SetChosenName(NameDermaText:GetValue());
		CharacterWindow:Remove();
		CharacterWindow = nil;
		CreateSaveWindow()
		surface.PlaySound( "vaultscript/buttonclick.wav" )
	end
	OkButton:SetPos(190, 490);
	end
	
	
	
	local OkButton = vgui.Create("DButton", CharacterWindow);
	OkButton:SetText("Finish");
	OkButton.DoClick = function()
		if(statpoints == 0)then
			if(NameDermaText:GetValue() != "")then
				SetChosenName(NameDermaText:GetValue());
				LocalPlayer():ConCommand( "rp_startcreate" );
				--RunConsoleCommand( "rp_create_age", ChosenAge )
				--RunConsoleCommand( "rp_create_name", ChosenName )
				--RunConsoleCommand( "rp_create_model", ChosenModel )
				LocalPlayer():ConCommand( "rp_create_age " .. ChosenAge );
				LocalPlayer():ConCommand( "rp_create_name " .. ChosenName );
				LocalPlayer():ConCommand( "rp_create_model " .. ChosenModel );
				LocalPlayer():ConCommand( "rp_finishcreate" );
				LocalPlayer():ConCommand("rp_loadchar " .. ChosenName)
				CharacterWindow:Remove();
				CharacterWindow = nil;
				surface.PlaySound( "vaultscript/buttonclick.wav" )
				return
			end
		end
		
		if(NameDermaText:GetValue() == "")then
			SetChosenName(NameDermaText:GetValue());
			CharacterWindow:Remove();
			CharacterWindow = nil;
			CreateWarningWindow("You must enter a valid name!")
			return
		end
		
		if(statpoints != 0)then
			SetChosenName(NameDermaText:GetValue());
			CharacterWindow:Remove();
			CharacterWindow = nil;
			CreateWarningWindow("You must use all of the stat points!")
			return
		end
	end
	OkButton:SetPos(230, 490);
	
	if(#saves > 0)then
		OkButton:SetPos(270, 490);
	end
	CharacterWindow:SetSize( 520, 530 )
	CharacterWindow:Center()	
	CharacterWindow:MakePopup()
	CharacterWindow:SetKeyboardInputEnabled( false )
	CharacterWindow:SetBackgroundBlur( true )
	CharacterWindow:SetDraggable( false )
	CharacterWindow:ShowCloseButton( false )
	CharacterWindow:SetKeyboardInputEnabled( true )
end







function CreateWarningWindow(warning)

	if(WarningWindow) then
		return
	end

	surface.PlaySound( "vaultscript/warning.wav" )
	WarningWindow = vgui.Create( "DFrame" )
	WarningWindow:SetTitle("Warning");
	
	
	local WarningLabel = vgui.Create("DLabel", WarningWindow);
	WarningLabel:SetPos(10, 40);
	WarningLabel:SetText(warning);
	WarningLabel:SizeToContents() 
	
	local OkButton = vgui.Create("DButton", WarningWindow);
	OkButton:SetText("OK");
	OkButton.DoClick = function()
				WarningWindow:Remove();
				WarningWindow = nil;
				surface.PlaySound( "vaultscript/buttonclick.wav" )
				CreateCharacterWindow()
	end
	OkButton:SetPos(80, 100);
	
	WarningWindow:SetSize( 220, 130 )
	WarningWindow:Center()	
	WarningWindow:MakePopup()
	--WarningWindow:SetKeyboardInputEnabled( false )
	WarningWindow:SetBackgroundBlur( true )
	WarningWindow:SetDraggable( false )
	WarningWindow:ShowCloseButton( false )
	WarningWindow:SetKeyboardInputEnabled( true )
end













function SetChosenName( name )
	if( name != "" ) then	
		ChosenName = name
		print("Name chosen: " .. name .. "\n")
		return
	end
end


function SetChosenModel( mdl )
	if( table.HasValue( models, mdl ) ) then	
		ChosenModel = mdl
		print("Model chosen: " .. mdl .. "\n")
		return
	end
end

function SetChosenAge( age )
	if( tonumber(age) > 16 &&  tonumber(age) < 71 ) then	
		ChosenAge = age
		print("Age chosen: " .. age .. "\n")
		return
	end
end

function SetStat( stattochange, set )
	if(statpoints - set >= 0)then
		if( stat[stattochange]+ set >= 1 &&  stat[stattochange]+ set <= 10 ) then	
			stat[stattochange] = stat[stattochange] + set
			statpoints = statpoints - set
		end
	end
end



