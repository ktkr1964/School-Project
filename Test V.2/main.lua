-----------------------------------------------------------------------------------------
local physics = require( "physics" )
physics.start( )
physics.setGravity( 0, 0 )
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
currentStage = 0
attackCount = 0

playerDamegeBool = false
playerBoxLocation = 0
playerMovingBool = false

moveX = 0
moveY = 0
moveSpeed = 3.5

itemUseBool = false
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------
UI = display.newGroup( )
boss = display.newGroup( )
bossAttack = display.newGroup( )
effect = display.newGroup( )
player = display.newGroup( )
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
player = display.newImage( player, "images/player.png" )
player.x = 640
player.y = 480
player.hp = 40
player.id = "player"
physics.addBody( player, { friction = 0, density = 0, bounce = 0 } )
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
boss = display.new
boss.x = 640
boss.y = 200
boss:scale( 1.5, 1.5 )
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
boxUp = display.newRect( UI, 640, 380, 860, 10 )
boxDown = display.newRect( UI, 640, 580, 860, 10 )
boxLeft = display.newRect( UI, 210, 480, 10, 210 )
boxRight = display.newRect( UI, 1070, 480, 10, 210 )
physics.addBody( boxUp, "static", { friction = 0, density = 0, bounce = 0 } )
physics.addBody( boxDown, "static", { friction = 0, density = 0, bounce = 0 } )
physics.addBody( boxRight, "static", { friction = 0, density = 0, bounce = 0 } )
physics.addBody( boxLeft, "static", { friction = 0, density = 0, bounce = 0 } )
boxUp.id = "boxUp"
boxDown.id = "boxDown"
boxRight.id = "boxRight"
boxLeft.id = "boxLeft"
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
boxAttackOn = display.newImage( UI, "images/boxAttackOn.png" )
boxAttackOn.x = 290
boxAttackOn.y = 680

boxActOn = display.newImage( UI, "images/boxActOn.png" )
boxActOn.x = 525
boxActOn.y = 680

boxItemOn = display.newImage( UI, "images/boxItemOn.png" )
boxItemOn.x = 760
boxItemOn.y = 680

boxMercyOn = display.newImage( UI, "images/boxMercyOn.png" )
boxMercyOn.x = 995
boxMercyOn.y = 680
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
boxAttackOver = display.newImage( UI, "images/boxAttackOver.png" )
boxAttackOver.x = 290
boxAttackOver.y = 1000

boxActOver = display.newImage( UI, "images/boxActOver.png" )
boxActOver.x = 525
boxActOver.y = 1000

boxItemOver = display.newImage( UI, "images/boxItemOver.png" )
boxItemOver.x = 760
boxItemOver.y = 1000

boxMercyOver = display.newImage( UI, "images/boxMercyOver.png" )
boxMercyOver.x = 995
boxMercyOver.y = 1000
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
playerName = display.newText( UI, "CHARA", 262.5, 610, "DungGeunMo.otf", 42 )

playerLV = display.newText( UI, "LV 1", 410, 610, "DungGeunMo.otf", 42 )

HpText = display.newText( UI, "HP", 545, 610, "DungGeunMo.otf", 35 )

playerMaxHpBar = display.newRect( UI, 572, 614, 165, 32 )
playerMaxHpBar.anchorX, playerMaxHpBar.anchorY = 0, 0.5
playerMaxHpBar:setFillColor( 255, 0, 0 )

playerCurrentHpBar = display.newRect( UI, 572, 614, 165, 32 )
playerCurrentHpBar.anchorX, playerCurrentHpBar.anchorY = 0, 0.5
playerCurrentHpBar:setFillColor( 80, 150, 0 )

playerCurrentHpText = display.newText( UI, "", 787, 610, "DungGeunMo.otf", 42 )
playerCurrentHpText.text = player.hp

playerMaxHpText = display.newText( UI, "/ 92", 817, 610, "DungGeunMo.otf", 42 )
playerMaxHpText.anchorX, playerMaxHpText.anchorY = 0, 0.5
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
Dpad = display.newImage( UI, "images/Dpad.png" )
Dpad.x = 105
Dpad.y = 600

DpadUp = display.newImage( UI, "images/DpadUpDown.png")
DpadUp.x = Dpad.x
DpadUp.y = Dpad.y - 50

DpadDown = display.newImage( UI, "images/DpadUpDown.png" )
DpadDown.x = Dpad.x
DpadDown.y = Dpad.y + 50

DpadRight = display.newImage( UI, "images/DpadRightLeft.png" )
DpadRight.x = Dpad.x + 50
DpadRight.y = Dpad.y

DpadLeft = display.newImage( UI, "images/DpadRightLeft.png" )
DpadLeft.x = Dpad.x - 50
DpadLeft.y = Dpad.y
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
buttonA = display.newImage( UI, "images/buttonA.png" )
buttonA.x = 1175
buttonA.y = 625

buttonB = display.newImage( UI, "images/buttonB.png" )
buttonB.x = 1175
buttonB.y = 475
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
function checkFrame( event )
	if playerDamegeBool == true then
		if player.hp > 0 then
			player.hp = player.hp - 1
		end
	end

	if player.hp == 9 then
		playerCurrentHpText.text = "09"
	elseif player.hp == 8 then
		playerCurrentHpText.text = "08"
	elseif player.hp == 7 then
		playerCurrentHpText.text = "07"
	elseif player.hp == 6 then
		playerCurrentHpText.text = "06"
	elseif player.hp == 5 then
		playerCurrentHpText.text = "05"
	elseif player.hp == 4 then
		playerCurrentHpText.text = "04"
	elseif player.hp == 3 then
		playerCurrentHpText.text = "03"
	elseif player.hp == 2 then
		playerCurrentHpText.text = "02"
	elseif player.hp == 1 then
		playerCurrentHpText.text = "01"
	elseif player.hp == 0 then
		playerCurrentHpText.text = "00"
	else
		playerCurrentHpText.text = player.hp
	end

	playerCurrentHpBar.width = playerMaxHpBar.width * ( player.hp / 92 )
end

