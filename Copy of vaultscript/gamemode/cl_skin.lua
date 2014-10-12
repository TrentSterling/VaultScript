local SKIN = {}


SKIN.PrintName 		= "Nocturnal"
SKIN.Author 		= "CelSius"
SKIN.DermaVersion	= 1

SKIN.colButtonText				= Color( 255, 255, 255, 255 )
SKIN.colButtonTextDisabled		= Color( 255, 255, 255, 55 )
SKIN.colButtonBorder			= Color( 20, 20, 20, 0 )
SKIN.colButtonBorderHighlight	= Color( 255, 255, 255, 0 )
SKIN.control_color 				= Color( 60, 75, 90, 255 )
SKIN.control_color_highlight	= Color( 225, 230, 230, 255 )
SKIN.control_color_highlight2	= Color( 200, 215, 230, 255 )
SKIN.control_color_active 		= Color( 225, 230, 230, 255 )
SKIN.control_color_active2 		= Color( 140, 155, 170, 255 )
SKIN.control_color_bright 		= Color( 127, 100, 50, 255 )
SKIN.control_color_dark 		= Color( 225, 230, 230, 255 ) 
SKIN.control_color_dark2 		= Color( 140, 155, 170, 255 )
SKIN.bg_color 					= Color( 60, 75, 90, 155 )
SKIN.bg_color_sleep 			= Color( 50, 65, 80, 155 )
SKIN.bg_color_dark				= Color( 30, 37, 45, 155 )
SKIN.bg_color_bright			= Color( 80, 90, 100, 255 )
SKIN.fontButton					= "DefaultSmall"
SKIN.fontTab					= "DefaultSmall"
SKIN.colPropertySheet 			= Color( 25, 30, 50 , 255 )
SKIN.colTab			 			= SKIN.colPropertySheet
SKIN.colTabInactive				= Color( 60, 75, 90, 155 )
SKIN.colTabShadow				= Color( 60, 60, 60, 255 )
SKIN.colTabText		 			= Color( 255, 255, 255, 255 )
SKIN.colTabTextInactive			= Color( 0, 0, 0, 155 )
SKIN.colNumberWangBG			= Color( 180, 200, 224, 255 )
SKIN.bg_alt1 					= Color( 25, 30, 50 , 255 )
SKIN.bg_alt2 					= Color( 60, 75, 90, 155 )

function SKIN:DrawTransparentDoubleGradientBackground( x, y, w, h, r, g, b, r2, g2, b2 )

for i=1, h, 3 do

	local gradient = (i / h)
	surface.SetDrawColor( (r*(1-gradient))+(r2*gradient), (g*(1-gradient))+(g2*gradient), (b*(1-gradient))+(b2*gradient), ((gradient*2)+3)*50 )
	surface.DrawRect( x, y+i, w, 3 )

	end 
	surface.SetDrawColor( 0, 0, 0, 255)
	surface.DrawOutlinedRect( x, y, w, h)
end

function SKIN:DrawDoubleGradientBackground( x, y, w, h, r, g, b, r2, g2, b2 )

for i=1, h, 3 do

	local gradient = (i / h)
	surface.SetDrawColor( (r*(1-gradient))+(r2*gradient), (g*(1-gradient))+(g2*gradient), (b*(1-gradient))+(b2*gradient), 255 )
	surface.DrawRect( x, y+i, w, 3 )

	end 
	surface.SetDrawColor( 0, 0, 0, 255)
	surface.DrawOutlinedRect( x, y, w, h)
end


function SKIN:DrawDoubleColourBackground( x, y, w, h, p, r, g, b, r2, g2, b2 )

	surface.SetDrawColor( r, b, g, 255 )
	surface.DrawRect( x, y, w, h/p )

	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawRect( x+3, y+3, w-6, math.Clamp((h/10)-3, 1, 2) )
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawRect( x+3, y+3, 1, h-6 )


	for i=(h/p), h, 3 do
	
	surface.SetDrawColor( r*(1-(i/h))+r2*(i/h), g*(1-(i/h))+g2*(i/h), b*(1-(i/h))+b2*(i/h), 255 )
	surface.DrawRect( x, i, w, 3)
	end
