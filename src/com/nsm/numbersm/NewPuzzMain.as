package com.nsm.numbersm {


import CustomData.AnswerList;
import CustomData.SingleCardNum;

import com.greensock.TimelineLite;

import com.greensock.TweenLite;


import flash.data.EncryptedLocalStore;

import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Loader;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.events.TransformGestureEvent;
import flash.media.SoundChannel;
import flash.media.SoundTransform;

import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.ui.Multitouch;
import flash.ui.MultitouchInputMode;
import flash.utils.ByteArray;
import flash.utils.Timer;

import Consts;
import SDUtils;
import flash.utils.setTimeout;

[SWF(width=960, height=620)]
public class NewPuzzMain extends Sprite {


    var time:int; //in secs +1
    var delay:int = 1000; // in milliseconds

    [Embed(source="../../../font/Franklin M54.ttf",
            fontName="M54font",
            mimeType = "application/x-font",
            fontWeight="normal",
            fontStyle="normal",
            advancedAntiAliasing="true",
            embedAsCFF="false")]
    public const M54_font:Class;
    //Embed Image
    [Embed(source='art_newpuz/play/bg.jpg')]
    private const BGStart:Class;
    [Embed(source='art_newpuz/menu/bg.jpg')]
    private const BGMenu:Class;
    [Embed(source='art_newpuz/bg.jpg')]
    private const BGChoseLevel:Class;

    [Embed(source='art_newpuz/3x3.png')]
    private const Level1IMG:Class;
    [Embed(source='art_newpuz/4x4.png')]
    private const Level2IMG:Class;
    [Embed(source='art_newpuz/5x5.png')]
    private const Level3IMG:Class;
    [Embed(source='art_newpuz/longline/3x3.png')]
    private const Level1Line:Class;
    [Embed(source='art_newpuz/longline/4x4.png')]
    private const Level2Line:Class;
    [Embed(source='art_newpuz/longline/5x5.png')]
    private const Level3Line:Class;


    //bg win
    [Embed(source='art_newpuz/winlose/win.jpg')]
    private const BGWIn:Class;

    //bg lose
    [Embed(source='art_newpuz/winlose/lose.jpg')]
    private const BGLose:Class;

    [Embed(source='art_newpuz/play/time.png')]
    private const timeSpriteImg:Class;

    [Embed(source='art_newpuz/menu/Play.png')]
    private const BtnStart:Class;

    //embed  sound
    [Embed(source='img/ButtonClick.mp3')]
    private const SoundClick:Class;
    [Embed(source='img/Win.mp3')]
    private const LevelClick:Class;
    [Embed(source='img/Purple-Planet.mp3')]
    private const MainSound:Class;
    [Embed(source='img/PickCell.mp3')]
    private const WinSound:Class;

    [Embed(source='art_newpuz/play/khungto.png')]
    private const KhungTo:Class;
    [Embed(source='art_newpuz/play/buoc.png')]
    private const KhungNho:Class;

    [Embed(source='img/ButtonClick.mp3')]
    private const MoveSound:Class;
    [Embed(source='img/Ta Da-SoundBible.com-1884170640.mp3')]
    private const TaDaSound:Class;

    [Embed(source='art_newpuz/winlose/replay.png')]
    private const reloadBtn:Class;
    [Embed(source='art_newpuz/winlose/home.png')]
    private const homeBtn:Class;

    [view(z=2)]
    public var rightList:Array = [];

    [view(z=5)]
    public var arrayNum:Array = [];

    var textCount:TextField = new TextField();
    public var moveSound:* = new MoveSound();

    public var tadaSound:* = new TaDaSound();




    public function NewPuzzMain() {
//        Firebase.init();
//        initPushNotify();
        welcomeGame();
    }

    private function welcomeGame():void {
        var bg:Bitmap = new BGMenu();
        bg = SDUtils.getFitImage(bg, Consts.GAME_WIDTH, Consts.GAME_HEIGHT);
        addChild(bg);
        var btnStart:DisplayObject = new BtnStart();
        btnStart.x = (bg.x + bg.width) / 2 - btnStart.width / 2;
        btnStart.y = bg.x + bg.height - btnStart.height - 100;
        var buttonWelcome:Sprite = new Sprite();
        buttonWelcome.graphics.clear();
        buttonWelcome.graphics.beginFill(0xD4D4D4, 0);
        buttonWelcome.graphics.drawEllipse((bg.x + bg.width) / 2 - btnStart.width / 2, bg.x + bg.height - btnStart.height - 100, btnStart.width, btnStart.height);
        buttonWelcome.graphics.endFill();
        buttonWelcome.addChild(btnStart);
        addChild(buttonWelcome);
        buttonWelcome.addEventListener(MouseEvent.CLICK, onChooseLevel);
    }

    function backHome(e:MouseEvent){
        timerTextField.visible = false;
        onChooseLevel(e);
    }

    private function onChooseLevel(e:MouseEvent){
        var bg:Bitmap = new BGChoseLevel();
        bg = SDUtils.getFitImage(bg, Consts.GAME_WIDTH, Consts.GAME_HEIGHT);
        addChild(bg);
        var text:TextField = new TextField();
        var formatText:TextFormat = new TextFormat();
        formatText.size = 35;
        formatText.color = 0xffffff;
        formatText.font = "M54font";
        text.embedFonts = true;
        text.defaultTextFormat = formatText;
        text.autoSize = TextFieldAutoSize.CENTER;
        text.text = "LEVELS & HIGH SCORE";
        text.setTextFormat(formatText);
        text.x = bg.x + (bg.width - text.width)/2;
        text.y = bg.y + 30;
        addChild(text);


        var Line3x3:DisplayObject = new Level1Line();
//        Line3x3.scaleX = Line3x3.scaleY = 1.1;
        Line3x3.x = bg.x + (bg.width - Line3x3.width)/2;
        Line3x3.y = bg.y + 140;
        addChild(Line3x3);
        var text:TextField = new TextField();
        var formatText:TextFormat = new TextFormat();
        formatText.size = 50;
        formatText.color = 0xd9d9d9;
        formatText.font = "M54font";
        text.embedFonts = true;
        text.defaultTextFormat = formatText;
        text.autoSize = TextFieldAutoSize.CENTER;
        text.text = getLocalStorage("hs1") ? getLocalStorage("hs1") : String(0);
        text.setTextFormat(formatText);
        text.x = Line3x3.x + (Line3x3.width - text.width)/2;
        text.y = Line3x3.y + (Line3x3.height - text.height)/2;
        addChild(text);

        var Line4x4:DisplayObject = new Level2Line();
//        Line4x4.scaleX = Line4x4.scaleY = 1.1;
        Line4x4.x = Line3x3.x;
        Line4x4.y = Line3x3.y + Line3x3.height + 30;
        addChild(Line4x4);
        var text:TextField = new TextField();
        var formatText:TextFormat = new TextFormat();
        formatText.size = 50;
        formatText.color = 0xd9d9d9;
        formatText.font = "M54font";
        text.embedFonts = true;
        text.defaultTextFormat = formatText;
        text.autoSize = TextFieldAutoSize.CENTER;
        text.text = getLocalStorage("hs2") ? getLocalStorage("hs2") : String(0);
        text.setTextFormat(formatText);
        text.x = Line4x4.x + (Line4x4.width - text.width)/2;
        text.y = Line4x4.y + (Line4x4.height - text.height)/2;
        addChild(text);

        var Line5x5:DisplayObject = new Level3Line();
//        Line5x5.scaleX = Line5x5.scaleY = 1.1;
        Line5x5.x = Line3x3.x;
        Line5x5.y = Line4x4.y + Line4x4.height + 30;
        addChild(Line5x5);
        var text:TextField = new TextField();
        var formatText:TextFormat = new TextFormat();
        formatText.size = 50;
        formatText.color = 0xd9d9d9;
        formatText.font = "M54font";
        text.embedFonts = true;
        text.defaultTextFormat = formatText;
        text.autoSize = TextFieldAutoSize.CENTER;
        text.text = getLocalStorage("hs3") ? getLocalStorage("hs3") : String(0);
        text.setTextFormat(formatText);
        text.x = Line5x5.x + (Line5x5.width - text.width)/2;
        text.y = Line5x5.y + (Line5x5.height - text.height)/2;
        addChild(text);

        var Level2:DisplayObject = new Level2IMG();
        Level2.x = Line4x4.x + Line4x4.width - Level2.width - 10;
        Level2.y = Line4x4.y + (Line4x4.height - Level2.height)/ 2;
        addChild(Level2);
        var Level2Btn:Sprite = new Sprite();
        Level2Btn.graphics.clear();
        Level2Btn.graphics.beginFill(0xD4D4D4, 0);
        Level2Btn.graphics.drawEllipse(Level2.x, Level2.y, Level2.width, Level2.height);
        Level2Btn.graphics.endFill();
        addChild(Level2Btn);
        Level2Btn.addEventListener(MouseEvent.CLICK, onInitGameLv2);

        var Level3:DisplayObject = new Level3IMG();
        Level3.x = Line5x5.x + Line5x5.width - Level3.width - 10;
        Level3.y = Line5x5.y + (Line5x5.height - Level3.height)/ 2;
        addChild(Level3);
        var Level3Btn:Sprite = new Sprite();
        Level3Btn.graphics.clear();
        Level3Btn.graphics.beginFill(0xD4D4D4, 0);
        Level3Btn.graphics.drawEllipse(Level3.x, Level3.y, Level3.width, Level3.height);
        Level3Btn.graphics.endFill();
        addChild(Level3Btn);
        Level3Btn.addEventListener(MouseEvent.CLICK, onInitGameLv3);

        var Level1:DisplayObject = new Level1IMG();
        Level1.x = Line3x3.x + Line3x3.width - Level1.width - 10;
        Level1.y = Line3x3.y + (Line3x3.height - Level1.height)/ 2;
        addChild(Level1);
        var Level1Btn:Sprite = new Sprite();
        Level1Btn.graphics.clear();
        Level1Btn.graphics.beginFill(0xD4D4D4, 0);
        Level1Btn.graphics.drawEllipse(Level1.x, Level1.y, Level1.width, Level1.height);
        Level1Btn.graphics.endFill();
        addChild(Level1Btn);
        Level1Btn.addEventListener(MouseEvent.CLICK, onInitGameLv1);
    }

    public function random(min:int, max:int):int {
        if (min == max) return min;
        if (min < max) return min + (Math.random() * (max - min + 1));
        else return max + (Math.random() * (min - max + 1));
    }

    //level 1
    var listForShuffer:Array = [1,2,3,4,5,6,7,8,9];
    var list:Array = [1,2,3,4,5,6,7,8,9];
    var isLevel1:Boolean = false;

    var listLv1Suf:Array = [
            [5,2,8,9,4,3,1,7,6],
            [1,6,3,2,7,5,9,4,8],
            [4,2,3,7,9,6,1,5,8],
            [2,4,7,1,9,3,5,8,6],
            [1,4,2,8,9,3,5,6,7],
            [5,8,9,2,7,3,1,4,6],
            [1,3,8,6,9,2,4,7,5]
    ];

    var listTest1:Array = [1,2,3,4,5,9,7,8,6];



    //level 2
    var listForShufferLv2:Array = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16];
    var listLv2:Array = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16];
    var isLevel2:Boolean = false;

    //level 3
    var listForShufferLv3:Array = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25];
    var listLv3:Array = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25];
    var isLevel3:Boolean = false;

    function onInitGameLv1(e:MouseEvent):void{
//        saveLocalStorage("hs1", "0");
        rightList = [];
        arrayNum = [];
        isLevel1 = true;
        isLevel2 = isLevel3 = false;
        time = 301;
//        initGame(list, listTest1);
        initGame(list, listLv1Suf[random(0,6)]);
    }

    function onInitGameLv2(e:MouseEvent):void{
        rightList = [];
        arrayNum = [];
        isLevel2 = true;
        isLevel1 = isLevel3 = false;
        time = 2001;
        initGame(listLv2, listForShufferLv2);
    }

    function onInitGameLv3(e:MouseEvent):void{
        rightList = [];
        arrayNum = [];
        isLevel3 = true;
        isLevel1 = isLevel2 = false;
        time = 8001;
        initGame(listLv3, listForShufferLv3);
    }

    var stepCount:Number = 0;

    function howToPlay(str:String, x:int, y:int, size:int, color:Object){
        var text:TextField = new TextField();
        var ft:TextFormat = new TextFormat();
        ft.size = size ;
        ft.color = color;
        ft.font = "M54font";
        text.embedFonts = true;
        text.defaultTextFormat = ft;
        text.autoSize = TextFieldAutoSize.CENTER;
        text.text = str;
        text.setTextFormat(ft);
        text.x = x;
        text.y = y;
        addChild(text);
    }

    private function initGame(listStraight:Array, listSuf:Array):void {
        var bg:Bitmap = new BGStart();
        bg = SDUtils.getFitImage(bg, Consts.GAME_WIDTH, Consts.GAME_HEIGHT);
        addChild(bg);
        timer();

        var khungNho:DisplayObject = new KhungNho();
        khungNho.scaleX = khungNho.scaleY = .8;
        khungNho.x = bg.x + bg.width - khungNho.width - 60;
        khungNho.y = bg.y + 25;
        addChild(khungNho);

        stepCount = 0;
        var formatText:TextFormat = new TextFormat();
        formatText.size = 50;
        formatText.color = 0x83d4be;
        formatText.font = "M54font";
        textCount.embedFonts = true;
        textCount.defaultTextFormat = formatText;
        textCount.autoSize = TextFieldAutoSize.CENTER;
        textCount.text = stepCount.toString();
        textCount.setTextFormat(formatText);
        textCount.x = khungNho.x + (khungNho.width - textCount.width)/2;
        textCount.y = khungNho.y + 10;
        addChild(textCount);

        var greyBoard2:DisplayObject = new KhungTo();
        greyBoard2.scaleY =  .4;
        greyBoard2.scaleX = .8;
        greyBoard2.x = bg.x + 50;
        greyBoard2.y = khungNho.y + 350;
        addChild(greyBoard2);

        howToPlay("How to Play:", greyBoard2.x + 10, greyBoard2.y + 10, 50, 0xfa7f05);
        howToPlay("Swipe to move number", greyBoard2.x + 10, greyBoard2.y + 60, 25, 0xf2b124);
        howToPlay("Make it consecutive", greyBoard2.x + 10, greyBoard2.y + 90, 25, 0xf2b124);
        howToPlay("Your score:", greyBoard2.x + 10, greyBoard2.y + 130, 50, 0xfa7f05);
        howToPlay("Is total time left", greyBoard2.x + 10, greyBoard2.y + 180, 25, 0xf2b124);



        var greyBoard:DisplayObject = new KhungTo();
        greyBoard.scaleY = .8 * 1.1;
        greyBoard.scaleX = (.8 / 1.4) * 1.1;
        greyBoard.x = khungNho.x + khungNho.width - greyBoard.width;
        greyBoard.y = khungNho.y + khungNho.height - 10;
        addChild(greyBoard);

        var btnHome:DisplayObject = new homeBtn();
        btnHome.scaleY = btnHome.scaleX = .9;
        btnHome.x = bg.x + 50;
        btnHome.y = bg.y + 100;
        addChild(btnHome);

        var homeSprite:Sprite= new Sprite();
        homeSprite.graphics.clear();
        homeSprite.graphics.beginFill(0xFFFFFF, 0);
        homeSprite.graphics.drawRoundRect(btnHome.x, btnHome.y, btnHome.width, btnHome.height,0,0);
        homeSprite.graphics.endFill();
        addChild(homeSprite);
        homeSprite.addEventListener(MouseEvent.CLICK, backHome);

        var btnReload:DisplayObject = new reloadBtn();
        btnReload.scaleY = btnReload.scaleX = .9;
        btnReload.x = btnHome.x + btnHome.width + 20;
        btnReload.y = btnHome.y;
        addChild(btnReload);

        var replaySprite:Sprite = new Sprite();
        replaySprite.graphics.clear();
        replaySprite.graphics.beginFill(0xFFFFFF, 0);
        replaySprite.graphics.drawRoundRect(btnReload.x, btnReload.y, btnReload.width, btnReload.height,0,0);
        replaySprite.graphics.endFill();
        addChild(replaySprite);

        timeSprite.scaleX = timeSprite.scaleY = .9;
        timeSprite.x = btnHome.x;
        timeSprite.y = btnReload.y + btnReload.height + 50;
        timerTextField.x = timeSprite.x + 5;
        timerTextField.y = timeSprite.y;

        if(isLevel1){
            replaySprite.addEventListener(MouseEvent.CLICK, onInitGameLv1);
        } else if(isLevel2){
            replaySprite.addEventListener(MouseEvent.CLICK, onInitGameLv2);
        } else if(isLevel3){
            replaySprite.addEventListener(MouseEvent.CLICK, onInitGameLv3);
        }


        var index1:Number = 0;

        if(listSuf.length > 10){
            shuffleArray(listSuf);
        }

        for(var i = 0; i < Math.sqrt(listStraight.length); i++){
            rightList[i] = [];
            for(var j= 0; j < Math.sqrt(listStraight.length); j++){
                var cardUnder:AnswerList = new AnswerList(listStraight[index1]);
                cardUnder.scaleX = cardUnder.scaleY = .91 * 1.1;
                if(listStraight.length == 16){
                    cardUnder.scaleX = cardUnder.scaleY = .67 * 1.1;
                } else if(listStraight.length == 25){
                    cardUnder.scaleX = cardUnder.scaleY = .52 * 1.1;
                }
                cardUnder.x = greyBoard.x + 10 + j * (cardUnder.width + 10);
                cardUnder.y = greyBoard.y + 7 + i * (cardUnder.height + 10);
                rightList[i].push(cardUnder);
                addChild(rightList[i][j]);
                index1++;
            }
        }
        var index:Number = 0;


        for(var i = 0; i < Math.sqrt(listSuf.length); i++){
            arrayNum[i] = [];
            for(var j= 0; j < Math.sqrt(listSuf.length); j++){
                var cardOver:SingleCardNum = new SingleCardNum(listSuf[index]);
                cardOver.scaleX = cardOver.scaleY = .91 * 1.1;
                if(listStraight.length == 16){
                    cardOver.scaleX = cardOver.scaleY = .67 * 1.1;
                } else if(listStraight.length == 25){
                    cardOver.scaleX = cardOver.scaleY = .52 * 1.1;
                }
                cardOver.x = greyBoard.x + 10 + j * (cardOver.width + 10);
                cardOver.y = -200 + i * (cardOver.height + 10);
                arrayNum[i].push(cardOver);
                addChild(arrayNum[i][j]);

                TweenLite.to(arrayNum[i][j], 0.3 + index * 0.1, {y: greyBoard.y + i * (cardOver.height + 10)});

                if(listSuf[index] == 9){
                    arrayNum[i][j].visible = false;
                }
                index++;
            }
        }

        setMoveFalse();
        setMovePosible();

        Multitouch.inputMode = MultitouchInputMode.GESTURE;
        var squareSwipe:Sprite = new Sprite();
        squareSwipe.graphics.clear();
        squareSwipe.graphics.beginFill(0xFFFFFF, 0);
        squareSwipe.graphics.drawRoundRect(greyBoard.x, greyBoard.y, greyBoard.width, greyBoard.height,0,0);
        squareSwipe.graphics.endFill();
        addChild(squareSwipe);

        squareSwipe.addEventListener(TransformGestureEvent.GESTURE_SWIPE, onSwipe);
    }


    public function setMovePosible():void{
        var isBreak:Boolean = false;

        for(var i:int = 0; i < arrayNum.length && !isBreak; i++){
            if(isBreak){
                return;
            }
            for(var j:int =0; j < arrayNum[i].length && !isBreak; j++){
                if(arrayNum[i][j].number == 9){
                    if(i == 0){
                        if(j == 0){
                            arrayNum[i][j + 1].canMoveLeft = true;
                                    arrayNum[i + 1][j].canMoveUp = true;
                            isBreak = true;
                            break;
                        } else if(j == arrayNum[i].length - 1){
                            arrayNum[i][j - 1].canMoveRight = true;
                                    arrayNum[i + 1][j].canMoveUp = true;
                            isBreak = true;
                            break;
                        } else {
                            arrayNum[i][j - 1].canMoveRight = true;
                                    arrayNum[i][j + 1].canMoveLeft = true;
                                            arrayNum[i + 1][j].canMoveUp = true;
                            isBreak = true;
                            break;
                        }
                    } else if (i == arrayNum.length - 1){
                        if(j == 0){
                            arrayNum[i - 1][j].canMoveDown = true;
                                    arrayNum[i][j + 1].canMoveLeft = true;
                            isBreak = true;
                            break;
                        } else if(j == arrayNum[i].length - 1){
                            arrayNum[i - 1][j].canMoveDown = true;
                                    arrayNum[i][j - 1].canMoveRight = true;
                            isBreak = true;
                            break;
                        } else {
                            arrayNum[i - 1][j].canMoveDown = true;
                                    arrayNum[i][j + 1].canMoveLeft = true;
                                            arrayNum[i][j - 1].canMoveRight = true;
                            isBreak = true;
                            break;
                        }
                    } else{
                        if(j == 0){
                            arrayNum[i - 1][j].canMoveDown = true;
                            arrayNum[i + 1][j].canMoveUp = true;
                            arrayNum[i][j + 1].canMoveLeft = true;
                            isBreak = true;
                            break;
                        } else if(j == arrayNum[i].length - 1){
                            arrayNum[i - 1][j].canMoveDown = true;
                            arrayNum[i + 1][j].canMoveUp = true;
                            arrayNum[i][j - 1].canMoveRight = true;
                            isBreak = true;
                            break;
                        } else {
                            arrayNum[i - 1][j].canMoveDown = true;
                            arrayNum[i + 1][j].canMoveUp = true;
                            arrayNum[i][j - 1].canMoveRight = true;
                            arrayNum[i][j + 1].canMoveLeft = true;
                            isBreak = true;
                            break;
                        }

                    }
                }
            }
        }
    }

    public function setMoveFalse():void{
        for(var i:int = 0; i < arrayNum.length; i++){
            for(var j:int = 0; j < arrayNum[i].length; j ++){
                arrayNum[i][j].canMoveLeft
                        = arrayNum[i][j].canMoveRight
                        = arrayNum[i][j].canMoveUp
                        = arrayNum[i][j].canMoveDown = false;
            }
        }
    }

    private function mouseRightHandler(e:MouseEvent):void{
        for(var i = 0; i < arrayNum.length; i++){
            for(var j = 0; j < arrayNum[i].length; j ++){
                if(arrayNum[i][j].number == 9 && j > 0){
                    var x = arrayNum[i][j - 1].x;
                    var y = arrayNum[i][j - 1].y;
                    var obj:SingleCardNum = arrayNum[i][j];
                    TweenLite.to(arrayNum[i][j - 1], 0.3, {x: arrayNum[i][j].x});
                    arrayNum[i][j].x = x;
                    arrayNum[i][j].y = y;
                    arrayNum[i][j] = arrayNum[i][j - 1];
                    arrayNum[i][j - 1] = obj;
                    setMoveFalse();
                    setMovePosible();
                    stepCount++;
                    textCount.text = stepCount.toString();
                    isWin(arrayNum.length);
                    return;
                }
            }
        }
    }
    private function mouseLeftHandler(e:MouseEvent):void{
        for(var i = 0; i < arrayNum.length; i++){
            for(var j = 0; j < arrayNum[i].length; j ++){
                if(arrayNum[i][j].number == 9 && j < arrayNum[i].length - 1){
                    var x = arrayNum[i][j + 1].x;
                    var y = arrayNum[i][j + 1].y;
                    var obj:SingleCardNum = arrayNum[i][j];
                    TweenLite.to(arrayNum[i][j + 1], 0.3, {x: arrayNum[i][j].x});
                    arrayNum[i][j].x = x;
                    arrayNum[i][j].y = y;
                    arrayNum[i][j] = arrayNum[i][j + 1];
                    arrayNum[i][j + 1] = obj;
                    setMoveFalse();
                    setMovePosible();
                    stepCount++;
                    textCount.text = stepCount.toString();
                    isWin(arrayNum.length);
                    return;
                }
            }
        }
    }
    private function mouseUpHandler(e:MouseEvent):void{
        for(var i = 0; i < arrayNum.length; i++){
            for(var j = 0; j < arrayNum[i].length; j ++){
                if(arrayNum[i][j].number == 9 && i < arrayNum.length - 1){
                    var x = arrayNum[i + 1][j].x;
                    var y = arrayNum[i + 1][j].y;
                    var obj:SingleCardNum = arrayNum[i][j];
                    TweenLite.to(arrayNum[i + 1][j], 0.3, {y: arrayNum[i][j].y});
                    arrayNum[i][j].x = x;
                    arrayNum[i][j].y = y;
                    arrayNum[i][j] = arrayNum[i + 1][j];
                    arrayNum[i + 1][j] = obj;
                    setMoveFalse();
                    setMovePosible();
                    stepCount++;
                    textCount.text = stepCount.toString();
                    isWin(arrayNum.length);
                    return;
                }
            }
        }
    }
    private function mouseDownHandler(e:MouseEvent):void{
        for(var i = 0; i < arrayNum.length; i++){
            for(var j = 0; j < arrayNum[i].length; j ++){
                if(arrayNum[i][j].number == 9 && i > 0){
                    var x = arrayNum[i - 1][j].x;
                    var y = arrayNum[i - 1][j].y;
                    var obj:SingleCardNum = arrayNum[i][j];
                    TweenLite.to(arrayNum[i - 1][j], 0.3, {y: arrayNum[i][j].y});
                    arrayNum[i][j].x = x;
                    arrayNum[i][j].y = y;
                    arrayNum[i][j] = arrayNum[i - 1][j];
                    arrayNum[i - 1][j] = obj;
                    setMoveFalse();
                    setMovePosible();
                    stepCount++;
                    textCount.text = stepCount.toString();
                    isWin(arrayNum.length);
                    return;
                }
            }
        }
    }

    function onSwipe (e:TransformGestureEvent):void{
        if (e.offsetX == 1) {
        //User swiped towards right
            for(var i = 0; i < arrayNum.length; i++){
                for(var j = 0; j < arrayNum[i].length; j ++){
                    if(arrayNum[i][j].number == 9 && j > 0){
                        var x = arrayNum[i][j - 1].x;
                        var y = arrayNum[i][j - 1].y;
                        var obj:SingleCardNum = arrayNum[i][j];
                        TweenLite.to(arrayNum[i][j - 1], 0.3, {x: arrayNum[i][j].x});
                        arrayNum[i][j].x = x;
                        arrayNum[i][j].y = y;
                        arrayNum[i][j] = arrayNum[i][j - 1];
                        arrayNum[i][j - 1] = obj;
                        setMoveFalse();
                        setMovePosible();
                        stepCount++;
                        textCount.text = stepCount.toString();
                        moveSound.play();
                        isWin(arrayNum.length);
                        return;
                    }
                }
            }
        } else if(e.offsetX == -1){
            for(var i = 0; i < arrayNum.length; i++){
                for(var j = 0; j < arrayNum[i].length; j ++){
                    if(arrayNum[i][j].number == 9 && j < arrayNum[i].length - 1){
                        var x = arrayNum[i][j + 1].x;
                        var y = arrayNum[i][j + 1].y;
                        var obj:SingleCardNum = arrayNum[i][j];
                        TweenLite.to(arrayNum[i][j + 1], 0.3, {x: arrayNum[i][j].x});
                        arrayNum[i][j].x = x;
                        arrayNum[i][j].y = y;
                        arrayNum[i][j] = arrayNum[i][j + 1];
                        arrayNum[i][j + 1] = obj;
                        setMoveFalse();
                        setMovePosible();
                        stepCount++;
                        textCount.text = stepCount.toString();
                        moveSound.play();
                        isWin(arrayNum.length);
                        return;
                    }
                }
            }
        } else  if(e.offsetY == 1){
            for(var i = 0; i < arrayNum.length; i++){
                for(var j = 0; j < arrayNum[i].length; j ++){
                    if(arrayNum[i][j].number == 9 && i > 0){
                        var x = arrayNum[i - 1][j].x;
                        var y = arrayNum[i - 1][j].y;
                        var obj:SingleCardNum = arrayNum[i][j];
                        TweenLite.to(arrayNum[i - 1][j], 0.3, {y: arrayNum[i][j].y});
                        arrayNum[i][j].x = x;
                        arrayNum[i][j].y = y;
                        arrayNum[i][j] = arrayNum[i - 1][j];
                        arrayNum[i - 1][j] = obj;
                        setMoveFalse();
                        setMovePosible();
                        stepCount++;
                        textCount.text = stepCount.toString();
                        moveSound.play();
                        isWin(arrayNum.length);
                        return;
                    }
                }
            }
        } else if(e.offsetY == -1){
            for(var i = 0; i < arrayNum.length; i++){
                for(var j = 0; j < arrayNum[i].length; j ++){
                    if(arrayNum[i][j].number == 9 && i < arrayNum.length - 1){
                        var x = arrayNum[i + 1][j].x;
                        var y = arrayNum[i + 1][j].y;
                        var obj:SingleCardNum = arrayNum[i][j];
                        TweenLite.to(arrayNum[i + 1][j], 0.3, {y: arrayNum[i][j].y});
                        arrayNum[i][j].x = x;
                        arrayNum[i][j].y = y;
                        arrayNum[i][j] = arrayNum[i + 1][j];
                        arrayNum[i + 1][j] = obj;
                        setMoveFalse();
                        setMovePosible();
                        stepCount++;
                        textCount.text = stepCount.toString();
                        moveSound.play();
                        isWin(arrayNum.length);
                        return;
                    }
                }
            }
        }
    }

    var highScore:Array = [];

    public function isWin(level:Number):void{
        if(checkResult()){
            tadaSound.play();

            var bg:Bitmap = new BGWIn();
            bg = SDUtils.getFitImage(bg, Consts.GAME_WIDTH, Consts.GAME_HEIGHT);
            addChild(bg);
            timerTextField.visible = false;

            var btnHome:DisplayObject = new homeBtn();
            btnHome.scaleY = btnHome.scaleX = .9;
            btnHome.x = bg.x + 50;
            btnHome.y = bg.y + 50;
            addChild(btnHome);

            var homeSprite:Sprite= new Sprite();
            homeSprite.graphics.clear();
            homeSprite.graphics.beginFill(0xFFFFFF, 0);
            homeSprite.graphics.drawRoundRect(btnHome.x, btnHome.y, btnHome.width, btnHome.height,0,0);
            homeSprite.graphics.endFill();
            addChild(homeSprite);
            homeSprite.addEventListener(MouseEvent.CLICK, backHome);

            var score:String;
            var isHighScore = false;
            if(level == 3){
                highScore[0] = Number(timerTextField.text);
                if(Number(highScore[0]) > Number(getLocalStorage("hs1"))){
                    saveLocalStorage("hs1", highScore[0].toString());
                    isHighScore = true;
                }
                score = highScore[0];
            } else if(level == 4){
                highScore[1] = Number(timerTextField.text);
                if(Number(highScore[1]) > Number(getLocalStorage("hs1"))){
                    saveLocalStorage("hs2", highScore[1].toString());
                    isHighScore = true;
                }
                score = highScore[1];
            } else if(level == 5){
                highScore[2] = Number(timerTextField.text);
                if(Number(highScore[2]) > Number(getLocalStorage("hs2"))){
                    saveLocalStorage("hs3", highScore[2].toString());
                    isHighScore = true;
                }
                score = highScore[2];
            }
            var textScore:TextField = new TextField();
            var formatText:TextFormat = new TextFormat();
            formatText.size = 60;
            formatText.color = 0xff7300;
            formatText.font = "M54font";
            textScore.embedFonts = true;
            textScore.defaultTextFormat = formatText;
            textScore.autoSize = TextFieldAutoSize.CENTER;
            textScore.x = bg.x + (bg.width - textScore.width)/2;
            textScore.y = bg.y + bg.height - 100;

            var textScore2:TextField = new TextField();
            textScore2.embedFonts = true;
            textScore2.defaultTextFormat = formatText;
            textScore2.autoSize = TextFieldAutoSize.CENTER;

            if(isHighScore){
                formatText.color = 0xf50000;
                textScore.text = isHighScore ? "YOU REACHED A NEW HIGH SCORE" : "";
                addChild(textScore);
            }

            textScore2.text = score;
            textScore2.x = bg.x + (bg.width - textScore2.width)/2 + 50;
            textScore2.y = bg.y + bg.height / 2 + 85;
            addChild(textScore2);


        }
    }

    function checkResult():Boolean{
        var index:Number = 1;
        for(var i = 0; i < arrayNum.length; i++){
            for(var j = 0; j < arrayNum[i].length; j ++){
                if(arrayNum[i][j].number == index){
                    index++;
                }
            }
        }
        if(index == 10){
            return true;
        }
        return false;
    }

    var timerTextField:TextField = new TextField();
    var timeSprite:DisplayObject = new timeSpriteImg();
    public var myTimer:Timer = new Timer(0);

    public function timer():void {
        timeSprite.visible = true;
        timerTextField.visible = true;
        myTimer.reset();
        myTimer.delay = delay;
        myTimer.repeatCount = time;
        runClock(time);

        function runClock(a:int):void {
            myTimer.addEventListener(TimerEvent.TIMER, onTimer);
            myTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onComplete);
            myTimer.start();
            var tf:TextFormat = new TextFormat();
            tf.size = 55;
            tf.bold = true;
            tf.font = "M54font";
            tf.color = 0xf2b124;
            tf.align = "center";
            timerTextField.embedFonts = true;
            timerTextField.width = timeSprite.width;
            timerTextField.height = 55;
            timeSprite.scaleX = timeSprite.scaleY = 1;
            addChild(timeSprite);

            function onTimer(e:TimerEvent):void {
                timerTextField.text = String(myTimer.repeatCount - myTimer.currentCount);         //Seconds
                timerTextField.setTextFormat(tf);
                addChild(timerTextField);
            }

            function onComplete(e:TimerEvent):void {
                myTimer.reset();
                isLose();
            }
        }
    }

    public function isLose():void{
        var bg:Bitmap = new BGLose();
        bg = SDUtils.getFitImage(bg, Consts.GAME_WIDTH, Consts.GAME_HEIGHT);
        addChild(bg);

        var btnHome:DisplayObject = new homeBtn();
        btnHome.scaleY = btnHome.scaleX = .9;
        btnHome.x = bg.x + 50;
        btnHome.y = bg.y + 50;
        addChild(btnHome);

        var homeSprite:Sprite= new Sprite();
        homeSprite.graphics.clear();
        homeSprite.graphics.beginFill(0xFFFFFF, 0);
        homeSprite.graphics.drawRoundRect(btnHome.x, btnHome.y, btnHome.width, btnHome.height,0,0);
        homeSprite.graphics.endFill();
        addChild(homeSprite);

        var btnReload:DisplayObject = new reloadBtn();
        btnReload.scaleY = btnReload.scaleX = .9;
        btnReload.x = bg.x + bg.width - btnReload.width - 50;
        btnReload.y = btnHome.y;
        addChild(btnReload);

        var replaySprite:Sprite = new Sprite();
        replaySprite.graphics.clear();
        replaySprite.graphics.beginFill(0xFFFFFF, 0);
        replaySprite.graphics.drawRoundRect(btnReload.x, btnReload.y, btnReload.width, btnReload.height,0,0);
        replaySprite.graphics.endFill();
        addChild(replaySprite);

        if(isLevel1){
            replaySprite.addEventListener(MouseEvent.CLICK, onInitGameLv1);
        } else if(isLevel2){
            replaySprite.addEventListener(MouseEvent.CLICK, onInitGameLv2);
        } else if(isLevel3){
            replaySprite.addEventListener(MouseEvent.CLICK, onInitGameLv3);
        }

    }


    private function shuffleArray(input:Array):void {
        for (var i:int = input.length-1; i >=0; i--)
        {
            var randomIndex:int = Math.floor(Math.random()*(i+1));
            var itemAtIndex:Object = input[randomIndex];
            input[randomIndex] = input[i];
            input[i] = itemAtIndex;
        }
    }

    public static function saveLocalStorage(k:String, v:String):void {
        var bytes:ByteArray = new ByteArray();
        bytes.writeUTFBytes(v);
        EncryptedLocalStore.setItem(k, bytes);
    }

    public static function getLocalStorage(k:String):* {
        var storedValue:ByteArray = EncryptedLocalStore.getItem(k);
        if (storedValue != null) {
            return storedValue.readUTFBytes(storedValue.length)
        } else {
            return null;
        }
    }
}
}