function damegeJudge( event )
	if event.phase == "began" then
		if event.other.id == "boxUp" then
			playerDamageBool = false
		elseif event.other.id == "boxDown" then
			playerDamageBool = false
		elseif event.other.id == "boxLeft" then
			playerDamageBool = false
		elseif event.other.id == "boxRight" then
			playerDamageBool = false
		else
			playerDamegeBool = true
		end
	end
	if event.phase == "ended" then
		playerDamegeBool = false
	end
end

local function movePlayer( event )
		if event.x < Dpad.x + 115 and event.x > Dpad.x + 25 and event.y < Dpad.y + 25 and event.y > Dpad.y - 25 then
			moveX = moveSpeed
			moveY = 0
			playerMovingBool = true
		elseif event.x < Dpad.x - 25 and event.x > Dpad.x - 115 and event.y < Dpad.y + 25 and event.y > Dpad.y - 25 then
			moveX = -moveSpeed
			moveY = 0
			playerMovingBool = true
		elseif event.y < Dpad.y + 115 and event.y > Dpad.y + 25 and event.x < Dpad.x + 25 and event.x > Dpad.x - 25 then
			moveX = 0
			moveY = moveSpeed
			playerMovingBool = true
		elseif event.y < Dpad.y - 25 and event.y > Dpad.y - 115 and event.x < Dpad.x + 25 and event.x > Dpad.x - 25 then
			moveX = 0
			moveY = -moveSpeed
			playerMovingBool = true
		elseif event.x > Dpad.x + 25 and event.x < Dpad.x + 115 and event.y < Dpad.y - 25 and event.y > Dpad.y - 115 then
			moveX = 2.12
			moveY = -2.12
			playerMovingBool = true
		elseif event.x < Dpad.x - 25 and event.x > Dpad.x - 115 and event.y < Dpad.y - 25 and event.y > Dpad.y - 115 then
			moveX = -2.12
			moveY = -2.12
			playerMovingBool = true
		elseif event.x > Dpad.x + 25 and event.x < Dpad.x + 115 and event.y > Dpad.y + 25 and event.y < Dpad.y + 115 then
			moveX = 2.12
			moveY = 2.12
			playerMovingBool = true
		elseif event.x < Dpad.x - 25 and event.x > Dpad.x - 115 and event.y > Dpad.y + 25 and event.y < Dpad.y + 115 then
			moveX = -2.12
			moveY = 2.12
			playerMovingBool = true
		elseif event.x > Dpad.x - 25 and event.x < Dpad.x + 25 and event.y < Dpad.y + 25 and event.y > Dpad.y - 25 then
			moveX = 0
			moveY = 0
			playerMovingBool = false
		else
			moveX = 0
			moveY = 0
			playerMovingBool = false
		end
		if event.phase == "ended" then
			moveX = 0
			moveY = 0
			playerMovingBool = false
		end
end

local function moveingPlayer( event )
		if player.x < boxRight.x - 20 and player.x > boxLeft.x + 20 and player.y > boxUp.y + 20 and player.y < boxDown.y - 20 then
			player.x = player.x + moveX
			player.y = player.y + moveY
		end
end

local function DpadUpFunction( event )
	if event.phase == "began" then
		system.vibrate( )
	end
end

local function DpadDownFunction( event )
	if event.phase == "began" then
		system.vibrate( )
	end
end

local function DpadRightFunction( event )
	if event.phase == "began" then
		system.vibrate( )
		if currentStage == 1 then
			if playerBoxLocation == 0 then
				playerBoxLocation = 1

				boxAttackOn.y = 680
				boxAttackOver.y = 1000

				boxActOn.y = 1000
				boxActOver.y = 680

				player.x = boxActOver.x - 53

			elseif playerBoxLocation == 1 then
				playerBoxLocation = 2

				boxActOn.y = 680
				boxActOver.y = 1000

				boxItemOn.y = 1000
				boxItemOver.y = 680

				player.x = boxItemOver.x - 53

			elseif playerBoxLocation == 2 then
				playerBoxLocation = 3

				boxItemOn.y = 680
				boxItemOver.y = 1000

				boxMercyOn.y = 1000
				boxMercyOver.y = 680

				player.x = boxMercyOver.x - 53
			end
		end
	end
end

local function DpadLeftFunction( event )
	if event.phase == "began" then
		system.vibrate( )
		if currentStage == 1 then
			if playerBoxLocation == 1 then
				playerBoxLocation = 0

				boxActOn.y = 680
				boxActOver.y = 1000

				boxAttackOn.y = 1000
				boxAttackOver.y = 680

				player.x = boxAttackOver.x - 53

			elseif playerBoxLocation == 2 then
				playerBoxLocation = 1

				boxItemOn.y = 680
				boxItemOver.y = 1000

				boxActOn.y = 1000
				boxActOver.y = 680

				player.x = boxActOver.x - 53

			elseif playerBoxLocation == 3 then
				playerBoxLocation = 2

				boxMercyOn.y = 680
				boxMercyOver.y = 1000

				boxItemOn.y = 1000
				boxItemOver.y = 680

				player.x = boxItemOver.x - 53
			end
		end
	end
end

