-----------------------------------------------------------------------------------------
local physics = require( "physics" )
physics.start( )
physics.setGravity( 0, 0 )
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
display.setStatusBar( display.HiddenStatusBar )
native.setProperty( "androidSystemUiVisibility", "immersiveSticky" )
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
moveX = 0
moveY = 0
moveSpeed = 3.5

currentStage = 0
currentPhase = 0
playerBoxLocation = 0
playerMovingBool = false
playerDamageBool = false
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

-----------------------------------------------------------------------------------

-----------------------------------------------------------------------------------
boxBack = display.newImage( "images/boxBack.png" )
boxBack.x = 640
boxBack.y = 480

boxFront = display.newImage( "images/boxFront.png" )
boxFront.x = 640
boxFront.y = 480

boxOutLineUp = display.newImage( "images/boxOutLineUpDown.png" )
boxOutLineUp.x = 640
boxOutLineUp.y = 380
physics.addBody( boxOutLineUp, "static" )
boxOutLineUp.id = "boxOutLineUp"

boxOutLineDown = display.newImage( "images/boxOutLineUpDown.png" )
boxOutLineDown.x = 640
boxOutLineDown.y = 580
physics.addBody( boxOutLineDown, "static" )
boxOutLineDown.id = "boxOutLineDown"

boxOutLineRight = display.newImage( "images/boxOutLineRightLeft.png" )
boxOutLineRight.x = 532.5
boxOutLineRight.y = 360
physics.addBody( boxOutLineRight, "static" )
boxOutLineRight.id = "boxOutLineRight"

boxOutLineLeft = display.newImage( "images/boxOutLineRightLeft.png" )
boxOutLineLeft.x = 747.5
boxOutLineLeft.y = 360
physics.addBody( boxOutLineLeft, "static" )
boxOutLineLeft.id = "boxOutLineLeft"
-----------------------------------------------------------------------------------

-----------------------------------------------------------------------------------
boxAttackOn = display.newImage( "images/boxAttackOn.png" )
boxAttackOn.x = 290
boxAttackOn.y = 680

boxActOn = display.newImage( "images/boxActOn.png" )
boxActOn.x = 525
boxActOn.y = 680

boxItemOn = display.newImage( "images/boxItemOn.png" )
boxItemOn.x = 760
boxItemOn.y = 680

boxMercyOn = display.newImage( "images/boxMercyOn.png" )
boxMercyOn.x = 995
boxMercyOn.y = 680
-----------------------------------------------------------------------------------

-----------------------------------------------------------------------------------
boxAttackOver = display.newImage( "images/boxAttackOver.png" )
boxAttackOver.x = 290
boxAttackOver.y = 1000

boxActOver = display.newImage( "images/boxActOver.png" )
boxActOver.x = 525
boxActOver.y = 1000

boxItemOver = display.newImage( "images/boxItemOver.png" )
boxItemOver.x = 760
boxItemOver.y = 1000

boxMercyOver = display.newImage( "images/boxMercyOver.png" )
boxMercyOver.x = 995
boxMercyOver.y = 1000
-----------------------------------------------------------------------------------

-----------------------------------------------------------------------------------
playerName = display.newText( "CHARA", 262.5, 610, "MonsterFriendFore.otf", 42 )

playerLV = display.newText( "LV 1", 410, 610, "MonsterFriendFore.otf", 42 )

HpText = display.newText( "HP", 545, 610, "MonsterFriendFore.otf", 35 )

playerMaxHpBar = display.newRect( 572, 614, 38, 32 )
playerMaxHpBar.anchorX, playerMaxHpBar.anchorY = 0, 0.5
playerMaxHpBar:setFillColor( 255, 0, 0 )

playerCurrentHpBar = display.newRect( 572, 614, 38, 32 )
playerCurrentHpBar.anchorX, playerCurrentHpBar.anchorY = 0, 0.5
playerCurrentHpBar:setFillColor( 80, 150, 0 )

playerCurrentHpText = display.newText( "20", 660, 610, "MonsterFriendFore.otf", 42 )

playerMaxHpText = display.newText( "/ 20", 700, 610, "MonsterFriendFore.otf", 42 )
playerMaxHpText.anchorX, playerMaxHpText.anchorY = 0, 0.5
-----------------------------------------------------------------------------------

-----------------------------------------------------------------------------------
player = display.newImage( "images/player.png" )
player.x = 640
player.y = 480
physics.addBody( player, { friction = 0, density = 0, bounce = 0 } )
player.hp = 20
-----------------------------------------------------------------------------------

-----------------------------------------------------------------------------------
boss = display.newImage( "images/boss.png" )
boss.x = 640
boss.y = 200
boss:scale( 1.5, 1.5 )
-----------------------------------------------------------------------------------

-----------------------------------------------------------------------------------
Dpad = display.newCircle( 105, 600, 100 )
Dpad.x = 105
Dpad.y = 600

DpadUp = display.newImage( "images/DpadUpDown.png")
DpadUp.x = Dpad.x
DpadUp.y = Dpad.y - 50

DpadDown = display.newImage( "images/DpadUpDown.png" )
DpadDown.x = Dpad.x
DpadDown.y = Dpad.y + 50

DpadRight = display.newImage( "images/DpadRightLeft.png" )
DpadRight.x = Dpad.x + 50
DpadRight.y = Dpad.y

DpadLeft = display.newImage( "images/DpadRightLeft.png" )
DpadLeft.x = Dpad.x - 50
DpadLeft.y = Dpad.y

DpadCenter = display.newRect( 105, 600, 50, 50 )
DpadCenter.x = 105
DpadCenter.y = 600
-----------------------------------------------------------------------------------

-----------------------------------------------------------------------------------
buttonA = display.newImage( "images/buttonA.png" )
buttonA.x = 1175
buttonA.y = 625

buttonB = display.newImage( "images/buttonB.png" )
buttonB.x = 1175
buttonB.y = 475
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
local function movePlayer( event )
	if currentStage == 0 then
		if event.x < 195 and event.x > 130 and event.y < 625 and event.y > 575 then
			moveX = moveSpeed
			moveY = 0
			playerMovingBool = true
		elseif event.x < 80 and event.x > 5 and event.y < 625 and event.y > 575 then
			moveX = -moveSpeed
			moveY = 0
			playerMovingBool = true
		elseif event.y < 575 and event.y > 510 and event.x < 130 and event.x > 80 then
			moveX = 0
			moveY = -moveSpeed
			playerMovingBool = true
		elseif event.y < 690 and event.y > 625 and event.x < 130 and event.x > 80 then
			moveX = 0
			moveY = moveSpeed
			playerMovingBool = true
		elseif event.x < 130 and event.x > 80 and event.y < 625 and event.y > 575 then
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

			elseif playerBoxLocation == 3 then

			end
		end
	end
