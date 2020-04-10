package CustomData {
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

public class AnswerList extends Sprite{
    [Embed(source="/font/Franklin M54.ttf",
            fontName="M54font",
            mimeType = "application/x-font",
            fontWeight="normal",
            fontStyle="normal",
            advancedAntiAliasing="true",
            embedAsCFF="false")]
    public const M54_font:Class;

    [Embed(source='../com/nsm/numbersm/art_newpuz/play/do.png')]
    public const cardNum:Class;

    public var imgCardNum: Bitmap = new Bitmap();
    public var number: Number;
    public var text: TextField = new TextField();
    public function AnswerList(num:Number) {
        imgCardNum = new cardNum();
        this.number = num;
        addChild(imgCardNum);

        var formatText:TextFormat = new TextFormat();
        formatText.size = 60;
        formatText.color = 0xd9d9d9;
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
