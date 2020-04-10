package CustomData {
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

public class SingleCardNum extends Sprite{
    [Embed(source="/font/Franklin M54.ttf",
            fontName="M54font",
            mimeType = "application/x-font",
            fontWeight="normal",
            fontStyle="normal",
            advancedAntiAliasing="true",
            embedAsCFF="false")]
    public const M54_font:Class;

    public var canMoveLeft:Boolean = false;
    public var canMoveRight:Boolean = false;
    public var canMoveUp:Boolean = false;
    public var canMoveDown:Boolean = false;
    [Embed(source='../com/nsm/numbersm/art_newpuz/play/xanh.png')]
    public const cardNum:Class;

    public var imgCardNum: Bitmap = new Bitmap();
    public var number: Number;
    public var text: TextField = new TextField();
    public function SingleCardNum(num:Number) {
        imgCardNum = new cardNum();
        addChild(imgCardNum);
        this.number = num;
        var formatText:TextFormat = new TextFormat();
        formatText.size = 110;
        formatText.color = 0xffffff;
        formatText.font = "M54font";
        text.embedFonts = true;
        text.defaultTextFormat = formatText;
        text.autoSize = TextFieldAutoSize.CENTER;
        text.text = this.number.toString();
        text.setTextFormat(formatText);
        text.mouseEnabled = false;
        text.x = (imgCardNum.width - text.width)/2;
        text.y = (imgCardNum.height - text.height)/2 -3;

        addChild(text);
        buttonMode = true;
    }
}
}