end

local function DpadLeftFunction( event )
	if event.phase == "began" then
		system.vibrate( )
		if currentStage == 1 then
			if playerBoxLocation == 0 then

			elseif playerBoxLocation == 1 then
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

				MainTextGroup:removeSelf( )

				player.x = 250
				player.y = 417.5

				attackText = display.newText( "* 중간고사", 390, 415, "DungGeunMo.otf", 40 )

				attackBar = display.newRect( 650, 420, 200, 20 )
				attackBar:setFillColor( 0, 255, 0 )

			elseif playerBoxLocation == 1 then
				currentStage = 3

				MainTextGroup:removeSelf( )

				player.x = 250
				player.y = 417.5

				actText = display.newText( "* 중간고사", 390, 415, "DungGeunMo.otf", 40 )

			elseif playerBoxLocation == 3 then
				currentStage = 5

				MainTextGroup:removeSelf( )

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

			if currentPhase == 0 then
				timer.performWithDelay( 0, inputMainText0 )
			elseif currentPhase == 1 then
				timer.performWithDelay( 0, inputMainText1 )
			end

			player.x = boxAttackOver.x - 53
			player.y = 680

		elseif currentStage == 3 then
			currentStage = 1

			actText:removeSelf( )

			if currentPhase == 0 then
				timer.performWithDelay( 0, inputMainText0 )
			elseif currentPhase == 1 then
				timer.performWithDelay( 0, inputMainText1 )
			end

			player.x = boxActOver.x - 53
			player.y = 680

		elseif currentStage == 4 then

		elseif currentStage == 5 then
			currentStage = 1

			mercyText:removeSelf( )

			if currentPhase == 0 then
				timer.performWithDelay( 0, inputMainText0 )
			elseif currentPhase == 1 then
				timer.performWithDelay( 0, inputMainText1 )
			end

			player.x = boxMercyOver.x - 53
			player.y = 680

		elseif currentStage == 31 then
			currentStage = 3

			actSelectText:removeSelf( )

			actText = display.newText( "* 중간고사", 390, 415, "DungGeunMo.otf", 40 )
		end
	end
end

local function BGM( )
	media.playSound( "sounds/BGM.mp3", true )
end

local function myTrun( )
	currentStage = 1
	playerBoxLocation = 0

	if currentPhase == 0 then
		timer.performWithDelay( 0, inputMainText0 )
	elseif currentPhase == 1 then
		timer.performWithDelay( 0, inputMainText1 )
	end

	player.x = boxAttackOver.x - 53
	player.y = 680

	boxAttackOn.y = 1000
	boxAttackOver.y = 680
end

local function damageJudge( event )
	if event.phase == "began" then
		if event.other.id == "boxOutLineUp" then
			playerDamageBool = false
		elseif event.other.id == "boxOutLineDown" then
			playerDamageBool = false
		elseif event.other.id == "boxOutLineLeft" then
			playerDamageBool = false
		elseif event.other.id == "boxOutLineRight" then
			playerDamageBool = false
		else
			playerDamageBool = true
		end
	end
	if event.phase == "ended" then
		playerDamageBool = false
	end
end

local function frameCheck( event )
	if playerDamageBool == true then
		if player.hp > 0 then
			player.hp = player.hp - 1
			playerCurrentHpBar.width = playerMaxHpBar.width * ( player.hp / 20 )
			if player.hp == 19 then
				playerCurrentHpText.text = 19
			elseif player.hp == 18 then
				playerCurrentHpText.text = 18
			elseif player.hp == 17 then
				playerCurrentHpText.text = 17
			elseif player.hp == 16 then
				playerCurrentHpText.text = 16
			elseif player.hp == 15 then
				playerCurrentHpText.text = 15
			elseif player.hp == 14 then
				playerCurrentHpText.text = 14
			elseif player.hp == 13 then
				playerCurrentHpText.text = 13
			elseif player.hp == 12 then
				playerCurrentHpText.text = 12
			elseif player.hp == 11 then
				playerCurrentHpText.text = 11
			elseif player.hp == 10 then
				playerCurrentHpText.text = 10
			elseif player.hp == 9 then
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
			end
		end
	end

	player.x = player.x + moveX
	player.y = player.y + moveY
end

function inputMainText0( )

	MainTextGroup = display.newGroup( )

	function input1( )
		text1 = display.newText( MainTextGroup, "*", 250, 415, "DungGeunMo.otf", 50 )
	end
	function input2( )
		text2 = display.newText( MainTextGroup, "당", 290, 420, "DungGeunMo.otf", 40 )
	end
	function input3( )
		text3 = display.newText( MainTextGroup, "신", 330, 420, "DungGeunMo.otf", 40 )
	end
	function input4( )
		text4 = display.newText( MainTextGroup, "은", 370, 420, "DungGeunMo.otf", 40 )
	end
	function input5( )
		text5 = display.newText( MainTextGroup, "끔", 430, 420, "DungGeunMo.otf", 40 )
	end
	function input6( )
		text6 = display.newText( MainTextGroup, "직", 470, 420, "DungGeunMo.otf", 40 )
	end
	function input7( )
		text7 = display.newText( MainTextGroup, "한", 510, 420, "DungGeunMo.otf", 40 )
	end
	function input8( )
		text8 = display.newText( MainTextGroup, "내", 570, 420, "DungGeunMo.otf", 40 )
	end
	function input9( )
		text9 = display.newText( MainTextGroup, "신", 610, 420, "DungGeunMo.otf", 40 )
	end
	function input10( )
		text10 = display.newText( MainTextGroup, "을", 650, 420, "DungGeunMo.otf", 40 )
	end
	function input11( )
		text11 = display.newText( MainTextGroup, "받", 710, 420, "DungGeunMo.otf", 40 )
	end
	function input12( )
		text12 = display.newText( MainTextGroup, "을", 750, 420, "DungGeunMo.otf", 40 )
	end
	function input13( )
		text13 = display.newText( MainTextGroup, "것", 810, 420, "DungGeunMo.otf", 40 )
	end
	function input14( )
		text14 = display.newText( MainTextGroup, "같", 870, 420, "DungGeunMo.otf", 40 )
	end
	function input15( )
		text15 = display.newText( MainTextGroup, "다", 910, 420, "DungGeunMo.otf", 40 )
	end

	timer.performWithDelay( 0, input1 )
	timer.performWithDelay( 50, input2 )
	timer.performWithDelay( 100, input3 )
	timer.performWithDelay( 150, input4 )
	timer.performWithDelay( 225, input5 )
	timer.performWithDelay( 275, input6 )
	timer.performWithDelay( 325, input7 )
	timer.performWithDelay( 400, input8 )
	timer.performWithDelay( 450, input9 )
	timer.performWithDelay( 500, input10 )
	timer.performWithDelay( 575, input11 )
	timer.performWithDelay( 625, input12 )
	timer.performWithDelay( 700, input13 )
	timer.performWithDelay( 775, input14 )
	timer.performWithDelay( 825, input15 )