function buttonAFunction( event )
	if event.phase == "began" then
		system.vibrate( )
		if currentStage == 1 then
			if playerBoxLocation == 0 then
				currentStage = 2

				mainTextGroup:removeSelf( )

				player.x = 250
				player.y = 417.5

				attackText = display.newText( "* 중간고사", 390, 415, "DungGeunMo.otf", 40 )

				attackBar = display.newRect( 650, 420, 200, 20 )
				attackBar:setFillColor( 0, 255, 0 )

			elseif playerBoxLocation == 1 then
				currentStage = 3

				mainTextGroup:removeSelf( )

				player.x = 250
				player.y = 417.5

				actText = display.newText( "* 중간고사", 390, 415, "DungGeunMo.otf", 40 )

			elseif playerBoxLocation == 2 then
				if itemUseBool == false then

					currentStage = 4

					mainTextGroup:removeSelf( )

					player.x = 250
					player.y = 417.5

					itemText = display.newText( "* 스누피우유", 400, 415, "DungGeunMo.otf", 40 )
				end

			elseif playerBoxLocation == 3 then
				currentStage = 5

				mainTextGroup:removeSelf( )

				player.x = 250
				player.y = 417.5

				mercyText = display.newText( "* 살려주기", 390, 415, "DungGeunMo.otf", 40 )
			end
		elseif currentStage == 2 then
			currentStage = 21

			attackText:removeSelf( )
			attackBar:removeSelf( )

			player.x = 640
			player.y = 1000

			boxAttackOn.y = 680
			boxAttackOver.y = 1000

			timer.performWithDelay( 0, aimBoss )

		elseif currentStage == 3 then
			currentStage = 31

			actText:removeSelf( )

			actSelectText = display.newText( "* 살펴보기", 390, 415, "DungGeunMo.otf", 40 )

		elseif currentStage == 4 then
			currentStage = 41

			player.hp = 92

			player.x = 640
			player.y = 1000

			itemText:removeSelf( )

			boxItemOn.y = 680
			boxItemOver.y = 1000

			timer.performWithDelay( 0, inputItemText )

		elseif currentStage == 5 then
			currentStage = 51

			mercyText:removeSelf( )

			boxMercyOn.y = 680
			boxMercyOver.y = 1000

			player.x = 640
			player.y = 1000

			timer.performWithDelay( 0, inputMercyText )

		elseif currentStage == 21 then

			timer.performWithDelay( 0, attackBoss )

		elseif currentStage == 31 then
			currentStage = 32

			actSelectText:removeSelf( )

			boxActOn.y = 680
			boxActOver.y = 1000

			player.x = 640
			player.y = 1000

			timer.performWithDelay( 0, inputCheckText )

		elseif currentStage == 41 then

			itemUseBool = true

			itemTextGroup:removeSelf( )

			player.x = 640
			player.y = 480

		elseif currentStage == 51 then

			mercyTextGroup:removeSelf( )

			player.x = 640
			player.y = 480

		elseif currentStage == 32 then

			checkTextGroup:removeSelf( )

			player.x = 640
			player.y = 480

		end
	end
end

function buttonBFunction( event )
	if event.phase == "began" then
		system.vibrate( )
		if currentStage == 2 then
			currentStage = 1

			attackText:removeSelf( )
			attackBar:removeSelf( )

			timer.performWithDelay( 0, inputMainText0 )

			player.x = boxAttackOver.x - 53
			player.y = 680

		elseif currentStage == 3 then
			currentStage = 1

			actText:removeSelf( )

			timer.performWithDelay( 0, inputMainText0 )

			player.x = boxActOver.x - 53
			player.y = 680

		elseif currentStage == 4 then
			currentStage = 1

			itemText:removeSelf( )

			timer.performWithDelay( 0, inputMainText0 )

			player.x = boxItemOver.x - 53
			player.y = 680

		elseif currentStage == 5 then
			currentStage = 1

			mercyText:removeSelf( )

			timer.performWithDelay( 0, inputMainText0 )

			player.x = boxMercyOver.x - 53
			player.y = 680

		elseif currentStage == 31 then
			currentStage = 3

			actSelectText:removeSelf( )

			actText = display.newText( "* 중간고사", 390, 415, "DungGeunMo.otf", 40 )
		end
	end
end

local function myTrun( )
	moveX = 0
	moveY = 0

	currentStage = 1
	playerBoxLocation = 0

	player.x = boxAttackOver.x - 53
	player.y = 680

	timer.performWithDelay( 0, inputMainText0 )

	boxAttackOn.y = 1000
	boxAttackOver.y = 680
end

function aimBoss( )
	aimBack = display.newImage( "images/aimBoss.png" )
	aimBack.x = 640
	aimBack.y = 480

	aimBar1 = display.newImage( "images/aimBar1.png" )
	aimBar1.x = 232.5
	aimBar1.y = 480

	aimBar2 = display.newImage( "images/aimBar2.png" )
	aimBar2.x = 2000
	aimBar2.y = 480

	moveAimBar = transition.moveTo( aimBar1, { x = 1047.5, y = 480, time = 1500 } )
end

function attackBoss( )
	stopAimBar = transition.cancel( moveAimBar )

	function changeAimBar1( )
		aimBar2.x = aimBar1.x
	end
	function changeAimBar2( )
		aimBar2.x = 2000
	end
	function removeAimBar( )
		aimBar1:removeSelf( )
		aimBar2:removeSelf( )
	end

	function removeAimBack( )
		aimBack:removeSelf( )
	end

	function attackAni( )

		local attackSprite1 = display.newImage( "images/attackSprite/1.png", 1000, 1000 )
		local attackSprite2 = display.newImage( "images/attackSprite/2.png", 1000, 1000 )
		local attackSprite3 = display.newImage( "images/attackSprite/3.png", 1000, 1000 )
		local attackSprite4 = display.newImage( "images/attackSprite/4.png", 1000, 1000 )
		local attackSprite5 = display.newImage( "images/attackSprite/5.png", 1000, 1000 )
		local attackSprite6 = display.newImage( "images/attackSprite/6.png", 1000, 1000 )
		attackSprite1:scale( 3, 3 )
		attackSprite2:scale( 3, 3 )
		attackSprite3:scale( 3, 3 )
		attackSprite4:scale( 3, 3 )
		attackSprite5:scale( 3, 3 )
		attackSprite6:scale( 3, 3 )

		function attackAni1( )
			attackSprite1.x = 640
			attackSprite1.y = 105
		end
		function attackAni2( )
			attackSprite1:removeSelf( )

			attackSprite2.x = 640
			attackSprite2.y = 129
		end
		function attackAni3( )
			attackSprite2:removeSelf( )

			attackSprite3.x = 640
			attackSprite3.y = 159
		end
		function attackAni4( )
			attackSprite3:removeSelf( )

			attackSprite4.x = 640
			attackSprite4.y = 200
		end
		function attackAni5( )
			attackSprite4:removeSelf( )

			attackSprite5.x = 640
			attackSprite5.y = 240
		end
		function attackAni6( )
			attackSprite5:removeSelf( )

			attackSprite6.x = 640
			attackSprite6.y = 270
		end
		function attackAniRemove( )
			attackSprite6:removeSelf( )
		end

		timer.performWithDelay( 0, attackAni1 )
		timer.performWithDelay( 75, attackAni2 )
		timer.performWithDelay( 150, attackAni3 )
		timer.performWithDelay( 225, attackAni4 )
		timer.performWithDelay( 300, attackAni5 )
		timer.performWithDelay( 375, attackAni6 )
		timer.performWithDelay( 450, attackAniRemove )
	end

	function missAni( )
		miss = display.newImage( "images/miss.png", 640, 150 )
		miss:scale( 1.5, 1.5 )

		function missAni1( )
			transition.moveBy( miss, { x = 0, y = -30, time = 75 } )
		end
		function missAni2( )
			transition.moveBy( miss, { x = 0, y = 30, time = 75 } )
		end
		function removeMiss( )
			miss:removeSelf( )
		end

		timer.performWithDelay( 0, missAni1 )
		timer.performWithDelay( 75, missAni2 )
		timer.performWithDelay( 650, removeMiss )
	end

	function moveBoss( )
		transition.moveBy( boss, { x = -200, y = 0, time = 500 } )
	end

	timer.performWithDelay( 0, changeAimBar1 )
	timer.performWithDelay( 62.5, changeAimBar2 )
	timer.performWithDelay( 187.5, changeAimBar1 )
	timer.performWithDelay( 250, changeAimBar2 )
	timer.performWithDelay( 312.5, changeAimBar1 )
	timer.performWithDelay( 625, changeAimBar2 )
	timer.performWithDelay( 750, changeAimBar1 )
	timer.performWithDelay( 875, changeAimBar2 )
	timer.performWithDelay( 1000, changeAimBar1 )
	timer.performWithDelay( 1125, changeAimBar2 )
	timer.performWithDelay( 1250, changeAimBar1 )
	timer.performWithDelay( 1250, removeAimBar )

	timer.performWithDelay( 0, attackAni )

	timer.performWithDelay( 600, missAni )

	timer.performWithDelay( 1250, removeAimBack )

	timer.performWithDelay( 0, moveBoss )
