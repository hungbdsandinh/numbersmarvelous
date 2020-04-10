package com.example.HexagonNumberMatrix {

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.PixelSnapping;
import flash.geom.Matrix;
import flash.geom.Rectangle;

public class SDUtils {
    public static function getFitImage(object:DisplayObject,
                                       toWidth:Number,
                                       toHeight:Number,
                                       isCenter:Boolean = true,
                                       isFillBox:Boolean = true):Bitmap {

        var tempW:Number = object.width;
        var tempH:Number = object.height;

        object.width = toWidth;
        object.height = toHeight;

        var scale:Number = (isFillBox) ? Math.max(object.scaleX, object.scaleY) :
                Math.min(object.scaleX, object.scaleY);

        object.width = tempW;
        object.height = tempH;

        var scaleBmpd:BitmapData = new BitmapData(object.width * scale, object.height * scale);
        var scaledBitmap:Bitmap = new Bitmap(scaleBmpd, PixelSnapping.ALWAYS, true);
        var scaleMatrix:Matrix = new Matrix();
        scaleMatrix.scale(scale, scale);
        scaleBmpd.draw(object, scaleMatrix);

        if (scaledBitmap.width > toWidth || scaledBitmap.height > toHeight) {

            var cropMatrix:Matrix = new Matrix();
            var cropArea:Rectangle = new Rectangle(0, 0, toWidth, toHeight);

            var croppedBmpd:BitmapData = new BitmapData(toWidth, toHeight);
            var croppedBitmap:Bitmap = new Bitmap(croppedBmpd, PixelSnapping.ALWAYS, true);

            if (isCenter) {
                var offsetX:Number = Math.abs((toWidth - scaleBmpd.width) / 2);
                var offsetY:Number = Math.abs((toHeight - scaleBmpd.height) / 2);

                cropMatrix.translate(-offsetX, -offsetY);
            }

            croppedBmpd.draw(scaledBitmap, cropMatrix, null, null, cropArea, true);
            return croppedBitmap;

        } else {
            return scaledBitmap;
        }
    }
}
}