end

function inputMainText1( )

	MainTextGroup = display.newGroup( )

	function input1( )
		text1 = display.newText( MainTextGroup, "*", 250, 415, "DungGeunMo.otf", 50 )
	end
	function input2( )
		text2 = display.newText( MainTextGroup, "진", 290, 420, "DungGeunMo.otf", 40 )
	end
	function input3( )
		text3 = display.newText( MainTextGroup, "정", 330, 420, "DungGeunMo.otf", 40 )
	end
	function input4( )
		text4 = display.newText( MainTextGroup, "한", 370, 420, "DungGeunMo.otf", 40 )
	end
	function input5( )
		text5 = display.newText( MainTextGroup, "시", 430, 420, "DungGeunMo.otf", 40 )
	end
	function input6( )
		text6 = display.newText( MainTextGroup, "험", 470, 420, "DungGeunMo.otf", 40 )
	end
	function input7( )
		text7 = display.newText( MainTextGroup, "이", 510, 420, "DungGeunMo.otf", 40 )
	end
	function input8( )
		text8 = display.newText( MainTextGroup, "시", 570, 420, "DungGeunMo.otf", 40 )
	end
	function input9( )
		text9 = display.newText( MainTextGroup, "작", 610, 420, "DungGeunMo.otf", 40 )
	end
	function input10( )
		text10 = display.newText( MainTextGroup, "됬", 650, 420, "DungGeunMo.otf", 40 )
	end
	function input11( )
		text11 = display.newText( MainTextGroup, "다", 690, 420, "DungGeunMo.otf", 40 )
	end

	timer.performWithDelay( 0, input1 )
	timer.performWithDelay( 50, input2 )
	timer.performWithDelay( 100, input3 )
	timer.performWithDelay( 150, input4 )
	timer.performWithDelay( 225, input5 )
	timer.performWithDelay( 275, input6 )
	timer.performWithDelay( 325, input7 )
	timer.performWithDelay( 400, input8 )
	timer.performWithDelay( 450, input9 )
	timer.performWithDelay( 500, input10 )
	timer.performWithDelay( 575, input11 )
end

function inputCheckText( )
	checkTextGroup = display.newGroup( )

	function input1( )
		text1 = display.newText( checkTextGroup, "*", 250, 415, "DungGeunMo.otf", 50 )
	end
	function input2( )
		text2 = display.newText( checkTextGroup, "중", 290, 420, "DungGeunMo.otf", 40 )
	end
	function input3( )
		text3 = display.newText( checkTextGroup, "간", 330, 420, "DungGeunMo.otf", 40 )
	end
	function input4( )
		text4 = display.newText( checkTextGroup, "고", 370, 420, "DungGeunMo.otf", 40 )
	end
	function input5( )
		text5 = display.newText( checkTextGroup, "사", 410, 420, "DungGeunMo.otf", 40 )
	end
	function input6( )
		text6 = display.newText( checkTextGroup, "1", 470, 420, "DungGeunMo.otf", 40 )
	end
	function input7( )
		text7 = display.newText( checkTextGroup, "A", 530, 420, "DungGeunMo.otf", 40 )
	end
	function input8( )
		text8 = display.newText( checkTextGroup, "T", 560, 420, "DungGeunMo.otf", 40 )
	end
	function input9( )
		text9 = display.newText( checkTextGroup, "K", 590, 420, "DungGeunMo.otf", 40 )
	end
	function input10( )
		text10 = display.newText( checkTextGroup, "1", 650, 420, "DungGeunMo.otf", 40 )
	end
	function input11( )
		text11 = display.newText( checkTextGroup, "D", 710, 420, "DungGeunMo.otf", 40 )
	end
	function input12( )
		text12 = display.newText( checkTextGroup, "E", 740, 420, "DungGeunMo.otf", 40 )
	end
	function input13( )
		text13 = display.newText( checkTextGroup, "F", 770, 420, "DungGeunMo.otf", 40 )
	end
	function input14( )
		text14 = display.newText( checkTextGroup, "*", 250, 470, "DungGeunMo.otf", 50 )
	end
	function input15( )
		text15 = display.newText( checkTextGroup, "가", 290, 475, "DungGeunMo.otf", 40 )
	end
	function input16( )
		text16 = display.newText( checkTextGroup, "장", 330, 475, "DungGeunMo.otf", 40 )
	end
	function input17( )
		text17 = display.newText( checkTextGroup, "쉬", 390, 475, "DungGeunMo.otf", 40 )
	end
	function input18( )
		text18 = display.newText( checkTextGroup, "운", 430, 475, "DungGeunMo.otf", 40 )
	end
	function input19( )
		text19 = display.newText( checkTextGroup, "시", 490, 475, "DungGeunMo.otf", 40 )
	end
	function input20( )
		text20 = display.newText( checkTextGroup, "험", 530, 475, "DungGeunMo.otf", 40 )
	end
	function input21( )
		text21 = display.newText( checkTextGroup, "*", 250, 525, "DungGeunMo.otf", 50 )
	end
	function input22( )
		text22 = display.newText( checkTextGroup, "1", 290, 530, "DungGeunMo.otf", 40 )
	end
	function input23( )
		text23 = display.newText( checkTextGroup, "데", 350, 530, "DungGeunMo.otf", 40 )
	end
	function input24( )
		text24 = display.newText( checkTextGroup, "미", 390, 530, "DungGeunMo.otf", 40 )
	end
	function input25( )
		text25 = display.newText( checkTextGroup, "지", 430, 530, "DungGeunMo.otf", 40 )
	end
	function input26( )
		text26 = display.newText( checkTextGroup, "만", 470, 530, "DungGeunMo.otf", 40 )
	end
	function input27( )
		text27 = display.newText( checkTextGroup, "줄", 530, 530, "DungGeunMo.otf", 40 )
	end
	function input28( )
		text28 = display.newText( checkTextGroup, "수", 590, 530, "DungGeunMo.otf", 40 )
	end
	function input29( )
		text29 = display.newText( checkTextGroup, "있", 650, 530, "DungGeunMo.otf", 40 )
	end
	function input30( )
		text30 = display.newText( checkTextGroup, "다", 690, 530, "DungGeunMo.otf", 40 )
	end


	timer.performWithDelay( 0, input1 )
	timer.performWithDelay( 50, input2 )
	timer.performWithDelay( 100, input3 )
	timer.performWithDelay( 150, input4 )
	timer.performWithDelay( 200, input5 )
	timer.performWithDelay( 275, input6 )
	timer.performWithDelay( 350, input7 )
	timer.performWithDelay( 400, input8 )
	timer.performWithDelay( 450, input9 )
	timer.performWithDelay( 525, input10 )
	timer.performWithDelay( 600, input11 )
	timer.performWithDelay( 650, input12 )
	timer.performWithDelay( 700, input13 )
	timer.performWithDelay( 750, input14 )
	timer.performWithDelay( 800, input15 )
	timer.performWithDelay( 850, input16 )
	timer.performWithDelay( 1000, input17 )
	timer.performWithDelay( 1050, input18 )
	timer.performWithDelay( 1100, input19 )
	timer.performWithDelay( 1150, input20 )
	timer.performWithDelay( 1200, input21 )
	timer.performWithDelay( 1300, input22 )
	timer.performWithDelay( 1350, input23 )
	timer.performWithDelay( 1400, input24 )
	timer.performWithDelay( 1450, input25 )
	timer.performWithDelay( 1500, input26 )
	timer.performWithDelay( 1550, input27 )
	timer.performWithDelay( 1600, input28 )
	timer.performWithDelay( 1650, input29 )
	timer.performWithDelay( 1700, input30 )