end

function inputMainText0( )

	mainTextGroup = display.newGroup( )

	function inputHead( )
		textHead = display.newText( mainTextGroup, "*", 250, 410, "DungGeunMo.otf", 50 )
	end
	function inputTale1( )
		textTale = display.newText( mainTextGroup, "당", 275, 390, 700, 220, "DungGeunMo.otf", 40 )
		textTale.anchorX, textTale.anchorY = 0, 0
	end
	function inputTale2( )
		textTale.text = "당신"
	end
	function inputTale3( )
		textTale.text = "당신은"
	end
	function inputTale4( )
		textTale.text = "당신은 "
	end
	function inputTale5( )
		textTale.text = "당신은 끔"
	end
	function inputTale6( )
		textTale.text = "당신은 끔찍"
	end
	function inputTale7( )
		textTale.text = "당신은 끔찍한"
	end
	function inputTale8( )
		textTale.text = "당신은 끔찍한 "
	end
	function inputTale9( )
		textTale.text = "당신은 끔찍한 내"
	end
	function inputTale10( )
		textTale.text = "당신은 끔찍한 내신"
	end
	function inputTale11( )
		textTale.text = "당신은 끔찍한 내신을"
	end
	function inputTale12( )
		textTale.text = "당신은 끔찍한 내신을 "
	end
	function inputTale13( )
		textTale.text = "당신은 끔찍한 내신을 받"
	end
	function inputTale14( )
		textTale.text = "당신은 끔찍한 내신을 받을"
	end
	function inputTale15( )
		textTale.text = "당신은 끔찍한 내신을 받을 "
	end
	function inputTale16( )
		textTale.text = "당신은 끔찍한 내신을 받을 것"
	end
	function inputTale17( )
		textTale.text = "당신은 끔찍한 내신을 받을 것 "
	end
	function inputTale18( )
		textTale.text = "당신은 끔찍한 내신을 받을 것 같"
	end
	function inputTale19( )
		textTale.text = "당신은 끔찍한 내신을 받을 것 같은"
	end
	function inputTale20( )
		textTale.text = "당신은 끔찍한 내신을 받을 것 같은 "
	end
	function inputTale20( )
		textTale.text = "당신은 끔찍한 내신을 받을 것 같은 기"
	end
	function inputTale21( )
		textTale.text = "당신은 끔찍한 내신을 받을 것 같은 기분"
	end
	function inputTale22( )
		textTale.text = "당신은 끔찍한 내신을 받을 것 같은 기분이"
	end
	function inputTale23( )
		textTale.text = "당신은 끔찍한 내신을 받을 것 같은 기분이 "
	end
	function inputTale24( )
		textTale.text = "당신은 끔찍한 내신을 받을 것 같은 기분이 든"
	end
	function inputTale25( )
		textTale.text = "당신은 끔찍한 내신을 받을 것 같은 기분이 든다"
	end
	function inputTale26( )
		textTale.text = "당신은 끔찍한 내신을 받을 것 같은 기분이 든다."
	end

	timer.performWithDelay( 0, inputHead )
	timer.performWithDelay( 50, inputTale1 )
	timer.performWithDelay( 100, inputTale2 )
	timer.performWithDelay( 150, inputTale3 )
	timer.performWithDelay( 150, inputTale3 )
	timer.performWithDelay( 200, inputTale4 )
	timer.performWithDelay( 250, inputTale5 )
	timer.performWithDelay( 300, inputTale6 )
	timer.performWithDelay( 350, inputTale7 )
	timer.performWithDelay( 400, inputTale8 )
	timer.performWithDelay( 450, inputTale9 )
	timer.performWithDelay( 500, inputTale10 )
	timer.performWithDelay( 550, inputTale11 )
	timer.performWithDelay( 600, inputTale12 )
	timer.performWithDelay( 650, inputTale13 )
	timer.performWithDelay( 700, inputTale14 )
	timer.performWithDelay( 750, inputTale15 )
	timer.performWithDelay( 800, inputTale16 )
	timer.performWithDelay( 850, inputTale17 )
	timer.performWithDelay( 900, inputTale18 )
	timer.performWithDelay( 950, inputTale19 )
	timer.performWithDelay( 1000, inputTale20 )
	timer.performWithDelay( 1050, inputTale21 )
	timer.performWithDelay( 1100, inputTale22 )
	timer.performWithDelay( 1150, inputTale23 )
	timer.performWithDelay( 1200, inputTale24 )
	timer.performWithDelay( 1250, inputTale25 )
	timer.performWithDelay( 1300, inputTale26 )
end