end

function SKIN:DrawHorDoubleColourBackground( x, y, w, h, p, r, g, b, r2, g2, b2 )


	surface.SetDrawColor( r, b, g, 255 )
	surface.DrawRect( x, y, w/p, h )

	for i=(w/p), w, 3 do

	surface.SetDrawColor( r*(1-(i/w))+r2*(i/w), g*(1-(i/w))+g2*(i/w), b*(1-(i/w))+b2*(i/w), 255 )
	surface.DrawRect( i, y, 3, h)
	end
end

function SKIN:DrawHorDoubleGradientBackground( x, y, w, h, r, g, b, r2, g2, b2 )

for i=1, w, 3 do

	local gradient = (i / w)
	surface.SetDrawColor( (r*(1-gradient))+(r2*gradient), (g*(1-gradient))+(g2*gradient), (b*(1-gradient))+(b2*gradient), 255 )
	surface.DrawRect( x+i, y, 3, h )

	end 

end

/*---------------------------------------------------------
	Frame & Form
---------------------------------------------------------*/

function SKIN:PaintFrame( panel )

	local color = self.bg_color

	self:DrawTransparentDoubleGradientBackground( 0, 0, panel:GetWide(), panel:GetTall(), 60, 75, 90, 25, 30, 50 )
	
	self:DrawDoubleGradientBackground( 0, 0, panel:GetWide(), 27, 103, 115, 124, 40, 50, 70 )
	
	surface.SetDrawColor( 0, 0, 0, 255)
	surface.DrawOutlinedRect( 0, 0, panel:GetWide(), 27)
	surface.SetDrawColor( self.colOutline )
	surface.DrawRect( 0, 21, panel:GetWide(), 1 )

	end

function SKIN:PaintForm( panel )

	local color = self.bg_color_sleep

	self:DrawDoubleGradientBackground( 0, 9, panel:GetWide(), panel:GetTall()-9, 60, 75, 90, 25, 30, 50 )

	end

/*---------------------------------------------------------
	NumSlider
---------------------------------------------------------*/

function SKIN:PaintNumSlider( panel )

	local w, h = panel:GetSize()
	
	self:DrawHorDoubleGradientBackground( 0, 0, w, h, 60, 75, 90, 25, 30, 50 )
	
	surface.SetDrawColor( 0, 0, 0, 200 )
	surface.DrawRect( 3, h/2, w-6, 1 )
	
	end

/*---------------------------------------------------------
	Tooltip
---------------------------------------------------------*/
function SKIN:PaintTooltip( panel )

	local w, h = panel:GetSize()
	
	DisableClipping( true )
	
	// This isn't great, but it's not like we're drawing 1000's of tooltips all the time
	for i=1, 8 do
	
		local BorderSize = i
		local BGColor = (255 / i) * 0.3
		
		self:DrawGenericBackground( BorderSize, BorderSize, w, h, Color( 200, 225, 255, BGColor ))
		panel:DrawArrow( BorderSize, BorderSize )
		self:DrawGenericBackground( -BorderSize, BorderSize, w, h, Color( 200, 225, 255, BGColor ))
		panel:DrawArrow( -BorderSize, BorderSize )
		self:DrawGenericBackground( BorderSize, -BorderSize, w, h, Color( 200, 225, 255, BGColor ))
		panel:DrawArrow( BorderSize, -BorderSize )
		self:DrawGenericBackground( -BorderSize, -BorderSize, w, h, Color( 200, 225, 255, BGColor ))
		panel:DrawArrow( -BorderSize, -BorderSize )
		
		end

	self:DrawGenericBackground( -1, -1, w+2, h+2, Color(0, 0, 0, 255))
	panel:DrawArrow( -1, 0 )
	panel:DrawArrow( 1, 0 )
	panel:DrawArrow( 0, 1 )
	self:DrawGenericBackground( 0, 0, w, h, Color(200, 225, 255, 255))
	panel:DrawArrow( 0, 0 )

	DisableClipping( false )
	
	end