end

function inputMercyText( )

	mercyTextGroup = display.newGroup( )

	function input1( )
		text1 = display.newText( mercyTextGroup, "*", 250, 415, "DungGeunMo.otf", 50 )
	end
	function input2( )
		text2 = display.newText( mercyTextGroup, "이", 290, 420, "DungGeunMo.otf", 40 )
	end
	function input3( )
		text3 = display.newText( mercyTextGroup, "런", 330, 420, "DungGeunMo.otf", 40 )
	end
	function input4( )
		text4 = display.newText( mercyTextGroup, "짓", 390, 420, "DungGeunMo.otf", 40 )
	end
	function input5( )
		text5 = display.newText( mercyTextGroup, "이", 430, 420, "DungGeunMo.otf", 40 )
	end
	function input6( )
		text6 = display.newText( mercyTextGroup, "쓸", 490, 420, "DungGeunMo.otf", 40 )
	end
	function input7( )
		text7 = display.newText( mercyTextGroup, "모", 530, 420, "DungGeunMo.otf", 40 )
	end
	function input8( )
		text8 = display.newText( mercyTextGroup, "가", 570, 420, "DungGeunMo.otf", 40 )
	end
	function input9( )
		text9 = display.newText( mercyTextGroup, "있", 630, 420, "DungGeunMo.otf", 40 )
	end
	function input10( )
		text10 = display.newText( mercyTextGroup, "을", 670, 420, "DungGeunMo.otf", 40 )
	end
	function input11( )
		text11 = display.newText( mercyTextGroup, "까", 710, 420, "DungGeunMo.otf", 40 )
	end


	timer.performWithDelay( 0, input1 )
	timer.performWithDelay( 50, input2 )
	timer.performWithDelay( 100, input3 )
	timer.performWithDelay( 150, input4 )
	timer.performWithDelay( 200, input5 )
	timer.performWithDelay( 250, input6 )
	timer.performWithDelay( 300, input7 )
	timer.performWithDelay( 350, input8 )
	timer.performWithDelay( 400, input9 )
	timer.performWithDelay( 450, input10 )
	timer.performWithDelay( 500, input11 )
end