function inputCheckText( )
	checkTextGroup = display.newGroup( )

	function inputHead1( )
		textHead1 = display.newText( checkTextGroup, "*", 250, 410, "DungGeunMo.otf", 50 )
	end
	function inputTale1( )
		textTale1 = display.newText( checkTextGroup, "중", 275, 390, 700, 220, "DungGeunMo.otf", 40 )
		textTale1.anchorX, textTale1.anchorY = 0, 0
	end
	function inputTale2( )
		textTale1.text = "중간"
	end
	function inputTale3( )
		textTale1.text = "중간고"
	end
	function inputTale4( )
		textTale1.text = "중간고사"
	end
	function inputTale5( )
		textTale1.text = "중간고사 "
	end
	function inputTale6( )
		textTale1.text = "중간고사 1"
	end
	function inputTale7( )
		textTale1.text = "중간고사 1 "
	end
	function inputTale8( )
		textTale1.text = "중간고사 1 A"
	end
	function inputTale9( )
		textTale1.text = "중간고사 1 AT"
	end
	function inputTale10( )
		textTale1.text = "중간고사 1 ATK"
	end
	function inputTale11( )
		textTale1.text = "중간고사 1 ATK "
	end
	function inputTale12( )
		textTale1.text = "중간고사 1 ATK 1"
	end
	function inputTale13( )
		textTale1.text = "중간고사 1 ATK 1 "
	end
	function inputTale14( )
		textTale1.text = "중간고사 1 ATK 1 D"
	end
	function inputTale15( )
		textTale1.text = "중간고사 1 ATK 1 DE"
	end
	function inputTale16( )
		textTale1.text = "중간고사 1 ATK 1 DEF"
	end
	function inputHead2( )
		textHead2 = display.newText( checkTextGroup, "*", 250, 470, "DungGeunMo.otf", 50 )
	end
	function inputTale17( )
		textTale2 = display.newText( checkTextGroup, "가", 275, 450, 700, 220, "DungGeunMo.otf", 40 )
		textTale2.anchorX, textTale2.anchorY = 0, 0
	end
	function inputTale18( )
		textTale2.text = "가장"
	end
	function inputTale19( )
		textTale2.text = "가장 "
	end
	function inputTale20( )
		textTale2.text = "가장 쉬"
	end
	function inputTale21( )
		textTale2.text = "가장 쉬운"
	end
	function inputTale22( )
		textTale2.text = "가장 쉬운 "
	end
	function inputTale23( )
		textTale2.text = "가장 쉬운 시"
	end
	function inputTale24( )
		textTale2.text = "가장 쉬운 시험"
	end
	function inputHead3( )
		textHead3 = display.newText( checkTextGroup, "*", 250, 530, "DungGeunMo.otf", 50 )
	end
	function inputTale25( )
		textTale3 = display.newText( checkTextGroup, "1", 275, 510, 700, 220, "DungGeunMo.otf", 40 )
		textTale3.anchorX, textTale3.anchorY = 0, 0
	end
	function inputTale26( )
		textTale3.text = "1 "
	end
	function inputTale27( )
		textTale3.text = "1 데"
	end
	function inputTale28( )
		textTale3.text = "1 데미"
	end
	function inputTale29( )
		textTale3.text = "1 데미지"
	end
	function inputTale30( )
		textTale3.text = "1 데미지만"
	end
	function inputTale31( )
		textTale3.text = "1 데미지만 "
	end
	function inputTale32( )
		textTale3.text = "1 데미지만 줄"
	end
	function inputTale33( )
		textTale3.text = "1 데미지만 줄 "
	end
	function inputTale34( )
		textTale3.text = "1 데미지만 줄 수"
	end
	function inputTale35( )
		textTale3.text = "1 데미지만 줄 수 "
	end
	function inputTale36( )
		textTale3.text = "1 데미지만 줄 수 있"
	end
	function inputTale37( )
		textTale3.text = "1 데미지만 줄 수 있다"
	end
	function inputTale38( )
		textTale3.text = "1 데미지만 줄 수 있다."
	end

	timer.performWithDelay( 0, inputHead1 )
	timer.performWithDelay( 50, inputTale1 )
	timer.performWithDelay( 100, inputTale2 )
	timer.performWithDelay( 150, inputTale3 )
	timer.performWithDelay( 150, inputTale3 )
	timer.performWithDelay( 200, inputTale4 )
	timer.performWithDelay( 250, inputTale5 )
	timer.performWithDelay( 300, inputTale6 )
	timer.performWithDelay( 350, inputTale7 )
	timer.performWithDelay( 400, inputTale8 )
	timer.performWithDelay( 450, inputTale9 )
	timer.performWithDelay( 500, inputTale10 )
	timer.performWithDelay( 550, inputTale11 )
	timer.performWithDelay( 600, inputTale12 )
	timer.performWithDelay( 650, inputTale13 )
	timer.performWithDelay( 700, inputTale14 )
	timer.performWithDelay( 750, inputTale15 )
	timer.performWithDelay( 800, inputTale16 )
	timer.performWithDelay( 850, inputHead2 )
	timer.performWithDelay( 900, inputTale17 )
	timer.performWithDelay( 950, inputTale18 )
	timer.performWithDelay( 1000, inputTale19 )
	timer.performWithDelay( 1050, inputTale20 )
	timer.performWithDelay( 1100, inputTale21 )
	timer.performWithDelay( 1150, inputTale22 )
	timer.performWithDelay( 1200, inputTale23 )
	timer.performWithDelay( 1250, inputTale24 )
	timer.performWithDelay( 1300, inputHead3 )
	timer.performWithDelay( 1300, inputTale25 )
	timer.performWithDelay( 1350, inputTale26 )
	timer.performWithDelay( 1400, inputTale27 )
	timer.performWithDelay( 1450, inputTale28 )
	timer.performWithDelay( 1500, inputTale29 )
	timer.performWithDelay( 1550, inputTale30 )
	timer.performWithDelay( 1600, inputTale31 )
	timer.performWithDelay( 1650, inputTale32 )
	timer.performWithDelay( 1700, inputTale33 )
	timer.performWithDelay( 1750, inputTale34 )
	timer.performWithDelay( 1800, inputTale35 )
	timer.performWithDelay( 1850, inputTale36 )
	timer.performWithDelay( 1900, inputTale37 )
	timer.performWithDelay( 2000, inputTale38 )
