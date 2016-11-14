--|시작시 화면을 설정|-----------------------------------------------------------------------------
display.setStatusBar( display.HiddenStatusBar )
native.setProperty( 'androidSystemUiVisiblility', 'immersiveSticky' )
---------------------------------------------------------------------------------------------------

--|물리엔진 시작|----------------------------------------------------------------------------------
local physics = require( "physics" )
physics.start( )
physics.setGravity( 0, 0 )
---------------------------------------------------------------------------------------------------

--|시작화면에 필요한 변수들|-----------------------------------------------------------------------
local startGroup

local startLogoFront
local startLogoBack
local startLogoHeart
local startButtonFront
local startButtonBack

local Blink
local BlinkDownFront
local BlinkDownBack
local BlinkDownFuntion
local BlinkUpFront
local BlinkUpBack
local BlinkUpFuntion
local BlinkDownFrontTimer
local BlinkUpBackTimer

local BlinkStartButton
local BlinkStartButtonTimer
---------------------------------------------------------------------------------------------------

--|직업선택에 필요한 변수들|-----------------------------------------------------------------------
local classSelectTitle
local classSelectText
local classMage
local classWarrior
local classRogue
---------------------------------------------------------------------------------------------------

--|게임에 필요한 변수들|---------------------------------------------------------------------------
local player
local boss
---------------------------------------------------------------------------------------------------

--|시작화면에 필요한 함수들|-----------------------------------------------------------------------
startGroup = display.newGroup( )

startLogoHeart = display.newRect( startGroup, 460, 350, 20, 20 )
startLogoHeart:setFillColor( 1, 0, 0 )
startLogoFront = display.newText( startGroup, "dReamtale", 640, 360, "MonsterFriendFore.otf", 60 )
startLogoBack = display.newText( startGroup, "dReamtale", 640, 360, "MonsterFriendBack.otf", 60 )
startLogoBack.alpha = 0.5


startButtonFront = display.newText( startGroup, "touch to strat", 640, 600, "MonsterFriendFore.otf", 30 )
startButtonBack = display.newText( startGroup, "touch to start", 640, 600, "MonsterFriendBack.otf", 30 )
startButtonBack.alpha = 0.5

function BlinkStartButton( event )
	BlinkDownFront = transition.to( startButtonFront, { time = 450, alpha = 0 } )
	BlinkDownBack = transition.to( startButtonBack, { time = 450, alpha = 0 } )

	BlinkUpFront = transition.to( startButtonFront, { time = 450, alpha = 1 } )
	BlinkUpBack = transition.to( startButtonBack, { time = 450, alpha = 1 } )

	BlinkDownFrontTimer = timer.performWithDelay( 0, BlinkDownFront )
	BlinkDownBackTimer = timer.performWithDelay( 0, BlinkDownBack )

	BlinkUpFrontTimer = timer.performWithDelay( 500, BlinkUpFront )
	BlinkUpBackTimer = timer.performWithDelay( 500, BlinkUpBack )
end

BlinkStartButtonTimer = timer.performWithDelay( 1000, "BlinkStartButton", 0 )
---------------------------------------------------------------------------------------------------