function inputTalk0( )
	Talk0Group1 = display.newGroup( )
	Talk0Group2 = display.newGroup( )

	function inputBallon1( )
		textBallon1 = display.newRect( Talk0Group1, 890, 170, 330, 160 )
	end
	function input1( )
		text1 = display.newText( Talk0Group1, "참", 770, 120, "DungGeunMo.otf", 30 )
		text1:setFillColor( 0, 0, 0 )
	end
	function input2( )
		text2 = display.newText( Talk0Group1, "아", 810, 120, "DungGeunMo.otf", 30 )
		text2:setFillColor( 0, 0, 0 )
	end
	function input3( )
		text3 = display.newText( Talk0Group1, "름", 840, 120, "DungGeunMo.otf", 30 )
		text3:setFillColor( 0, 0, 0 )
	end
	function input4( )
		text4 = display.newText( Talk0Group1, "다", 870, 120, "DungGeunMo.otf", 30 )
		text4:setFillColor( 0, 0, 0 )
	end
	function input5( )
		text5 = display.newText( Talk0Group1, "운", 900, 120, "DungGeunMo.otf", 30 )
		text5:setFillColor( 0, 0, 0 )
	end
	function input6( )
		text6 = display.newText( Talk0Group1, "날", 950, 120, "DungGeunMo.otf", 30 )
		text6:setFillColor( 0, 0, 0 )
	end
	function input7( )
		text7 = display.newText( Talk0Group1, "이", 980, 120, "DungGeunMo.otf", 30 )
		text7:setFillColor( 0, 0, 0 )
	end
	function input8( )
		text8 = display.newText( Talk0Group1, "야", 1010, 120, "DungGeunMo.otf", 30 )
		text8:setFillColor( 0, 0, 0 )
	end
	function input9( )
		text9 = display.newText( Talk0Group1, "안", 770, 150, "DungGeunMo.otf", 30 )
		text9:setFillColor( 0, 0, 0 )
	end
	function input10( )
		text10 = display.newText( Talk0Group1, "그", 800, 150, "DungGeunMo.otf", 30 )
		text10:setFillColor( 0, 0, 0 )
	end
	function input11( )
		text11 = display.newText( Talk0Group1, "래", 830, 150, "DungGeunMo.otf", 30 )
		text11:setFillColor( 0, 0, 0 )
	end
	function input12( )
		text12 = display.newText( Talk0Group1, "?", 855, 150, "DungGeunMo.otf", 30 )
		text12:setFillColor( 0, 0, 0 )
	end
	function input13( )
		text13 = display.newText( Talk0Group1, "이", 770, 180, "DungGeunMo.otf", 30 )
		text13:setFillColor( 0, 0, 0 )
	end
	function input16( )
		text16 = display.newText( Talk0Group1, "런", 800, 180, "DungGeunMo.otf", 30 )
		text16:setFillColor( 0, 0, 0 )
	end
	function input17( )
		text17 = display.newText( Talk0Group1, "날", 840, 180, "DungGeunMo.otf", 30 )
		text17:setFillColor( 0, 0, 0 )
	end
	function input18( )
		text18 = display.newText( Talk0Group1, "너", 880, 180, "DungGeunMo.otf", 30 )
		text18:setFillColor( 0, 0, 0 )
	end
	function input19( )
		text19 = display.newText( Talk0Group1, "같", 920, 180, "DungGeunMo.otf", 30 )
		text19:setFillColor( 0, 0, 0 )
	end
	function input20( )
		text20 = display.newText( Talk0Group1, "은", 950, 180, "DungGeunMo.otf", 30 )
		text20:setFillColor( 0, 0, 0 )
	end
	function input21( )
		text21 = display.newText( Talk0Group1, "애", 770, 210, "DungGeunMo.otf", 30 )
		text21:setFillColor( 0, 0, 0 )
	end
	function input22( )
		text22 = display.newText( Talk0Group1, "는", 800, 210, "DungGeunMo.otf", 30 )
		text22:setFillColor( 0, 0, 0 )
	end
	function endInput1( )
		Talk0Group1:removeSelf( )
		Talk0Group1 = nil
	end
	function inputBallon2( )
		textBallon2 = display.newRect( Talk0Group2, 835, 137.5, 200, 80 )
	end
	function input23( )
		text23 = display.newText( Talk0Group2, "시", 770, 120, "DungGeunMo.otf", 30 )
		text23:setFillColor( 255, 0, 0 )
	end
	function input24( )
		text24 = display.newText( Talk0Group2, "험", 800, 120, "DungGeunMo.otf", 30 )
		text24:setFillColor( 255, 0, 0 )
	end
	function input25( )
		text25 = display.newText( Talk0Group2, "에", 830, 120, "DungGeunMo.otf", 30 )
		text25:setFillColor( 255, 0, 0 )
	end
	function input26( )
		text26 = display.newText( Talk0Group2, "서", 860, 120, "DungGeunMo.otf", 30 )
		text26:setFillColor( 255, 0, 0 )
	end
	function input27( )
		text27 = display.newText( Talk0Group2, "불", 770, 150, "DungGeunMo.otf", 30 )
		text27:setFillColor( 255, 0, 0 )
	end
	function input28( )
		text28 = display.newText( Talk0Group2, "타", 800, 150, "DungGeunMo.otf", 30 )
		text28:setFillColor( 255, 0, 0 )
	end
	function input29( )
		text29 = display.newText( Talk0Group2, "야", 830, 150, "DungGeunMo.otf", 30 )
		text29:setFillColor( 255, 0, 0 )
	end
	function input30( )
		text30 = display.newText( Talk0Group2, "돼", 860, 150, "DungGeunMo.otf", 30 )
		text30:setFillColor( 255, 0, 0 )
	end
	function endInput2( )
		Talk0Group2:removeSelf( )
		Talk0Group2 = nil
	end


	timer.performWithDelay( 0, inputBallon1 )
	timer.performWithDelay( 100, input1 )
	timer.performWithDelay( 200, input2 )
	timer.performWithDelay( 300, input3 )
	timer.performWithDelay( 400, input4 )
	timer.performWithDelay( 500, input5 )
	timer.performWithDelay( 600, input6 )
	timer.performWithDelay( 700, input7 )
	timer.performWithDelay( 800, input8 )
	timer.performWithDelay( 900, input9 )
	timer.performWithDelay( 1000, input10 )
	timer.performWithDelay( 1100, input11 )
	timer.performWithDelay( 1200, input12 )
	timer.performWithDelay( 1300, input13 )
	timer.performWithDelay( 1400, input16 )
	timer.performWithDelay( 1500, input17 )
	timer.performWithDelay( 1600, input18 )
	timer.performWithDelay( 1700, input19 )
	timer.performWithDelay( 1800, input20 )
	timer.performWithDelay( 1900, input21 )
	timer.performWithDelay( 2000, input22 )
	timer.performWithDelay( 2800, endInput1 )
	timer.performWithDelay( 3790, inputBallon2 )
	timer.performWithDelay( 3800, input23 )
	timer.performWithDelay( 4300, input24 )
	timer.performWithDelay( 4800, input25 )
	timer.performWithDelay( 5300, input26 )
	timer.performWithDelay( 5800, input27 )
	timer.performWithDelay( 6300, input28 )
	timer.performWithDelay( 6800, input29 )
	timer.performWithDelay( 7300, input30 )
	timer.performWithDelay( 8500, endInput2 )
end

function inputTalk1( )
	Talk1Group = display.newGroup( )

	function inputBallon( )
		textBallon = display.newRect( Talk1Group, 835, 137.5, 200, 80 )
	end
	function input1( )
		text1 = display.newText( Talk1Group, "시", 770, 120, "DungGeunMo.otf", 30 )
		text1:setFillColor( 0, 0, 0 )
	end
	function input2( )
		text2 = display.newText( Talk1Group, "작", 800, 120, "DungGeunMo.otf", 30 )
		text2:setFillColor( 0, 0, 0 )
	end
	function input3( )
		text3 = display.newText( Talk1Group, "하", 830, 120, "DungGeunMo.otf", 30 )
		text3:setFillColor( 0, 0, 0 )
	end
	function input4( )
		text4 = display.newText( Talk1Group, "자", 860, 120, "DungGeunMo.otf", 30 )
		text4:setFillColor( 0, 0, 0 )
	end
	function input5( )
		text5 = display.newText( Talk1Group, "제", 770, 150, "DungGeunMo.otf", 30 )
		text5:setFillColor( 0, 0, 0 )
	end
	function input6( )
		text6 = display.newText( Talk1Group, "대", 800, 150, "DungGeunMo.otf", 30 )
		text6:setFillColor( 0, 0, 0 )
	end
	function input7( )
		text7 = display.newText( Talk1Group, "로", 830, 150, "DungGeunMo.otf", 30 )
		text7:setFillColor( 0, 0, 0 )
	end
	function endInput( )
		Talk1Group:removeSelf( )
		Talk0Group2 = nil
	end

	timer.performWithDelay( 0, inputBallon )
	timer.performWithDelay( 100, input1 )
	timer.performWithDelay( 200, input2 )
	timer.performWithDelay( 300, input3 )
	timer.performWithDelay( 400, input4 )
	timer.performWithDelay( 500, input5 )
	timer.performWithDelay( 600, input6 )
	timer.performWithDelay( 700, input7 )
	timer.performWithDelay( 1100, endInput )
end