end

function inputMercyText( )
	mercyTextGroup = display.newGroup( )

	function inputHead( )
		textHead = display.newText( mercyTextGroup, "*", 250, 410, "DungGeunMo.otf", 50 )
	end
	function inputTale1( )
		textTale = display.newText( mercyTextGroup, "지", 275, 390, 700, 220, "DungGeunMo.otf", 40 )
		textTale.anchorX, textTale.anchorY = 0, 0
	end
	function inputTale2( )
		textTale.text = "지금"
	end
	function inputTale3( )
		textTale.text = "지금 "
	end
	function inputTale4( )
		textTale.text = "지금 와"
	end
	function inputTale5( )
		textTale.text = "지금 와서"
	end
	function inputTale6( )
		textTale.text = "지금 와서 "
	end
	function inputTale7( )
		textTale.text = "지금 와서 이"
	end
	function inputTale8( )
		textTale.text = "지금 와서 이런"
	end
	function inputTale9( )
		textTale.text = "지금 와서 이런 "
	end
	function inputTale10( )
		textTale.text = "지금 와서 이런 일"
	end
	function inputTale11( )
		textTale.text = "지금 와서 이런 일을"
	end
	function inputTale12( )
		textTale.text = "지금 와서 이런 일을 "
	end
	function inputTale13( )
		textTale.text = "지금 와서 이런 일을 해"
	end
	function inputTale14( )
		textTale.text = "지금 와서 이런 일을 해봤"
	end
	function inputTale15( )
		textTale.text = "지금 와서 이런 일을 해봤자"
	end
	function inputTale16( )
		textTale.text = "지금 와서 이런 일을 해봤자 "
	end
	function inputTale17( )
		textTale.text = "지금 와서 이런 일을 해봤자 과"
	end
	function inputTale18( )
		textTale.text = "지금 와서 이런 일을 해봤자 과연"
	end
	function inputTale19( )
		textTale.text = "지금 와서 이런 일을 해봤자 과연 "
	end
	function inputTale20( )
		textTale.text = "지금 와서 이런 일을 해봤자 과연 의"
	end
	function inputTale21( )
		textTale.text = "지금 와서 이런 일을 해봤자 과연 의미"
	end
	function inputTale22( )
		textTale.text = "지금 와서 이런 일을 해봤자 과연 의미가"
	end
	function inputTale23( )
		textTale.text = "지금 와서 이런 일을 해봤자 과연 의미가 "
	end
	function inputTale24( )
		textTale.text = "지금 와서 이런 일을 해봤자 과연 의미가 있"
	end
	function inputTale25( )
		textTale.text = "지금 와서 이런 일을 해봤자 과연 의미가 있을"
	end
	function inputTale26( )
		textTale.text = "지금 와서 이런 일을 해봤자 과연 의미가 있을까"
	end
	function inputTale27( )
		textTale.text = "지금 와서 이런 일을 해봤자 과연 의미가 있을까?"
	end

	timer.performWithDelay( 0, inputHead )
	timer.performWithDelay( 50, inputTale1 )
	timer.performWithDelay( 100, inputTale2 )
	timer.performWithDelay( 150, inputTale3 )
	timer.performWithDelay( 150, inputTale3 )
	timer.performWithDelay( 200, inputTale4 )
	timer.performWithDelay( 250, inputTale5 )
	timer.performWithDelay( 300, inputTale6 )
	timer.performWithDelay( 350, inputTale7 )
	timer.performWithDelay( 400, inputTale8 )
	timer.performWithDelay( 450, inputTale9 )
	timer.performWithDelay( 500, inputTale10 )
	timer.performWithDelay( 550, inputTale11 )
	timer.performWithDelay( 600, inputTale12 )
	timer.performWithDelay( 650, inputTale13 )
	timer.performWithDelay( 700, inputTale14 )
	timer.performWithDelay( 750, inputTale15 )
	timer.performWithDelay( 800, inputTale16 )
	timer.performWithDelay( 850, inputTale17 )
	timer.performWithDelay( 900, inputTale18 )
	timer.performWithDelay( 950, inputTale19 )
	timer.performWithDelay( 1000, inputTale20 )
	timer.performWithDelay( 1050, inputTale21 )
	timer.performWithDelay( 1100, inputTale22 )
	timer.performWithDelay( 1150, inputTale23 )
	timer.performWithDelay( 1200, inputTale24 )
	timer.performWithDelay( 1250, inputTale25 )
	timer.performWithDelay( 1300, inputTale26 )
	timer.performWithDelay( 1350, inputTale27 )
end