/*---------------------------------------------------------
	ScrollBar
---------------------------------------------------------*/
function SKIN:PaintVScrollBar( panel )
	local col = self.control_color_active
	self:DrawHorDoubleColourBackground( 2, 0, panel:GetWide()-4, panel:GetTall(), 3, col.r/1.3, col.g/1.3, col.b/1.3, 180/2, 195/2, 210/2 )
	surface.SetDrawColor( 0, 0, 0, 250 )
	surface.DrawOutlinedRect( 2, 0, panel:GetWide()-4, panel:GetTall() )

end

function SKIN:PaintScrollBarGrip( panel )

	local col = self.control_color_active
	self:DrawDoubleColourBackground( 1, 0, panel:GetWide()-2, panel:GetTall(), 3, col.r/1.5, col.g/1.5, col.b/1.5, 180/1.5, 195/1.5, 210/1.5 )
	surface.SetDrawColor( 0, 0, 0, 250 )
	surface.DrawOutlinedRect( 1, 0, panel:GetWide()-2, panel:GetTall() )
end


/*---------------------------------------------------------
	Button
---------------------------------------------------------*/
function SKIN:PaintButton( panel )

	local w = panel:GetWide()
	local h = panel:GetTall()
	local x, y = panel:GetPos()

	if ( panel.m_bBackground ) then
	
		local col = self.control_color_dark
		local col2 = self.control_color_dark2
		local sine = 0.7
		local line = Color( 0, 0, 0, 255 )

		if ( panel:GetDisabled() ) then
			col = self.control_color_dark
			col2 = self.control_color_dark2

		elseif ( panel.Depressed || panel:GetSelected() ) then
			col = self.control_color_active2
			col2 = self.control_color_active
			sine = 0.5
			line = Color( 200, 255, 70, 255 )

		elseif ( panel.Hovered ) then
			col = self.control_color_highlight
			col2 = self.control_color_highlight2
			sine = math.Clamp(math.abs(math.sin(CurTime()*3)+1), 0.5, 1.13)/2
			line = Color( 200, 255, 70, 255 )
		end
	
		
	self:DrawDoubleColourBackground( 0, 0, w, h, 3, math.Clamp(col.r*sine, 0, 255), math.Clamp(col.b*sine, 0, 255), math.Clamp(col.g*sine, 0, 255), math.Clamp(col2.r*sine, 0, 255), math.Clamp(col2.g*sine, 0, 255), math.Clamp(col2.b*sine, 0, 255) )
	surface.SetDrawColor( line.r, line.g, line.b, 255 )
	surface.DrawOutlinedRect( 0, 0, w, h)
	end

end

function SKIN:PaintOverButton( panel )
end

/*---------------------------------------------------------
	Tab
---------------------------------------------------------*/
function SKIN:PaintTab( panel )

	// This adds a little shadow to the right which helps define the tab shape..
	draw.RoundedBox( 4, 0, 0, panel:GetWide(), panel:GetTall() + 8, self.colTabShadow )
	
	if ( panel:GetPropertySheet():GetActiveTab() == panel ) then

		draw.RoundedBox( 4, 1, 0, panel:GetWide()-2, panel:GetTall() + 8, self.colTab )

	else

		local col = self.control_color_dark
		local col2 = self.control_color_dark2

		self:DrawDoubleColourBackground( 4, 1, panel:GetWide()-2, panel:GetTall() + 8, 3, col.r/1.3, col.b/1.3, col.g/1.3, col2.r/1.3, col2.g/1.3, col2.b/1.3 )
		surface.SetDrawColor( 0, 0, 0, 255 )
		surface.DrawOutlinedRect( 4, 1, panel:GetWide()-2, panel:GetTall() + 8)
	end

	
end


derma.DefineSkin( "nocturnal", "Dark skin featuring gradients and other goodies.", SKIN ) 

function GM:ForceDermaSkin()
	return "nocturnal"
end 