function gameStart( )
	currentStage = 100

	startBox1 = display.newRect( 640, 360, 1280, 720 )
	startBox1:setFillColor( 0, 0, 0 )

	aniPlayer = display.newImage( "images/player.png" )
	aniPlayer.x = 200
	aniPlayer.y = 300

	startBox2 = display.newRect( 640, 360, 1280, 720 )
	startBox2:setFillColor( 0, 0, 0 )

	function changeBox1( )
		startBox2.x = 400000
	end
	function changeBox2( )
		startBox2.x = 640
	end
	function movePlayerToCenter( )
		transition.moveTo( aniPlayer, { x = 640, y = 480, time = 500} )
	end
	function endStartAnimation( )
		startBox1:removeSelf( )
		startBox1 = nil

		startBox2:removeSelf( )
		startBox2 = nil

		aniPlayer:removeSelf( )
		aniPlayer = nil
	end

	timer.performWithDelay( 0, changeBox2 )
	timer.performWithDelay( 200, changeBox1 )
	timer.performWithDelay( 400, changeBox2 )
	timer.performWithDelay( 500, changeBox1 )

	timer.performWithDelay( 0, movePlayerToCenter )

	timer.performWithDelay( 900, endStartAnimation )
end

function pattern0( )
	pattern0Box1 = display.newRect( 640, 480, 860, 220 )
	pattern0Box1:setFillColor( 0, 0, 0 )

	function scalePattern0Box( )
		pattern0Box2 = display.newRect( 10000, 10000, 2000, 2000 )
		pattern0Box2:setFillColor( 0, 0, 0 )
		pattern0Box2.x = 640
		pattern0Box2.y = 360
	end
	function removePattern0Box( )
		pattern0Box1:removeSelf( )
		pattern0Box1 = nil

		pattern0Box2:removeSelf( )
		pattern0Box2 = nil
	end
	function scaleBox( )
		transition.scaleTo( boxBack, { xScale = 0.25, yScale = 1, time = 0 } )
		transition.scaleTo( boxFront, { xScale = 0.25, yScale = 1, time = 0 } )
	end
	function changeStage( )
		currentStage = 0
	end

	function cautionAttack1( )
		pattern0Caution1 = display.newImage( "images/pattern0Caution1.png" )
		pattern0Caution1.x = 640
		pattern0Caution1.y = 480
	end

	function prepareAttack1( )
		pattern0Attack1 = display.newRect( 640, 590, 215, 150 )
		pattern0Attack1.anchorX, pattern0Attack1.anchorY = 0.5, 1
		pattern0Attack1:scale( 1, 0 )
	end
	function doAttack1( )
		pattern0Caution1:removeSelf( )
		pattern0Caution1 = nil

		transition.scaleTo( pattern0Attack1, { xScale = 1, yScale = 1, time = 100 } )

		function addBodyAttack1( )
			physics.addBody( pattern0Attack1, { isSensor = true } )
		end

		timer.performWithDelay( 100, addBodyAttack1 )
	end
	function endAttack1( )
		physics.removeBody( pattern0Attack1 )

		transition.scaleTo( pattern0Attack1, { xScale = 1, yScale = 0.0001, time = 300 } )

		function removeAttack1( )
			pattern0Attack1:removeSelf( )
			pattern0Attack1 = nil
		end

		timer.performWithDelay( removeAttack1, 110 )
	end

	function cautionAttack2( )
		pattern0Caution2 = display.newImage( "images/pattern0Caution2.png" )
		pattern0Caution2.x = 640
		pattern0Caution2.y = 490
		pattern0Caution2:scale( 1, 0.99 )
	end
	function prepareAttack2( )
		pattern0Attack2 = display.newRect( 747.5, 390, 215, 20 )
		pattern0Attack2.anchorX, pattern0Attack2.anchorY = 1, 0.5
		pattern0Attack2:scale( 0, 1 )

		pattern0Attack3 = display.newRect( 747.5, 410, 215, 20 )
		pattern0Attack3.anchorX, pattern0Attack3.anchorY = 1, 0.5
		pattern0Attack3:scale( 0, 1 )

		pattern0Attack4 = display.newRect( 747.5, 430, 215, 20 )
		pattern0Attack4.anchorX, pattern0Attack4.anchorY = 1, 0.5
		pattern0Attack4:scale( 0, 1 )

		pattern0Attack5 = display.newRect( 747.5, 450, 215, 20 )
		pattern0Attack5.anchorX, pattern0Attack5.anchorY = 1, 0.5
		pattern0Attack5:scale( 0, 1 )

		pattern0Attack6 = display.newRect( 747.5, 470, 215, 20 )
		pattern0Attack6.anchorX, pattern0Attack6.anchorY = 1, 0.5
		pattern0Attack6:scale( 0, 1 )

		pattern0Attack7 = display.newRect( 747.5, 490, 215, 20 )
		pattern0Attack7.anchorX, pattern0Attack7.anchorY = 1, 0.5
		pattern0Attack7:scale( 0, 1 )

		pattern0Attack8 = display.newRect( 747.5, 510, 215, 20 )
		pattern0Attack8.anchorX, pattern0Attack8.anchorY = 1, 0.5
		pattern0Attack8:scale( 0, 1 )

		pattern0Attack9 = display.newRect( 747.5, 530, 215, 20 )
		pattern0Attack9.anchorX, pattern0Attack9.anchorY = 1, 0.5
		pattern0Attack9:scale( 0, 1 )
	end
	function doAttack2( )
		pattern0Caution2:removeSelf( )
		pattern0Caution2 = nil

		function doAttack2_1( )
			transition.scaleTo( pattern0Attack2, { xScale = 1, yScale = 1, time = 100 } )

			function addBodyAttack2_1( )
				physics.addBody( pattern0Attack2, { isSensor = true } )
			end

			timer.performWithDelay( 100, addBodyAttack2_1 )
		end
		function doAttack2_2( )
			transition.scaleTo( pattern0Attack3, { xScale = 1, yScale = 1, time = 100 } )

			function addBodyAttack2_2( )
				physics.addBody( pattern0Attack3, { isSensor = true } )
			end

			timer.performWithDelay( 100, addBodyAttack2_2 )
		end
		function doAttack2_3( )
			transition.scaleTo( pattern0Attack4, { xScale = 1, yScale = 1, time = 100 } )

			function addBodyAttack2_3( )
				physics.addBody( pattern0Attack4, { isSensor = true } )
			end

			timer.performWithDelay( 100, addBodyAttack2_3 )
		end
		function doAttack2_4( )
			transition.scaleTo( pattern0Attack5, { xScale = 1, yScale = 1, time = 100 } )

			function addBodyAttack2_4( )
				physics.addBody( pattern0Attack5, { isSensor = true } )
			end

			timer.performWithDelay( 100, addBodyAttack2_4 )
		end
		function doAttack2_5( )
			transition.scaleTo( pattern0Attack6, { xScale = 1, yScale = 1, time = 100 } )

			function addBodyAttack2_5( )
				physics.addBody( pattern0Attack6, { isSensor = true } )
			end

			timer.performWithDelay( 100, addBodyAttack2_5 )
		end
		function doAttack2_6( )
			transition.scaleTo( pattern0Attack7, { xScale = 1, yScale = 1, time = 100 } )

			function addBodyAttack2_6( )
				physics.addBody( pattern0Attack7, { isSensor = true } )
			end

			timer.performWithDelay( 100, addBodyAttack2_6 )
		end
		function doAttack2_7( )
			transition.scaleTo( pattern0Attack8, { xScale = 1, yScale = 1, time = 100 } )

			function addBodyAttack2_7( )
				physics.addBody( pattern0Attack8, { isSensor = true } )
			end

			timer.performWithDelay( 100, addBodyAttack2_7 )
		end
		function doAttack2_8( )
			transition.scaleTo( pattern0Attack9, { xScale = 1, yScale = 1, time = 100 } )

			function addBodyAttack2_8( )
				physics.addBody( pattern0Attack9, { isSensor = true } )
			end

			timer.performWithDelay( 100, addBodyAttack2_8 )
		end

		timer.performWithDelay( 0, doAttack2_1 )
		timer.performWithDelay( 50, doAttack2_2 )
		timer.performWithDelay( 100, doAttack2_3 )
		timer.performWithDelay( 150, doAttack2_4 )
		timer.performWithDelay( 200, doAttack2_5 )
		timer.performWithDelay( 250, doAttack2_6 )
		timer.performWithDelay( 300, doAttack2_7 )
		timer.performWithDelay( 350, doAttack2_8 )
	end
	function endAttack2( )
		transition.scaleTo( pattern0Attack2, { xScale = 0.0001, yScale = 1, time = 100 } )
		physics.removeBody( pattern0Attack2 )
		transition.scaleTo( pattern0Attack3, { xScale = 0.0001, yScale = 1, time = 100 } )
		physics.removeBody( pattern0Attack3 )
		transition.scaleTo( pattern0Attack4, { xScale = 0.0001, yScale = 1, time = 100 } )
		physics.removeBody( pattern0Attack4 )
		transition.scaleTo( pattern0Attack5, { xScale = 0.0001, yScale = 1, time = 100 } )
		physics.removeBody( pattern0Attack5 )
		transition.scaleTo( pattern0Attack6, { xScale = 0.0001, yScale = 1, time = 100 } )
		physics.removeBody( pattern0Attack6 )
		transition.scaleTo( pattern0Attack7, { xScale = 0.0001, yScale = 1, time = 100 } )
		physics.removeBody( pattern0Attack7 )
		transition.scaleTo( pattern0Attack8, { xScale = 0.0001, yScale = 1, time = 100 } )
		physics.removeBody( pattern0Attack8 )
		transition.scaleTo( pattern0Attack9, { xScale = 0.0001, yScale = 1, time = 100 } )
		physics.removeBody( pattern0Attack9 )

		function removeAttack2( )
			pattern0Attack2:removeSelf( )
			pattern0Attack2 = nil
			pattern0Attack3:removeSelf( )
			pattern0Attack3 = nil
			pattern0Attack4:removeSelf( )
			pattern0Attack4 = nil
			pattern0Attack5:removeSelf( )
			pattern0Attack5 = nil
			pattern0Attack6:removeSelf( )
			pattern0Attack6 = nil
			pattern0Attack7:removeSelf( )
			pattern0Attack7 = nil
			pattern0Attack8:removeSelf( )
			pattern0Attack8 = nil
			pattern0Attack9:removeSelf( )
			pattern0Attack9 = nil
		end

		timer.performWithDelay( 1000, removeAttack2 )
	end

	function prepareAttack3( )
		pattern0Attack10 = display.newCircle( -200, 0, 60 )
		pattern0Attack11 = display.newCircle( 1480, 0, 60 )
		pattern0Attack12 = display.newCircle( 640, -200, 60 )
		physics.addBody( pattern0Attack10, { isSensor = true } )
		physics.addBody( pattern0Attack11, { isSensor = true } )
		physics.addBody( pattern0Attack12, { isSensor = true } )
	end
	function cautionAttack3( )
		transition.moveTo( pattern0Attack10, { x = 400, y = 480, time = 100 } )
		transition.moveTo( pattern0Attack11, { x = 880, y = 480, time = 100 } )
		transition.moveTo( pattern0Attack12, { x = 640, y = 300, time = 100 } )
	end
	function doAttack3( )
		transition.moveTo( pattern0Attack10, { x = 1480, y = 480, time = 500 } )
		transition.moveTo( pattern0Attack11, { x = -200, y = 480, time = 500 } )
		transition.moveTo( pattern0Attack12, { x = 640, y = 920, time = 500 } )
	end
	function endAttack3( )
		pattern0Attack10:removeSelf( )
		pattern0Attack10 = nil
		pattern0Attack11:removeSelf( )
		pattern0Attack11 = nil
		pattern0Attack12:removeSelf( )
		pattern0Attack12 = nil
	end

	function prepareAttack4( )
		pattern0Attack13 = display.newCircle( -200, 395, 60 )
		pattern0Attack14 = display.newCircle( 1480, 565, 60 )
		physics.addBody( pattern0Attack13, { isSensor = true } )
		physics.addBody( pattern0Attack14, { isSensor = true } )
	end
	function cautionAttack4( )
		transition.moveTo( pattern0Attack13, { x = 400, y = 395, time = 100 } )
		transition.moveTo( pattern0Attack14, { x = 880, y = 565, time = 100 } )
	end
	function doAttack4( )
		transition.moveTo( pattern0Attack13, { x = 1480, y = 395, time = 500 } )
		transition.moveTo( pattern0Attack14, { x = -200, y = 565, time = 500 } )
	end
	function endAttack4( )
		pattern0Attack13:removeSelf( )
		pattern0Attack13 = nil
		pattern0Attack14:removeSelf( )
		pattern0Attack14 = nil
	end

	function prepareAttack5( )
		pattern0Attack15 = display.newCircle( 555, -200, 60 )
		pattern0Attack16 = display.newCircle( 725, -200, 60 )
		physics.addBody( pattern0Attack15, { isSensor = true } )
		physics.addBody( pattern0Attack16, { isSensor = true } )
	end
	function cautionAttack5( )
		transition.moveTo( pattern0Attack15, { x = 555, y = 300, time = 100 } )
		transition.moveTo( pattern0Attack16, { x = 725, y = 300, time = 100 } )
	end
	function doAttack5( )
		transition.moveTo( pattern0Attack15, { x = 565, y = 920, time = 500 } )
		transition.moveTo( pattern0Attack16, { x = 725, y = 920, time = 500 } )
	end
	function endAttack5( )
		pattern0Attack15:removeSelf( )
		pattern0Attack15 = nil
		pattern0Attack16:removeSelf( )
		pattern0Attack16 = nil
	end

	function prepareAttack6( )
		pattern0Attack17 = display.newCircle( -200, 395, 60 )
		pattern0Attack18 = display.newCircle( 1480, 565, 60 )
		pattern0Attack19 = display.newCircle( -200, 595, 60 )
		pattern0Attack20 = display.newCircle( 1480, 395, 60 )
		physics.addBody( pattern0Attack17, { isSensor = true } )
		physics.addBody( pattern0Attack18, { isSensor = true } )
		physics.addBody( pattern0Attack19, { isSensor = true } )
		physics.addBody( pattern0Attack20, { isSensor = true } )
	end
	function cautionAttack6( )
		transition.moveTo( pattern0Attack17, { x = 400, y = 395, time = 100 } )
		transition.moveTo( pattern0Attack18, { x = 880, y = 565, time = 100 } )
		transition.moveTo( pattern0Attack19, { x = 400, y = 565, time = 100 } )
		transition.moveTo( pattern0Attack20, { x = 880, y = 390, time = 100 } )
	end
	function doAttack6( )
		function doAttack6_1( )
			transition.moveTo( pattern0Attack17, { x = 880, y = 565, time = 100 } )
			transition.moveTo( pattern0Attack18, { x = 400, y = 395, time = 100 } )
			transition.moveTo( pattern0Attack19, { x = 880, y = 395, time = 100 } )
			transition.moveTo( pattern0Attack20, { x = 400, y = 565, time = 100 } )
		end
		function doAttack6_2( )
			transition.moveTo( pattern0Attack17, { x = 1480, y = 565, time = 100 } )
			transition.moveTo( pattern0Attack18, { x = -200, y = 395, time = 100 } )
			transition.moveTo( pattern0Attack19, { x = 1480, y = 395, time = 100 } )
			transition.moveTo( pattern0Attack20, { x = -200, y = 565, time = 100 } )
		end

		timer.performWithDelay( 0, doAttack6_1 )
		timer.performWithDelay( 500, doAttack6_2 )
	end
	function endAttack6( )
		pattern0Attack17:removeSelf( )
		pattern0Attack17 = nil
		pattern0Attack18:removeSelf( )
		pattern0Attack17 = nil
		pattern0Attack19:removeSelf( )
		pattern0Attack19 = nil
		pattern0Attack20:removeSelf( )
		pattern0Attack20 = nil
	end

	function endPattern0( )
		transition.to( target, params )
	end

	timer.performWithDelay( 200, inputTalk0 )
	timer.performWithDelay( 3300, scaleBox )
	timer.performWithDelay( 3000, scalePattern0Box )
	timer.performWithDelay( 3400, removePattern0Box )
	timer.performWithDelay( 8700, changeStage )

	timer.performWithDelay( 8700, cautionAttack1 )
	timer.performWithDelay( 9200, prepareAttack1 )
	timer.performWithDelay( 9400, doAttack1 )
	timer.performWithDelay( 10000, endAttack1 )

	timer.performWithDelay( 11500, cautionAttack2 )
	timer.performWithDelay( 11700, prepareAttack2 )
	timer.performWithDelay( 12000, doAttack2 )
	timer.performWithDelay( 13000, endAttack2 )

	timer.performWithDelay( 14000, prepareAttack3 )
	timer.performWithDelay( 14200, cautionAttack3 )
	timer.performWithDelay( 15000, doAttack3 )
	timer.performWithDelay( 15600, endAttack3 )

	timer.performWithDelay( 14200, prepareAttack4 )
	timer.performWithDelay( 15000, cautionAttack4 )
	timer.performWithDelay( 15800, doAttack4 )
	timer.performWithDelay( 16800, endAttack4 )

	timer.performWithDelay( 14000, prepareAttack5 )
	timer.performWithDelay( 15800, cautionAttack5 )
	timer.performWithDelay( 16600, doAttack5 )
	timer.performWithDelay( 17600, endAttack5 )

	timer.performWithDelay( 16000, prepareAttack6 )
	timer.performWithDelay( 16600, cautionAttack6 )
	timer.performWithDelay( 17200, doAttack6 )
	timer.performWithDelay( 18000, endAttack6 )

	timer.performWithDelay( 18200, inputTalk1 )

	timer.performWithDelay( 19400, endPattern0 )

	timer.performWithDelay( 20000, myTrun )
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
	timer.performWithDelay( 83, changeAimBar2 )
	timer.performWithDelay( 166, changeAimBar1 )
	timer.performWithDelay( 249, changeAimBar2 )
	timer.performWithDelay( 332, changeAimBar1 )
	timer.performWithDelay( 415, changeAimBar1 )
	timer.performWithDelay( 498, changeAimBar2 )
	timer.performWithDelay( 581, changeAimBar1 )
	timer.performWithDelay( 664, changeAimBar2 )
	timer.performWithDelay( 747, changeAimBar1 )
	timer.performWithDelay( 830, changeAimBar1 )
	timer.performWithDelay( 913, changeAimBar2 )
	timer.performWithDelay( 996, changeAimBar1 )
	timer.performWithDelay( 1079, changeAimBar2 )
	timer.performWithDelay( 1162, changeAimBar1 )
	timer.performWithDelay( 1250, removeAimBar )

	timer.performWithDelay( 0, attackAni )

	timer.performWithDelay( 600, missAni )

	timer.performWithDelay( 1250, removeAimBack )

	timer.performWithDelay( 0, moveBoss )
end
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
Runtime:addEventListener( "enterFrame", frameCheck )
Runtime:addEventListener( "touch", movePlayer )

DpadUp:addEventListener( "touch", DpadUpFunction )
DpadDown:addEventListener( "touch", DpadDownFunction )
DpadRight:addEventListener( "touch", DpadRightFunction )
DpadLeft:addEventListener( "touch", DpadLeftFunction )

buttonA:addEventListener( "touch", buttonAFunction )
buttonB:addEventListener( "touch", buttonBFunction )

player:addEventListener( "collision", damageJudge )
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
playBGM = timer.performWithDelay( 20900, BGM )
startGame = timer.performWithDelay( 0, gameStart )
startPattern0 = timer.performWithDelay( 900, pattern0 )
-----------------------------------------------------------------------------------------