function inputItemText( )
	itemTextGroup = display.newGroup( )

	function inputHead1( )
		textHead1 = display.newText( itemTextGroup, "*", 250, 410, "DungGeunMo.otf", 50 )
	end
	function inputTale1( )
		textTale1 = display.newText( itemTextGroup, "당", 275, 390, 700, 220, "DungGeunMo.otf", 40 )
		textTale1.anchorX, textTale1.anchorY = 0, 0
	end
	function inputTale2( )
		textTale1.text = "당신"
	end
	function inputTale3( )
		textTale1.text = "당신은"
	end
	function inputTale4( )
		textTale1.text = "당신은 "
	end
	function inputTale5( )
		textTale1.text = "당신은 스"
	end
	function inputTale6( )
		textTale1.text = "당신은 스누"
	end
	function inputTale7( )
		textTale1.text = "당신은 스누피"
	end
	function inputTale8( )
		textTale1.text = "당신은 스누피우"
	end
	function inputTale9( )
		textTale1.text = "당신은 스누피우유"
	end
	function inputTale10( )
		textTale1.text = "당신은 스누피우유를"
	end
	function inputTale11( )
		textTale1.text = "당신은 스누피우유를 "
	end
	function inputTale12( )
		textTale1.text = "당신은 스누피우유를 마"
	end
	function inputTale13( )
		textTale1.text = "당신은 스누피우유를 마셨"
	end
	function inputTale14( )
		textTale1.text = "당시은 스누피우유를 마셨다"
	end
	function inputTale15( )
		textTale1.text = "당신은 스누피우유를 마셨다."
	end
	function inputHead2( )
		textHead2 = display.newText( itemTextGroup, "*", 250, 470, "DungGeunMo.otf", 50 )
	end
	function inputTale16( )
		textTale2 = display.newText( itemTextGroup, "잠", 275, 450, 700, 220, "DungGeunMo.otf", 40 )
		textTale2.anchorX, textTale2.anchorY = 0, 0
	end
	function inputTale17( )
		textTale2.text = "잠이"
	end
	function inputTale18( )
		textTale2.text = "잠이  "
	end
	function inputTale19( )
		textTale2.text = "잠이 오"
	end
	function inputTale20( )
		textTale2.text = "잠이 오지"
	end
	function inputTale21( )
		textTale2.text = "잠이 오지 "
	end
	function inputTale22( )
		textTale2.text = "잠이 오지 않"
	end
	function inputTale23( )
		textTale2.text = "잠이 오지 않는"
	end
	function inputTale24( )
		textTale2.text = "잠이 오지 않는다"
	end
	function inputTale25( )
		textTale2.text = "잠이 오지 않는다."
	end
	function inputHead3( )
		textHead3 = display.newText( itemTextGroup, "*", 250, 530, "DungGeunMo.otf", 50 )
	end
	function inputTale26( )
		textTale3 = display.newText( itemTextGroup, "체", 275, 510, 700, 220, "DungGeunMo.otf", 40 )
		textTale3.anchorX, textTale3.anchorY = 0, 0
	end
	function inputTale27( )
		textTale3.text = "체력"
	end
	function inputTale28( )
		textTale3.text = "체력이"
	end
	function inputTale29( )
		textTale3.text = "체력이 "
	end
	function inputTale30( )
		textTale3.text = "체력이 전"
	end
	function inputTale31( )
		textTale3.text = "체력이 전부"
	end
	function inputTale32( )
		textTale3.text = "체력이 전부 "
	end
	function inputTale33( )
		textTale3.text = "체력이 전부 회"
	end
	function inputTale34( )
		textTale3.text = "체력이 전부 회복"
	end
	function inputTale35( )
		textTale3.text = "체력이 전부 회복되"
	end
	function inputTale36( )
		textTale3.text = "체력이 전부 회복되었"
	end
	function inputTale37( )
		textTale3.text = "체력이 전부 회복되었다"
	end
	function inputTale38( )
		textTale3.text = "체력이 전부 회복되었다."
	end

	timer.performWithDelay( 0, inputHead1 )
	timer.performWithDelay( 50, inputTale1 )
	timer.performWithDelay( 100, inputTale2 )
	timer.performWithDelay( 150, inputTale3 )
	timer.performWithDelay( 150, inputTale3 )
	timer.performWithDelay( 200, inputTale4 )
	timer.performWithDelay( 250, inputTale5 )
	timer.performWithDelay( 300, inputTale6 )
	timer.performWithDelay( 350, inputTale7 )
	timer.performWithDelay( 400, inputTale8 )
	timer.performWithDelay( 450, inputTale9 )
	timer.performWithDelay( 500, inputTale10 )
	timer.performWithDelay( 550, inputTale11 )
	timer.performWithDelay( 600, inputTale12 )
	timer.performWithDelay( 650, inputTale13 )
	timer.performWithDelay( 700, inputTale14 )
	timer.performWithDelay( 750, inputTale15 )
	timer.performWithDelay( 800, inputHead2 )
	timer.performWithDelay( 850, inputTale16 )
	timer.performWithDelay( 900, inputTale17 )
	timer.performWithDelay( 950, inputTale18 )
	timer.performWithDelay( 1000, inputTale19 )
	timer.performWithDelay( 1050, inputTale20 )
	timer.performWithDelay( 1100, inputTale21 )
	timer.performWithDelay( 1150, inputTale22 )
	timer.performWithDelay( 1200, inputTale23 )
	timer.performWithDelay( 1250, inputTale24 )
	timer.performWithDelay( 1300, inputTale25 )
	timer.performWithDelay( 1350, inputHead3 )
	timer.performWithDelay( 1400, inputTale26 )
	timer.performWithDelay( 1450, inputTale27 )
	timer.performWithDelay( 1500, inputTale28 )
	timer.performWithDelay( 1550, inputTale29 )
	timer.performWithDelay( 1600, inputTale30 )
	timer.performWithDelay( 1650, inputTale31 )
	timer.performWithDelay( 1700, inputTale32 )
	timer.performWithDelay( 1750, inputTale33 )
	timer.performWithDelay( 1800, inputTale34 )
	timer.performWithDelay( 1850, inputTale35 )
	timer.performWithDelay( 1900, inputTale36 )
	timer.performWithDelay( 1950, inputTale37 )
	timer.performWithDelay( 2000, inputTale38 )
end

local function talk0( )
	talk0Group = display.newGroup( )

	local function inputTextBalloon( )
		textBalloon = display.newRoundedRect( talk0Group, 870, 180, 200, 130, 15 )
		textBalloon:setFillColor( 255, 255, 255 )
	end

	local function inputText1( )
		Text = display.newText( talk0Group, "참", 785, 122.5, 180, 125, "DungGeunMo.otf", 24 )
		Text:setFillColor( 0, 0, 0 )
		Text.anchorX, Text.anchorY = 0, 0
		media.playSound( "sounds/talk_sans.wav" )
	end
	local function inputText2( )
		Text.text = "참,"
		media.playSound( "sounds/talk_sans.wav" )
	end
	local function inputText3( )
		Text.text = "참, "
		media.playSound( "sounds/talk_sans.wav" )
	end
	local function inputText4( )
		Text.text = "참, 아"
		media.playSound( "sounds/talk_sans.wav" )
	end
	local function inputText5( )
		Text.text = "참, 아름"
		media.playSound( "sounds/talk_sans.wav" )
	end
	local function inputText6( )
		Text.text = "참, 아름다"
		media.playSound( "sounds/talk_sans.wav" )
	end
	local function inputText7( )
		Text.text = "참, 아름다운"
		media.playSound( "sounds/talk_sans.wav" )
	end
	local function inputText8( )
		Text.text = "참, 아름다운 "
		media.playSound( "sounds/talk_sans.wav" )
	end
	local function inputText10( )
		Text.text = "참, 아름다운 날"
		media.playSound( "sounds/talk_sans.wav" )
	end
	local function inputText11( )
		Text.text = "참, 아름다운 날이"
		media.playSound( "sounds/talk_sans.wav" )
	end
	local function inputText12( )
		Text.text = "참, 아름다운 날이야"
		media.playSound( "sounds/talk_sans.wav" )
	end
	local function inputText13( )
		Text.text = "참, 아름다운 날이야."
		media.playSound( "sounds/talk_sans.wav" )
	end
	local function inputText14( )
		Text.text = "참, 아름다운 날이야. "
		media.playSound( "sounds/talk_sans.wav" )
	end
	local function inputText15( )
		Text.text = "참, 아름다운 날이야. 학"
		media.playSound( "sounds/talk_sans.wav" )
	end
	local function inputText16( )
		Text.text = "참, 아름다운 날이야. 학생"
		media.playSound( "sounds/talk_sans.wav" )
	end
	local function inputText17( )
		Text.text = "참, 아름다운 날이야. 학생들"
		media.playSound( "sounds/talk_sans.wav" )
	end
	local function inputText18( )
		Text.text = "참, 아름다운 날이야. 학생들이"
		media.playSound( "sounds/talk_sans.wav" )
	end
	local function inputText19( )
		Text.text = "참, 아름다운 날이야. 학생들이 "
		media.playSound( "sounds/talk_sans.wav" )
	end
	local function inputText20( )
		Text.text = "참, 아름다운 날이야. 학생들이 놀"
		media.playSound( "sounds/talk_sans.wav" )
	end
	local function inputText21( )
		Text.text = "참, 아름다운 날이야. 학생들이 놀기"
		media.playSound( "sounds/talk_sans.wav" )
	end
	local function inputText22( )
		Text.text = "참, 아름다운 날이야. 학생들이 놀기만"
		media.playSound( "sounds/talk_sans.wav" )
	end
	local function inputText23( )
		Text.text = "참, 아름다운 날이야. 학생들이 놀기만하"
		media.playSound( "sounds/talk_sans.wav" )
	end
	local function inputText24( )
		Text.text = "참, 아름다운 날이야. 학생들이 놀기만하고"
		media.playSound( "sounds/talk_sans.wav" )
	end

	timer.performWithDelay( 0, inputTextBalloon )
	timer.performWithDelay( 75, inputText1 )
	timer.performWithDelay( 150, inputText2 )
	timer.performWithDelay( 225, inputText3 )
	timer.performWithDelay( 300, inputText4 )
	timer.performWithDelay( 375, inputText5 )
	timer.performWithDelay( 450, inputText6 )
	timer.performWithDelay( 525, inputText7 )
	timer.performWithDelay( 600, inputText8 )
	timer.performWithDelay( 675, inputText9 )
	timer.performWithDelay( 750, inputText10 )
	timer.performWithDelay( 825, inputText11 )
	timer.performWithDelay( 900, inputText12 )
	timer.performWithDelay( 975, inputText13 )
	timer.performWithDelay( 1050, inputText14 )
	timer.performWithDelay( 1125, inputText15 )
	timer.performWithDelay( 1200, inputText16 )
	timer.performWithDelay( 1275, inputText17 )
	timer.performWithDelay( 1350, inputText18 )
	timer.performWithDelay( 1425, inputText19 )
	timer.performWithDelay( 1500, inputText20 )
	timer.performWithDelay( 1575, inputText21 )
	timer.performWithDelay( 1650, inputText22 )
	timer.performWithDelay( 1725, inputText23 )
	timer.performWithDelay( 1800, inputText24 )
end

local function startAnimation( )
	startAnimationBox1 = display.newRect( 640, 360, 1280, 720 )
	startAnimationBox1:setFillColor( 0, 0, 0 )

	startAnimationPlayer = display.newImage( "images/player.png" )
	startAnimationPlayer.x = 200
	startAnimationPlayer.y = 360

	startAnimationBox2 = display.newRect( 640, 360, 1280, 720 )
	startAnimationBox2:setFillColor( 0, 0, 0 )

	local function soundOutputFlash( )
		media.playSound( "sounds/soul_battle_flash.wav" )
	end
	local function soundOutputStart( )
		media.playSound( "sounds/soul_battle_start.wav" )
	end

	local function startAnimation1( )
		startAnimationBox2.y = 1080
	end
	local function startAnimation2( )
		startAnimationBox2.y = 360
	end
	local function endStartAnimation( )
		startAnimationBox1:removeSelf( )
		startAnimationBox1 = nil
		startAnimationBox2:removeSelf( )
		startAnimationBox2 = nil
	end

	local function movePlayerAnimation( )
		transition.moveTo( startAnimationPlayer, { x = 640, y = 480, time = 400 } )
	end

	timer.performWithDelay( 0, startAnimation1 )
	timer.performWithDelay( 100, startAnimation2 )
	timer.performWithDelay( 200, startAnimation1 )
	timer.performWithDelay( 300, startAnimation2 )
	timer.performWithDelay( 400, startAnimation1 )

	timer.performWithDelay( 400, movePlayerAnimation )

	timer.performWithDelay( 0, soundOutputFlash )
	timer.performWithDelay( 125, soundOutputFlash )
	timer.performWithDelay( 250, soundOutputFlash )
	timer.performWithDelay( 400, soundOutputStart )

	timer.performWithDelay( 900, endStartAnimation )
end

local function pattern0( )
	hidePlayerBox = display.newRect( 640, 480, 870, 220 )
	hidePlayerBox:setFillColor( 0, 0, 0 )

	timer.performWithDelay( 500, talk0 )


end
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
Runtime:addEventListener( "touch", movePlayer )
Runtime:addEventListener( "enterFrame", moveingPlayer )
Runtime:addEventListener( "enterFrame", checkFrame )

DpadUp:addEventListener( "touch", DpadUpFunction )
DpadDown:addEventListener( "touch", DpadDownFunction )
DpadRight:addEventListener( "touch", DpadRightFunction )
DpadLeft:addEventListener( "touch", DpadLeftFunction )

buttonA:addEventListener( "touch", buttonAFunction )
buttonB:addEventListener( "touch", buttonBFunction )

player:addEventListener( "collision", damegeJudge )
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
--timer.performWithDelay( 0, startAnimation )
--timer.performWithDelay( 900, pattern0 )
-----------------------------------------------------------------------------------------